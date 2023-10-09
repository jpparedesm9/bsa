/****************************************************************/
/*   ARCHIVO:         	sp_var_doble_autorizacion.sp            */
/*   NOMBRE LOGICO:   	sp_var_doble_autorizacion               */
/*   PRODUCTO:              CARTERA                             */
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
/*                     PROPOSITO                                */
/*   Número de operaciones grupales que ha tenido este grupo    */
/*   en la SOFOME más 1, es decir, si este es el primer         */
/*   préstamo grupal que solicita el grupo esta variable        */
/*   debe ser 1.                                                */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                    */
/*   11-May-2017   Sonia Rojas        Emision Inicial.          */
/*   10-Ene-2022   ACH            REQ#192175 Doble AutorizaciOn */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_doble_autorizacion')
   drop proc sp_var_doble_autorizacion
go

create proc [dbo].[sp_var_doble_autorizacion](
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int = null,
	@s_user             varchar(30) = null,
	@s_sesn             int = null,
	@s_term             varchar(30) = null,
	@s_date             datetime = null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint = null,
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
@w_sp_name 				varchar(64),
@w_error				int,
@w_ente				    int,
@w_tramite              int,
@w_toperacion           varchar(30),
@w_cliente              int,
@w_ciclo                int,
@w_monto                money,
@w_resultado			varchar(255),
@w_asig_actividad 		int,		
@w_valor_ant      		varchar(255),
@w_valor_nuevo    		varchar(255),
@w_valor_variable_regla varchar(255),
@w_oficina              int
		
select @w_sp_name = 'sp_var_doble_autorizacion'

select 
@w_ente  		        = io_campo_1,
@w_tramite              = io_campo_3,
@w_toperacion           = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc 	= @i_id_inst_proc

if @w_tramite is null or @w_tramite = 0 return 0

select @w_oficina = tr_oficina from cob_credito..cr_tramite where tr_tramite = @w_tramite

select @w_resultado = 'SI'

if @w_toperacion = 'GRUPAL' begin
   select @w_ciclo = gr_num_ciclo
   from cobis..cl_grupo
   where gr_grupo  = @w_ente
   
   select @w_cliente = 0 
   
   while 1 = 1 begin 
      select top 1 
	  @w_cliente        = tg_cliente,
	  @w_monto          = tg_monto
      from cob_credito..cr_tramite_grupal
      where tg_tramite  = @w_tramite 
	  and   tg_cliente  > @w_cliente
	  order by tg_cliente asc
	  
	  if @@rowcount = 0 break	  
	  
	  select @w_valor_variable_regla = convert(varchar, @w_oficina) + '|' + convert(varchar, (isnull(@w_ciclo,0)+1)) + '|'+convert(varchar,@w_monto)
	  
	  exec @w_error            = cob_cartera..sp_ejecutar_regla
      @s_ssn                   = @s_ssn,
      @s_ofi                   = @s_ofi,
      @s_user                  = @s_user,
      @s_date                  = @s_date,
      @s_srv                   = @s_srv,
      @s_term                  = @s_term,
      @s_rol                   = @s_rol,
      @s_lsrv                  = @s_lsrv,
      @s_sesn                  = @s_sesn,
      @i_regla                 = 'DBLAUT', 	 
      @i_valor_variable_regla  = @w_valor_variable_regla,
	  @i_tipo_ejecucion        = 'REGLA',
      @o_resultado1            = @w_resultado out
	  
	  if @w_error <> 0 return @w_error
	  
	  if @w_resultado = 'NO' break
   end

end else if @w_toperacion = 'INDIVIDUAL' begin
   select @w_ciclo     = count(op_operacion)
   from cob_cartera..ca_operacion
   where op_cliente    = @w_ente
   and   op_toperacion = 'INDIVIDUAL'
   
   select @w_monto     = tr_monto
   from cob_credito..cr_tramite
   where tr_tramite    = @w_tramite
   
   select @w_valor_variable_regla = convert(varchar, @w_oficina) + '|' + convert(varchar, (isnull(@w_ciclo,0)+1)) + '|'+convert(varchar,@w_monto)
	     
   exec @w_error            = cob_cartera..sp_ejecutar_regla
   @s_ssn                   = @s_ssn,
   @s_ofi                   = @s_ofi,
   @s_user                  = @s_user,
   @s_date                  = @s_date,
   @s_srv                   = @s_srv,
   @s_term                  = @s_term,
   @s_rol                   = @s_rol,
   @s_lsrv                  = @s_lsrv,
   @s_sesn                  = @s_sesn,
   @i_regla                 = 'DBLAUT', 	 
   @i_valor_variable_regla  = @w_valor_variable_regla,
   @i_tipo_ejecucion        = 'REGLA',
   @o_resultado1            = @w_resultado out
   
   if @w_error <> 0 return @w_error
end


select @w_valor_nuevo = @w_resultado

if @t_debug = 'S'
begin
	print '@w_valor_nuevo: ' + convert(varchar, @w_valor_nuevo )	
end

-- valor anterior de variable tipop en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
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
return 0
go
