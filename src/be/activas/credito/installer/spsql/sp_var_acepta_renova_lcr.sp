/************************************************************************/
/*  Archivo:                sp_var_acepta_renova_lcr.sp                  */
/*  Stored procedure:       sp_var_acepta_renova_lcr                     */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Paul Ortiz Vera                             */
/*  Fecha de Documentacion: 29/Ene/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Determina si el cliente quiere o no una renovación de una Linea de  */
/*  Credito Revolvente                                                  */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/*29/Ene/2019  P. Ortiz Vera           Emision Inicial                  */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_acepta_renova_lcr')
	drop proc sp_var_acepta_renova_lcr
go


create proc sp_var_acepta_renova_lcr(
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
	@t_trn				int 		= null,
	@t_show_version     bit 		= 0,
    @i_id_inst_proc    	int,    --codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint
)
as
declare	@w_sp_name 			varchar(64),
		@w_error			int,
		@w_valor_ant      	varchar(255),
		@w_valor_nuevo    	varchar(255),
		@w_ente				int,
		@w_tramite			int,
        @w_ttramite         varchar(255),
        @w_banco            cuenta,
		@w_respuesta        varchar(10)
		
select @w_sp_name = 'sp_var_acepta_renova_lcr'

select @w_ente       = convert(int,io_campo_1),
	   @w_tramite    = convert(int,io_campo_3),
	   @w_ttramite   = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc
   
/* Obtengo banco */
select @w_banco = op_banco 
from cob_cartera..ca_operacion
where op_tramite = @w_tramite

select @w_error = 0

if @w_ttramite = 'REVOLVENTE'
begin
	select top 1 @w_respuesta = ms_respuesta 
	from cob_bvirtual..bv_b2c_msg
	where ms_cliente = @w_ente
	and ms_banco    = @w_banco
	and ms_tipo_msg = 'RENO_LCR' 
	order by ms_msg_id desc
	
	if(@w_respuesta = 'S')
		select @w_valor_nuevo = 'SI'
	else
		select @w_valor_nuevo = 'NO'
end
else
begin
	select @w_valor_nuevo = 'NO'
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

