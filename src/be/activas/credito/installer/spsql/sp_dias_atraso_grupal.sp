/****************************************************************/
/*   ARCHIVO:         	sp_dias_atraso_grupal.sp		        */
/*   NOMBRE LOGICO:   	sp_dias_atraso_grupal       			*/
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
/*   Este procedimiento permite obtener la el numero de ciclo   */
/*   de un cliente                                              */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   11-May-2017   Sonia Rojas  Emision Inicial.     	        */
/*   May/2020      ACH          Caso: 139932                    */
/*   01-May-2020   ACH          Caso: 139932-doble desplazam    */
/*   08-Jul-2020   ACH          Caso:139932 dias_360 calcul+1dia*/
/*   10/Nov/2020   DCU          Mejoras                         */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_dias_atraso_grupal')
   drop proc sp_dias_atraso_grupal
go

create proc [dbo].[sp_dias_atraso_grupal](
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
		@w_max_cuotas_vencidas	  	int,
		@w_fecha_proceso            datetime,
		@w_existe_feriado           char,
		@w_ciudad_nacional          int,
		@w_fecha_ven                DATETIME,
		@w_max_diff_act				int,
		@w_max_cuotas_vencidas_act  int,
		@w_fecha_ini_desp           datetime,
		@w_ant_habil                datetime,
		@w_est_cancelado            int,
		@w_est_vencido              int,
		@w_fecha_primer_desplaz     datetime,
        @w_act_dias_antes_dsp       char(1)
		
declare @w_toperaciones				table(operacion int)
		
select @w_sp_name = 'sp_dias_retraso_grupal'

select @w_fecha_ini_desp = '01/01/1900'
select @w_fecha_primer_desplaz = dateadd(dd,-1, '05/01/2020') -- Por que la fecha del primer desplazamiento se quita un 1
print '@w_fecha_primer_desplaz: ' + convert(varchar,@w_fecha_primer_desplaz)

select @w_act_dias_antes_dsp = pa_char from cobis..cl_parametro where pa_producto = 'CCA' AND pa_nemonico = 'AN31DS'--Activar el calculo de 3 dias menos para el primer desplazamiento Activar = S, desactivar N. Caso #139932

select @w_nro_ciclo_grupal_ant = (gr_num_ciclo + 1 ) - @i_ciclos_ant,
	   @w_nro_ciclo_grupal_act = gr_num_ciclo + 1
  from cobis..cl_grupo
 where gr_grupo = @i_grupo

/* ESTADOS DE CARTERA */
exec @w_error = cob_cartera..sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_vencido    = @w_est_vencido out
 
print '@w_nro_ciclo_grupal_ant retraso: '+ convert(varchar, @w_nro_ciclo_grupal_ant)
print '@w_nro_ciclo_grupal_act retraso: '+ convert(varchar, @w_nro_ciclo_grupal_act)

--Encuentro la fecha de proceso
SELECT @w_fecha_proceso=fp_fecha FROM cobis..ba_fecha_proceso 

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @i_es_ciclo_ant = 'N' and (@w_nro_ciclo_grupal_act = 1 or @w_nro_ciclo_grupal_act = 2)
begin
	select @o_resultado = 0
	return 0
end

if @i_es_ciclo_ant = 'S' and @w_nro_ciclo_grupal_act = 1 
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
     where di_operacion = @w_min_operacion

		
	insert into @w_toperaciones
	select dc_operacion 
	  from cob_cartera.. ca_det_ciclo,
	       cob_credito..cr_tramite_grupal
	 where dc_ciclo_grupo = @w_nro_ciclo_grupal_ant
	   and dc_grupo 	  = @i_grupo
	   and dc_operacion   = tg_operacion
	   and tg_monto          > 0
	   		  
    SELECT @w_max_diff_act=0
    SELECT @w_max_cuotas_vencidas_act=0;

    --------Caso #139932 doble desplazamiento Ini
    select d.*
      into #desplazamiento
      from cob_cartera..ca_desplazamiento d, @w_toperaciones
     where operacion  = de_operacion
       and de_estado  = 'A'
       and de_archivo <> 'WORKFLOW'

    -- del consolidador para calculo de días max de atraso act
    if ( @w_act_dias_antes_dsp = 'S' )
    begin
        select distinct
         fecha_ini_desp       = de_fecha_ini, 
         fecha_ini_desp_habil = de_fecha_ini
          into #fechas_ini_desplazamiento
          from #desplazamiento
         where de_fecha_ini <= @w_fecha_primer_desplaz
            
        while 1 = 1 begin
            select top 1 @w_fecha_ini_desp = fecha_ini_desp 
            from #fechas_ini_desplazamiento
            where fecha_ini_desp > @w_fecha_ini_desp
            order by fecha_ini_desp asc
            
            if @@rowcount = 0 break 
            
            select @w_ant_habil = dateadd(dd, -1, @w_fecha_ini_desp )
	        
            while exists (select 1
                          from cobis..cl_dias_feriados
                          where df_fecha   = @w_ant_habil
                          and   df_ciudad  = @w_ciudad_nacional)
            begin
               select @w_ant_habil = dateadd(dd, -1, @w_ant_habil)
            end
 
            update #fechas_ini_desplazamiento set 
            fecha_ini_desp_habil = @w_ant_habil
            where fecha_ini_desp = @w_fecha_ini_desp           
        end
	    
        update #desplazamiento set 
        de_fecha_ini = fecha_ini_desp_habil
        from #fechas_ini_desplazamiento
        where de_fecha_ini = fecha_ini_desp
    end
    select de_operacion,    de_fecha_ini, 
           dias = case when de_fecha_fin>= @w_fecha_proceso then
                  datediff(dd,de_fecha_ini, @w_fecha_proceso)
                  else 
                  datediff(dd,de_fecha_ini, de_fecha_fin) end
    into #dias_restar            
    from #desplazamiento, @w_toperaciones
    where de_operacion = operacion
      and de_estado    = 'A'
   
------------------------------------- para operaciones vencidas	
    select op_banco,     di_operacion,
           dias_360      = datediff(dd, isnull(min(di_fecha_ven),@w_fecha_proceso), @w_fecha_proceso),
           fecha_ven_ini = min(di_fecha_ven),
           dias_restar   = convert(int,0)
    into #operaciones_vencida
    from cob_cartera..ca_dividendo, @w_toperaciones, cob_cartera..ca_operacion
    where di_operacion = operacion
    and   di_estado    = @w_est_vencido
	  and operacion    = op_operacion
    group by op_banco, di_operacion
	
    update #operaciones_vencida 
	   set dias_360 = 0
     where dias_360 < 0
				 
    select de_operacion, 
	       dias = sum(dias)
    into #reales
    from #operaciones_vencida, #dias_restar
    where de_operacion   = di_operacion
    and   fecha_ven_ini <= de_fecha_ini
    group by de_operacion

    update #operaciones_vencida
    set dias_restar= dias
    from #reales
    where di_operacion = de_operacion
 
    select op_banco,
           di_operacion,
           dias_360 = dias_360 - isnull(dias_restar,0)
    into #operaciones_vencidas_act
    from #operaciones_vencida
	
------------------------------------- para operaciones canceladas
    select op_banco    ,    di_dividendo,    di_operacion,     
	       di_fecha_ven,    di_fecha_can,    dias_atraso   = datediff(dd, di_fecha_ven, di_fecha_can)
     into #operaciones_canceladas
     from cob_cartera..ca_dividendo, @w_toperaciones, cob_cartera..ca_operacion
    where di_operacion = operacion
      and di_estado    = @w_est_cancelado
	  and di_operacion = op_operacion
      and di_fecha_can > di_fecha_ven

    select op_banco, de_operacion, dividendo = di_dividendo,
           calculo = sum(case when di_fecha_can > de_fecha_fin AND di_fecha_ven < de_fecha_ini then datediff(dd, de_fecha_ini,de_fecha_fin)
                              when di_fecha_can <= de_fecha_fin AND di_fecha_ven < de_fecha_ini then datediff(dd, de_fecha_ini,di_fecha_can)
                         else 0 end )
     into #actualizar_dividendo                
     from #desplazamiento, #operaciones_canceladas  
    where de_operacion = di_operacion	  
      and di_operacion = de_operacion 
      and di_fecha_can > de_fecha_ini
	  and di_fecha_can >= de_fecha_ini
    group by op_banco, de_operacion, di_dividendo

    update #operaciones_canceladas 
	   set dias_atraso = dias_atraso - calculo
    from #actualizar_dividendo
    where di_operacion = de_operacion
      and di_dividendo = dividendo

    update #operaciones_canceladas 
	   set dias_atraso =0
     where dias_atraso < 0

    ----------Para obtener el maximo
    create table #dias_maximo_atraso_grupal(banco cuenta, numero_maximo int)
    
    insert into #dias_maximo_atraso_grupal (banco, numero_maximo)
    select op_banco, max(dias_360)
      from #operaciones_vencidas_act
     group by op_banco

    insert into #dias_maximo_atraso_grupal (banco, numero_maximo)
    select op_banco, max(dias_atraso)
      from #operaciones_canceladas
     group by op_banco
    
	select @w_total_retraso = max(numero_maximo) 
	  from #dias_maximo_atraso_grupal 

    if (@w_total_retraso < 0)	
    begin
        select @w_total_retraso = 0
    end	
    --------Caso #139932 doble desplazamiento Fin

	select @o_resultado = isnull(@w_total_retraso,0)
	
	print convert(varchar,'sin while @o_resultado-w_total_retraso:', @o_resultado)

    /* Se setea a 4 para validar pruebas */
 --   select @w_total_retraso = 4
 update cobis..cl_grupo
    set    gr_dias_atraso = isnull(@w_total_retraso,0)
    where gr_grupo = @i_grupo 

        IF(@w_total_retraso=0)
	BEGIN
        print '---->> sp_dias_atraso_grupal: @o_resultado es 0: '+ convert(varchar, @o_resultado) + '-Cliente:'+convert(varchar, @i_grupo)
	select @o_resultado=0
	return 0
	END
    
	select @o_resultado = isnull(@w_total_retraso,0)
    
	print '---->> sp_dias_atraso_grupal: @o_resultado: '+ convert(varchar, @o_resultado) + '-Cliente:'+convert(varchar, @i_grupo)
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
go