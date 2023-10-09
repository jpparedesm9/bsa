/************************************************************************/
/*   Archivo:                 sp_var_nro_ciclos.sp				     	*/
/*   Stored procedure:        sp_var_nro_ciclos							*/
/*   Base de Datos:           cob_credito                               */
/*   Producto:                Credito                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Noviembre 2019                            */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'COBISCorp'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Validar la cantidad de ciclos de los creditos                   	*/
/*	                     												*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   05/11/2019 A. Ortiz        Emision Inicial                         */
/************************************************************************/
use cob_credito
go

if not object_id('sp_var_nro_ciclos') is null
   drop proc sp_var_nro_ciclos
go

create proc sp_var_nro_ciclos(
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
	@t_trn				int         = null,
	@t_show_version     BIT         = 0,
    @i_id_inst_proc    	int,    --codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint
)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_operacion            varchar(64),
		@w_cliente				int
		
		
	select @w_sp_name 	= 'sp_var_nro_ciclos'
 
	select @w_operacion    = io_campo_4,
		   @w_cliente 	   = io_campo_1 
	from cob_workflow..wf_inst_proceso
	where io_id_inst_proc 	= @i_id_inst_proc

	if @w_operacion = 'GRUPAL'
	begin
		exec @w_error = cob_credito..sp_var_nro_ciclo_grupal
		@i_id_inst_proc = @i_id_inst_proc,
		@i_id_inst_act  = @i_id_inst_act,    
		@i_id_asig_act  = @i_id_asig_act,
		@i_id_empresa   = @i_id_empresa, 
		@i_id_variable  = @i_id_variable
	end

	if @w_operacion = 'REVOLVENTE'
	begin
		exec @w_error = cob_credito..sp_var_nro_ciclos_rev
		@i_id_inst_proc = @i_id_inst_proc,
		@i_id_inst_act  = @i_id_inst_act,    
		@i_id_asig_act  = @i_id_asig_act,
		@i_id_empresa   = @i_id_empresa, 
		@i_id_variable  = @i_id_variable

	end

	if @w_operacion = 'INDIVIDUAL'
	begin
		exec @w_error = cob_credito..sp_var_nro_ciclos_ind
		@i_id_inst_proc = @i_id_inst_proc,
		@i_id_inst_act  = @i_id_inst_act,    
		@i_id_asig_act  = @i_id_asig_act,
		@i_id_empresa   = @i_id_empresa, 
		@i_id_variable  = @i_id_variable

	end

	return 0
	
	go