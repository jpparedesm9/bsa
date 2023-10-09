/****************************************************************/
/*   ARCHIVO:         	sp_var_num_intg_participa.sp    	    */
/*   NOMBRE LOGICO:   	sp_var_num_intg_participa               */
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
/*	Número de Miembros del grupo que participan en el ciclo     */
/*	actual.                                                     */
/*                                                              */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   11-May-2017   Sonia Rojas        Emision Inicial.     	    */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_num_intg_participa')
   drop proc sp_var_num_intg_participa
go

create proc [dbo].[sp_var_num_intg_participa](
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int         = null,
	@s_user             varchar(30) = null,
	@s_sesn             int         = null,
	@s_term             varchar(30) = null,
	@s_date             datetime    = null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint    = null,
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
		@w_nro_ciclo_grupal					int,
		@w_tramite							int,
		@w_resultado						int,
		@w_asig_actividad 					int,
		@w_valor_ant      					varchar(255),
		@w_valor_nuevo    					varchar(255)
		
select @w_sp_name = 'sp_var_num_intg_participa'

select @w_grupo 		= io_campo_1,
	   @w_tramite 		= io_campo_3
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc 	= @i_id_inst_proc
   and io_campo_7 		= 'S' -- Cambiar a Grupo Solidario 'S'
   

select @w_resultado 		= count(tg_cliente)
  from cob_credito..cr_tramite_grupal
 where tg_tramite 			=  @w_tramite
   and tg_monto   			>  0
   and tg_participa_ciclo   = 'S'

if @w_resultado is null
begin
   select @w_error  = 6904007 --No existieron resultados asociados a la operacion indicada   
   exec   @w_error  = cobis..sp_cerror
          @t_debug  = 'N',
          @t_file   = '',
          @t_from   = @w_sp_name,
          @i_num    = @w_error
   return @w_error
end

select @w_valor_nuevo = convert(varchar,@w_resultado)

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
   