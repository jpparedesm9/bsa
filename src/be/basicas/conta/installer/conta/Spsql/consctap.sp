/************************************************************************/
/*	Archivo: 		consctap.sp 			        */
/*	Stored procedure: 	sp_consulta_cuenta_perfil		*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Fabio C Cardona                       	*/
/*	Fecha de escritura:     12-Mar-1999 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   (Q) -> Consulta los perfiles contables de una cuenta dada    */
/*         (V) -> Consulta de los demas datos de la cuenta              */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/*	12-Marzo-1999	Fabio C Cardona     Emision Inicial		*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_consulta_cuenta_perfil')
   	drop proc sp_consulta_cuenta_perfil
go

create proc sp_consulta_cuenta_perfil(
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo		  	smallint = null,
	@i_empresa		tinyint = null,
	@i_cuenta		cuenta = null

)
as 

declare @w_today 		datetime,  	/* fecha del dia */
	@w_sp_name		varchar(32),	/* descripcion del stored procedure*/
	@w_variable		varchar(20),
	@w_cuenta		cuenta,
	@w_existe		tinyint
	


select @w_variable = '%[a-zA-Z]%'
select @w_today = getdate()
select @w_sp_name = 'sp_consulta_cuenta_perfil'


/********Verificamos existencias**********/
truncate table cb_consulta_perfil


if (@t_trn <> 6750 and @i_operacion = 'Q') or
   (@t_trn <> 6750 and @i_operacion = 'V') or
   (@t_trn <> 6750 and @i_operacion = 'A')

begin
	/* Tipo de transaccion no corresponde */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  =  @w_sp_name,
	@i_num   = 801077
	return 1
end


/* Chequeo de Existencias */
/**************************/

select @w_cuenta=dp_cuenta from cb_det_perfil
where dp_empresa = @i_empresa and
      dp_cuenta = @i_cuenta
if @@rowcount > 0
begin
	select @w_existe = 1
end
else
begin
	select @w_existe = 0

end


if @i_operacion='Q'
begin
	if @w_existe = 1
	begin

		exec sp_cuenta_perfiles
			@i_empresa = @i_empresa,
			@i_cuenta = @i_cuenta,
			@i_paso = 0

		declare cuentas cursor
		for select distinct cp_cuenta_perfil
		from cb_consulta_perfil
		where cp_cuenta_perfil like @w_variable

		open  cuentas
		fetch cuentas
		into  @w_cuenta

		while(@@fetch_status = 0)
		begin
			exec sp_cuenta_perfiles
				@i_empresa = @i_empresa,
				@i_cuenta = @i_cuenta,
				@i_cta_perfil = @w_cuenta,
				@i_paso = 1
	
			fetch cuentas
			into  @w_cuenta
		end
	end
	else
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601055
		return 1
	end
	

	select distinct "Perfiles"=cp_cuenta_perfil
	from cb_consulta_perfil
	where cp_cuenta_perfil not like "%[a-zA-Z]%"

end


if @i_operacion='V'
begin
	if @w_existe = 1
	begin
		select distinct 'Empresa'=dp_empresa,
				'Producto'=dp_producto,
				'Perfil'=dp_perfil,
				'Asiento'=dp_asiento,
				'Cuenta'=dp_cuenta
		from cb_det_perfil
		where dp_cuenta=@i_cuenta
		order by dp_cuenta

		if @@rowcount = 0
		begin
			/* 'No existen Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601055
			return 1
		end
		set rowcount 0
		return 0
	end
end


if @i_operacion='A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select  'Cuenta'=dp_cuenta,
			'Producto'=dp_producto,
			'Perfil'=dp_perfil
		from cb_det_perfil
		order by dp_perfil

		if @@rowcount = 0
		begin
			/* 'No existen Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 101001
			return 1
		end
		set rowcount 0
		return 0
	end

	if @i_modo = 1
	begin
		select  'Cuenta'=dp_cuenta,
			'Producto'=dp_producto,
			'Perfil'=dp_perfil
		from cb_det_perfil
		where dp_cuenta > @i_cuenta
		order by dp_perfil

		if @@rowcount = 0
		begin
			/* 'No existen Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 101001
			return 1
		end
		set rowcount 0
		return 0
	end
end

go
