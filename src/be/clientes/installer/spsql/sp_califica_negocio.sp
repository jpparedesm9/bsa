/****************************************************************/
/*   ARCHIVO:         	sp_califica_negocio.sp		        	*/
/*   NOMBRE LOGICO:   	sp_califica_negocio       		    	*/
/*   PRODUCTO:          CLIENTES                                */
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
/*  Resgistrar historico y definitivo de datos del negocio      */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   23-01-2020    F. Sanmiguel        Emision Inicial.     	*/
/****************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_califica_negocio')
   drop proc sp_califica_negocio
go

create procedure sp_califica_negocio(
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int         = null,
	@s_user             varchar(30) = null,
	@s_sesn             int			= null,
	@s_term             varchar(30) = null,
	@s_date             datetime	= null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint	= null,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_rty				char(1)     = null,
	@t_trn				int         = null,	
	@i_id_inst_proc   int,    --codigo de instancia del proceso
	@i_id_inst_act    int        = null,    
	@i_id_empresa     int        = null, 
	@o_id_resultado   smallint  = null out     

)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_id_formulario        int,
		@w_version_formulario   int,
		@w_nombre_formulario    varchar(100),
		@w_ente             	int,
		@w_resultado        	varchar(16)
		
		
		
	select @w_sp_name 	= 'sp_califica_negocio'
	
	select @w_ente = io_campo_1 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc
	
	
	--1. Ingresamos a la tabla historica si existen datos en la tabla definitiva
	if exists (select 1 from cobis..cl_neg_cliente where nc_ente = @w_ente)
		begin
			insert into cobis..cl_neg_cliente_his
			select top 1 *,getdate() from cobis..cl_neg_cliente where nc_ente = @w_ente order by nc_fecha_investigacion desc
		end
	
	--2. Ingresamos el negocio del cliente a la tabla definitiva
	if exists (select 1 from cobis..cl_neg_cliente_prev where nc_ente = @w_ente)
		begin
			--eliminamos el registro existente de la tabla definitiva
			delete cobis..cl_neg_cliente where nc_ente = @w_ente
			--insertamos en el registro definitivo
			insert into cobis..cl_neg_cliente 
			select  top 1  * from cobis..cl_neg_cliente_prev  where nc_ente = @w_ente order by nc_fecha_investigacion desc
			--eliminamos el negocio de la tabla previa
			delete from cobis..cl_neg_cliente_prev where nc_ente = @w_ente
		end
		
	if @@error <> 0
	begin
	   exec sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 70327
			/* 'Error en creacion de transaccion de servicio'*/
	   return  1
	end

	select @o_id_resultado = 1 -- OK		
	

return 0

go
