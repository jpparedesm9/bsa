/****************************************************************/
/*   ARCHIVO:         	sp_var_nro_ciclo_individual.sp		    */
/*   NOMBRE LOGICO:   	sp_var_nro_ciclo_individual       		*/
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
/*   11-May-2017   Sonia Rojas        Emision Inicial.     	    */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_nro_ciclo_individual')
   drop proc sp_var_nro_ciclo_individual
go

create proc [dbo].[sp_var_nro_ciclo_individual](
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
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_grupo				int,
		@w_num_ciclo_cliente 	int,
		@w_num_prestamos		int,
		@w_estado				int,
		@w_cg_nro_ciclo         int,
		@w_codigo_estado		int,
		@w_resultado			int,
		@w_asig_actividad 		int,		
		@w_valor_ant      		varchar(255),
		@w_valor_nuevo    		varchar(255),
		@w_valor_actual			varchar(10),
		@w_cliente				int,
		@w_id_variable			int,
		@w_tramite   			int
		
		
select @w_sp_name 	= 'sp_var_nro_ciclo_individual'
select @w_resultado = 0

SELECT @w_codigo_estado = es_codigo 
  from cob_cartera..ca_estado
 where es_descripcion 	= 'CANCELADO'
 
 
select @w_id_variable 		= vb_codigo_variable
  from cob_workflow..wf_variable
 where vb_abrev_variable 	= 'CLINROCLIN'

select @w_valor_actual    = va_valor_actual
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @w_id_variable

select @w_cliente = convert(int,@w_valor_actual)

PRINT ' ID CLIENTE EN NUM CICLO   ----->   ' + convert(VARCHAR, @w_cliente )
if @w_cliente is null
begin
	select @w_cliente       = io_campo_1 		   
	  from cob_workflow..wf_inst_proceso
	 where io_id_inst_proc 	= @i_id_inst_proc
	 
	if @w_cliente is null
	begin
		select @w_error = 2109003 
		exec   @w_error  = cobis..sp_cerror
			   @t_debug  = 'N',
			   @t_file   = '',
			   @t_from   = @w_sp_name,
			   @i_num    = @w_error
		return @w_error
	
	end
	
end
/****
--Ciclos en otra entidad financieras
select @w_num_ciclo_cliente = isnull(ea_nro_ciclo_oi,0)
  from cobis..cl_ente_aux
 where ea_ente 				= @w_cliente
 ******/
--Ciclos en esta entidad financiera
/*select @w_num_prestamos = isnull(count(op_operacion),0)
  from cob_cartera..ca_operacion 
 where op_estado 		= @w_codigo_estado
   and op_cliente 		= @w_cliente*/


--select @w_cg_nro_ciclo  = isnull(cg_nro_ciclo,0)
--  from cobis..cl_cliente_grupo 
-- where cg_ente 			= @w_cliente

--Ciclos del cliente en la cl_ente
/*********************************************************************************/
/* Validacion Promo                                                              */
/*********************************************************************************/
select 
@w_tramite = io_campo_3,
@w_grupo   = io_campo_1
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if exists(select 1 from cob_credito..cr_tramite where tr_tramite = @w_tramite  and tr_promocion = 'S') and
         (select gr_num_ciclo from cobis..cl_grupo where gr_grupo 	= @w_grupo) = 0 and
   exists(select 1 from cob_credito..cr_grupo_promo_inicio where gpi_grupo= @w_grupo and gpi_ente = @w_cliente) 
begin
      select @w_num_ciclo_cliente = 0	
end          
else
     select @w_num_ciclo_cliente=isnull(en_nro_ciclo,0) FROM cobis..cl_ente 
     where en_ente=@w_cliente

if @w_num_ciclo_cliente = 0 or @w_num_ciclo_cliente IS NULL 

	select @w_resultado = 1
else
	select @w_resultado = @w_num_ciclo_cliente +1

if @t_debug = 'S'
begin
	print '@w_resultado: ' + convert(varchar, @w_resultado )	
end
	
PRINT ' RESULTADO NUM CICLO CLIENTE----->   ' + convert(VARCHAR, @w_resultado )	

if @w_resultado is null
begin
	select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
	exec   @w_error  = cobis..sp_cerror
			@t_debug  = 'N',
			@t_file   = '',
			@t_from   = @w_sp_name,
			@i_num    = @w_error
	return @w_error
end

-- valor anterior de variable tipop en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
	update cob_workflow..wf_variable_actual
	   set va_valor_actual = @w_resultado 
	 where va_id_inst_proc = @i_id_inst_proc
	   and va_codigo_var   = @i_id_variable
	
end
else
begin
	insert into cob_workflow..wf_variable_actual
			(va_id_inst_proc, va_codigo_var, va_valor_actual)
	values (@i_id_inst_proc, @i_id_variable, @w_resultado )

end


return 0
go
