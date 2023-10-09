/****************************************************************/
/*   ARCHIVO:         	sp_dias_atraso_can_grupal.sp		    */
/*   NOMBRE LOGICO:   	sp_dias_atraso_can_grupal       		*/
/*   PRODUCTO:        		CARTERA                             */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*                                                              */
/*	Se obtiene de sumar los siguientes valores:                 */
/*  - Número de ciclos que el cliente haya tenido en otras      */
/*    entidades                                                 */
/*  - Número de préstamos individuales que el cliente haya      */
/*    terminado de pagar (CANCELADAS) que la persona tenga en la*/
/*	  entidad, sin importar si es en este grupo o si son        */
/*	  créditos grupales o individuales.                         */
/*  - Mas UNO, es decir, si este es el primer crédito que       */
/*	  solicita esta persona, este variable debe valer UNO.      */
/*                                                              */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA            AUTOR               RAZON                	*/
/*   20-Abril-2018   Patricio Samueza     Emision Inicial.      */
/****************************************************************/

USE cob_credito
go
IF OBJECT_ID ('dbo.sp_dias_atraso_can_grupal') IS NOT NULL
	DROP PROCEDURE dbo.sp_dias_atraso_can_grupal
GO

create proc [dbo].[sp_dias_atraso_can_grupal](
	@t_debug       		char(1)     = 'N',
	@t_file        		varchar(14) = null,
	@t_from        		varchar(30) = null,
    @i_grupo			int,
	@i_ciclos_ant		int,
	@i_es_ciclo_ant     char,
	@o_resultado    	int  out
)
as
declare	@w_sp_name 					varchar(64),
		@w_error					int,
		@w_grupo					int,
		@w_num_prestamos			int,
		@w_estado					int,
		@w_nro_ciclo_grupal_ant	    int,
		@w_nro_ciclo_grupal_act		int,
		@w_codigo_estado			int,
		@w_plazo					int,
		@w_max_diff					int,
		@w_total_retraso			int,
		@w_dividendo           		int,
		@w_rowcount            		int,
		@w_num_operaciones          int,
		@w_min_operacion            int,
		@w_max_cuotas_vencidas	  	INT,
		@w_fecha_proceso            DATETIME,
		@w_existe_feriado           CHAR,
		@w_ciudad_nacional          INT,
		@w_fecha_ven                DATETIME,
		@w_di_estado                INT,
		@w_fecha_can                DATETIME,
		@w_grp_operation            int
		
declare @w_toperaciones				table(operacion int)
		
select @w_sp_name = 'sp_dias_atraso_can_grupal'

select @w_nro_ciclo_grupal_ant = (gr_num_ciclo + 1 ) - @i_ciclos_ant,
	   @w_nro_ciclo_grupal_act = gr_num_ciclo + 1
  from cobis..cl_grupo
 where gr_grupo = @i_grupo
 
 
print '@w_nro_ciclo_grupal_ant cancelacion: '+ convert(varchar, @w_nro_ciclo_grupal_ant)
print '@w_nro_ciclo_grupal_act cancelacio: '+ convert(varchar, @w_nro_ciclo_grupal_act)

--Encuentro la fecha de proceso
select @w_fecha_proceso=fp_fecha FROM cobis..ba_fecha_proceso 

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @w_nro_ciclo_grupal_act = 1 
begin
	select @o_resultado = 0
	return 0
end
	

if @w_nro_ciclo_grupal_ant = -1
begin
	select @o_resultado = 0
	return 0
end
else 
begin

	select @w_dividendo = 1
	select @w_total_retraso = 0
	
	select @w_num_operaciones = count(dc_operacion),
		   @w_min_operacion   = min(dc_operacion)
	  from cob_cartera.. ca_det_ciclo,
	       cob_credito..cr_tramite_grupal
	 where dc_ciclo_grupo 	  = @w_nro_ciclo_grupal_ant
	   and dc_grupo 	      = @i_grupo
	   and dc_operacion       = tg_operacion
	   and tg_monto           > 0

	
	--Se toma el plazo de una de las operaciones individuales del ciclo grupal
	select @w_plazo 	= count(di_dividendo) 
	  from cob_cartera..ca_dividendo
     where di_operacion =  @w_min_operacion/*(select distinct op_operacion
							  from cob_cartera..ca_operacion,
							       cob_credito..cr_tramite_grupal
						     where op_tramite   = tg_tramite
							   and tg_operacion  = @w_min_operacion
							   and tg_participa_ciclo = 'S')*/

		
	insert into @w_toperaciones
	select dc_operacion 
	     from cob_cartera.. ca_det_ciclo,
	          cob_credito..cr_tramite_grupal
	    where dc_ciclo_grupo 	= @w_nro_ciclo_grupal_ant
	      and dc_grupo 			= @i_grupo
	      and dc_operacion       = tg_operacion
	      and tg_monto           > 0
	    
	--obtengo la primera fecha de vencimiento del ultimo plazo      
   select top 1  @w_fecha_ven  =  di_fecha_ven
	          from cob_cartera..ca_dividendo
		      where  di_operacion in (select operacion from @w_toperaciones)
		      and di_dividendo =@w_plazo
		      
		   --and di_dividendo =  @w_dividendo-- se comenta por que se cije soo la ultima cuota
		   
		   
		   --Verifico que la fecha de vencimiento no sea un dia Feriado 
		   
	       select @w_existe_feriado = 'N'

           while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_ven) 
             begin
                   select @w_fecha_ven = dateadd(dd, 1, @w_fecha_ven)
                   select @w_existe_feriado = 'S'
                   
             end 
                
                
            if @w_existe_feriado ='N'
             begin
               
             	select @w_fecha_ven  
             		
             end
            
           PRINT'4'+convert(VARCHAR(50),@w_fecha_ven)	      

	     --SELECT * FROM @w_toperaciones

		   select @w_max_diff = 0
		   
		     select TOP 1  @w_di_estado  =  di_estado,
		              @w_fecha_can  =  di_fecha_can
	          from cob_cartera..ca_dividendo
		      where  di_operacion in (select operacion from @w_toperaciones)
		      and di_dividendo =@w_plazo
		      
		
		   
           --Fecha de consulta es menor que la fecha de vencimiento
           if(@w_fecha_proceso<@w_fecha_ven)
		     begin
		   
		        PRINT'Fecha de consulta es menor que la fecha de vencimiento'
		        select @o_resultado = 0
		        return 0
		        
		     end
		   else
		     begin
		       if(@w_di_estado=3)--Si la fecha en que evaluamos la regla es mayor a la fecha de vencimiento del préstamo y este está cancelado
		         begin
		           
		          select 	@w_max_diff              = max (case when datediff(dd, @w_fecha_ven, di_fecha_can) < 0 
		                                then 0 
						                        else datediff(dd, @w_fecha_ven, di_fecha_can)
					                            end)                
	                from cob_cartera..ca_dividendo
		            where di_operacion in (select operacion from @w_toperaciones)
		            and di_dividendo =@w_plazo	
				  PRINT'@w_max_diff di estado !3'+ convert(VARCHAR(50),@w_max_diff) 
		         end
		      else
		       begin
		        if(@w_di_estado!=3)--Si la fecha en que evaluamos la regla es mayor a la fecha de vencimiento del préstamo y este NO está cancelado
		        begin
		      		           select 	@w_max_diff              = max (case when datediff(dd, @w_fecha_ven, @w_fecha_proceso) < 0 
		                                then 0 
						                        else datediff(dd, @w_fecha_ven, @w_fecha_proceso)
					                            end)                
	                from cob_cartera..ca_dividendo
		            where di_operacion in (select operacion from @w_toperaciones)
		            and di_dividendo =@w_plazo	
		            
					                
					PRINT'@w_max_diff di estado !3'+ convert(VARCHAR(50),@w_max_diff)
		 
		    
		        end
		       end
		     end         
		  
		   
				
	
		--print '@w_dividendo: '+convert(varchar, @w_dividendo) + ', @w_max_diff: '+ convert(varchar, @w_max_diff)
		select @w_total_retraso = @w_total_retraso + isnull(@w_max_diff,0)
			
     PRINT'NUM DIAS SP ATRASO CANCELACION GRP'+ convert(VARCHAR(50),@w_total_retraso)
	select @o_resultado = isnull(@w_total_retraso,0)
    
	return 0
end


	
	
if @o_resultado is null
begin
   select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
   exec   @w_error  = cobis..sp_cerror
          @t_debug  = 'N',
          @t_file   = '',
          @t_from   = @w_sp_name,
          @i_num    = @w_error
   return @w_error
end

return 0

GO

