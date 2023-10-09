/************************************************************************/
/*	Archivo:		trnrol.sp				*/
/*	Stored procedure:	sp_transac_rol				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		ADMIN-Seguridades			*/
/*	Disenado por:  		Alexis Rodriguez Morales		*/
/*	Fecha de escritura: 	14-FEB-2001				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA". 							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa maneja la generación de transacciones autorizadas	*/
/*	para un rol en el nuevo esquema de seguridades en COBIS WEB	*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go


if exists (select * from sysobjects where name = 'sp_transac_rol')
   drop proc sp_transac_rol
go

create proc sp_transac_rol (
	@s_ssn			int 		= NULL,
	@s_user			login 		= NULL,
	@s_sesn			int 		= NULL,
	@s_term			varchar(30) 	= NULL,
	@s_date			datetime 	= NULL,
	@s_srv			varchar(30) 	= NULL,
	@s_lsrv			varchar(30) 	= NULL, 
	@s_rol			smallint 	= NULL,
	@s_ofi			smallint 	= NULL,
	@s_org_err		char(1) 	= NULL,
	@s_error		int 		= NULL,
	@s_sev			tinyint 	= NULL,
	@s_msg			descripcion 	= NULL,
	@s_org			char(1) 	= NULL,
	@t_debug		char(1) 	= 'N',
	@t_file			varchar(14) 	= NULL,
	@t_from			varchar(32) 	= NULL,
	@t_trn			smallint 	= NULL,
	@i_rol			tinyint		= NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_func			char(12)
begin

	/** INICIALIZACION DE VARIABLES **/
	select 	@w_today = @s_date,
		@w_sp_name = 'sp_transac_rol'
		
	/** CONTROL DE TRANSACCION AUTORIZADA **/
	if @t_trn=15286
	begin
	

		/*** CREACION DE TABLAS TEMPORALES ***/
	
		create table #aw_tran_rol
		(tr_transaccion int)	

		create table #aw_func_procesada
		(fp_func varchar(10))

		/*** INSERCION DE TRANSACCIONES PARA EL ROL EN TABLA TEMPORAL ***/
		exec @w_return = sp_transac_rol2
			@s_ssn	= @s_ssn,
			@s_user	= @s_user,
			@s_sesn	= @s_sesn,
			@s_term	= @s_term,
			@s_date	= @s_date,
			@s_srv	= @s_srv,
			@s_lsrv	= @s_lsrv, 
			@s_rol	= @s_rol,
			@s_ofi	= @s_ofi,
			@s_org_err = @s_org_err,
			@s_error   = @s_error,
			@s_sev	   = @s_sev,
			@s_msg	   = @s_msg,
			@s_org	   = @s_org,
			@t_debug   = @t_debug,
			@t_file	   = @t_file,
			@t_from	   = @t_from,
			@t_trn	   = @t_trn,
			@i_operacion = 'GR',
			@i_rol	   = @i_rol
		
		if @w_return<>0
		begin
			exec cobis..sp_cerror
		   	@t_debug = @t_debug,
		   	@t_file	 = @t_file,
		   	@t_from	 = @w_sp_name,
		   	@i_num	 = @w_return
		   	
		   	return 1
		end
		
		/** USADO MIENTRAS SE DEPURA **/
--		select * from #aw_tran_rol 
--		select * from #aw_func_procesada
		
		/** BORRA TRANSACCIONES AUTORIZADAS AL ROL
		    ANTERIORMENTE **/
		    
		delete ad_tr_autorizada
		where ta_rol=@i_rol
		    
		if @@error <> 0
		begin
			exec cobis..sp_cerror
		   	@t_debug = @t_debug,
		   	@t_file	 = @t_file,
		   	@t_from	 = @w_sp_name,
		   	@i_num	 = 157025
			
			return 1
		end
		
		/** CREAR TRANSACCIONES AUTORIZADAS **/
		
		insert into ad_tr_autorizada(
		 	ta_producto, ta_tipo,      ta_moneda,      ta_transaccion,
		 	ta_rol,      ta_fecha_aut, ta_autorizante, ta_estado,
		 	ta_fecha_ult_mod)
		 select
		 	pt_producto, pt_tipo,	     pt_moneda,     pt_transaccion,
		 	@i_rol,      getdate(),     1,		    'V',
		 	getdate()
		 from 
		 	#aw_tran_rol,
		 	ad_pro_transaccion, 
		 	ad_procedure
		where 
			pd_procedure = pt_procedure
			and pt_transaccion = tr_transaccion
--			and pt_estado = 'V'
--			and pd_estado = 'V'


		if @@error <> 0
		begin
			exec cobis..sp_cerror
		   	@t_debug = @t_debug,
		   	@t_file	 = @t_file,
		   	@t_from	 = @w_sp_name,
		   	@i_num	 = 153010
			
			return 1
		end

		
		return 0
	end
	else
	/******* ERROR TRANSACCION *********/
	begin
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 141018

		return 1
	end
end
go
