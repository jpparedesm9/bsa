/****************************************************************/
/*   ARCHIVO:         	sp_var_ciclos_clientes.sp	     	    */
/*   NOMBRE LOGICO:   	sp_var_ciclos_clientes           		*/
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
/*   FECHA         AUTOR               RAZON                	*/
/*   07-ABR-2020   Sonia Rojas        Emision Inicial.     	    */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_ciclos_clientes')
   drop proc sp_var_ciclos_clientes
go

create proc [dbo].[sp_var_ciclos_clientes](
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int,
	@s_user             varchar(30),
	@s_sesn             int,
	@s_term             varchar(30),
	@s_date             datetime,
	@s_srv              varchar(30),
	@s_lsrv             varchar(30),
	@s_ofi              smallint,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_rty              char(1)     = null,
	@t_trn				int = null,
	@t_show_version     BIT = 0,
    @i_id_inst_proc    	int,    --codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint
)
as
declare	
@w_sp_name 				   varchar(64),
@w_valor_ant      		   varchar(255),
@w_valor_nuevo    		   varchar(255),
@w_valor_actual			   varchar(10),
@w_grupo				   int,
@w_ente                    int           = 0,
@w_clientes_ciclo_0        varchar(255)  = '',
@w_param_clientes_nuevos   char(1)


select @w_param_clientes_nuevos = isnull(pa_char,'N')
from  cobis..cl_parametro 
where pa_nemonico = 'CLNUSG'
and   pa_producto = 'CRE'

if @w_param_clientes_nuevos = 'S'  begin

   select @w_grupo       = io_campo_1
   from cob_workflow..wf_inst_proceso
   where io_id_inst_proc = @i_id_inst_proc
   
   if @w_grupo = 0 or @w_grupo is null return 0
   
   while (1=1) begin
      select top 1 @w_ente = cg_ente 
      from cobis..cl_cliente_grupo
      where cg_grupo       = @w_grupo
      and   cg_estado      = 'V'
      and   cg_ente        > @w_ente
      order by cg_ente asc
      
      if @@rowcount = 0 break
      
      if (select isnull(en_nro_ciclo,0) from cobis..cl_ente where en_ente = @w_ente) = 0 begin
         select @w_clientes_ciclo_0 = @w_clientes_ciclo_0 + '-'+ convert(varchar(10),@w_ente)
      end
      
   end
end

if len(@w_clientes_ciclo_0) = 0 begin
   select @w_valor_nuevo = ''
end else begin
   select @w_valor_nuevo = 'LOS CLIENTES: ' + @w_clientes_ciclo_0 + ' ESTAN EN CICLO 0'
end


--insercion en estrucuturas de variables

if @i_id_asig_act is null
  select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
			
	if @@error > 0
	begin
            --registro ya existe
			
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end 

END

return 0
go

