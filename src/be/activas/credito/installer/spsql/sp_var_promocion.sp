/****************************************************************/
/*   ARCHIVO:         	sp_var_promocion.sp    	    			*/
/*   NOMBRE LOGICO:   	sp_var_promocion               		    */
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
/*  Corresponde al lo contestado por el cliente en el formato   */
/*	de Solicitud de Crédito Grupal en la pregunta ¿Es Promoción?*/
/*	Por defecto, la respuesta de esta variable será NO.         */
/*                                                              */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   17-May-2017   Sonia Rojas        Emision Inicial.     	    */
/*   05-Jun-2021   Sonia Rojas        Req 147999     	        */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_promocion')
   drop proc sp_var_promocion
go

create proc [dbo].[sp_var_promocion](
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
declare	@w_sp_name 							varchar(64),
		@w_error							int,
		@w_grupo							int,
		@w_tramite							int,
		@w_es_promocion		                char(1),
		@w_asig_actividad 					int,		
		@w_valor_ant      					varchar(255),
		@w_valor_nuevo    					varchar(255)
		
select @w_sp_name = 'sp_var_promocion'

select @w_grupo 		= io_campo_1,
	   @w_tramite 		= io_campo_3
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc 	= @i_id_inst_proc
   and io_campo_7 		= 'S' -- Cambiar a Grupo Solidario 'S'
   
   
select @w_es_promocion = isnull(tr_promocion, 'N')
  from cob_credito..cr_tramite
 where tr_tramite = @w_tramite
 
select @w_valor_nuevo = isnull(@w_es_promocion,'N')
print '@w_es_promocionGrupo--: ' + convert(varchar, @w_valor_nuevo )
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
