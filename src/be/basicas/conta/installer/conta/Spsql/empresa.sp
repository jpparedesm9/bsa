/************************************************************************/
/*	Archivo: 		empresa.sp				*/
/*	Stored procedure: 	sp_empresa				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	   Mantenimiento al catalogo de Empresas                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*      22/Feb/1996     O Hoyos         Operacion E                     */
/*	22/Ene/1997	F.Salgado	Personalizacion CajaCoop	*/
/*					FS001: Ampliar campo abreviatu- */
/*					ra a char(16)			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_empresa')
	drop proc sp_empresa    

go
create proc sp_empresa     (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 603,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint = null,
	@i_descripcion	descripcion = null,
	@i_ruc		char(10) = null,
	@i_replegal	descripcion = null,
	@i_contgen	descripcion = null,
	@i_matcontgen   char(10) = null,
	@i_revisor	descripcion = null,
	@i_matrevisor   char(10) = null,
	@i_moneda_base	tinyint  = null,
	@i_direccion	char(120) = null,
	@i_abreviatura	char(16) = null	/* FS001 */
)
as 
declare @w_today 	datetime,  	/* fecha del dia */ 
	@w_return	int,		/* valor que retorna */ 
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de empresa */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una empresa */

	@w_empresa	tinyint ,	/* codigo de empresa */
	@w_descripcion	descripcion ,	/* descripcion       */	
	@w_ruc		char(10) ,	/* numero de ruc     */
	@w_replegal	descripcion ,	/* representante legal*/
	@w_contgen	descripcion ,	/* contador general  */
	@w_matcontgen	char(10) ,	/* matricula contador*/
	@w_revisor 	descripcion ,	/* revisor fiscal    */
	@w_matrevisor	char(10) ,	/* matricula revisor */
	@w_direccion	char(120),
	@w_moneda_base	tinyint,
	@w_abreviatura	char(16),	/* FS001 */
	@w_strsigue	char(4),
	@w_longitud	tinyint,
	@w_nmoneda	descripcion,
	@w_ntipo	descripcion,
	@w_mascara	varchar(40),	/* mascara de niveles de organizacion*/
	@w_rows		int,
	@w_flag1	int ,
	@w_contador	int,
	@w_nivel_plan	int,
        @w_emp_revisor  descripcion,
        @w_nit_emprev   varchar(13),
        @w_mat_revisor  char(10)

select @w_today = getdate()
select @w_sp_name = 'sp_empresa'

/************************************************/
/*  Tipo de Transaccion       			*/

if 
   (@t_trn <> 6034 and @i_operacion = 'V') or
   (@t_trn <> 6035 and @i_operacion = 'S') or
   (@t_trn <> 6036 and @i_operacion = 'Q') or
   (@t_trn <> 6037 and @i_operacion = 'A') or
   (@t_trn <> 6038 and @i_operacion = 'C') or
   (@t_trn <> 6039 and @i_operacion = 'T') or
   (@t_trn <> 6030 and @i_operacion = 'N') or
   (@t_trn <> 6118 and @i_operacion = 'E')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_descripcion	= @i_descripcion,
		i_ruc		= @i_ruc,
		i_replegal	= @i_replegal,
		i_contgen	= @i_contgen,
		i_matcontgen	= @i_matcontgen,
		i_revisor	= @i_revisor,
		i_matrevisor	= @i_matrevisor,
		i_moneda_base	= @i_moneda_base 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_empresa 	 = em_empresa,
		@w_descripcion 	  = em_descripcion,
		@w_ruc		  = em_ruc,
		@w_replegal 	  = em_replegal,
		@w_contgen 	  = em_contgen,
		@w_matcontgen	  = em_matcontgen,
		@w_revisor 	  = em_revisor,
		@w_matrevisor	  = em_matrevisor,
		@w_direccion 	  = em_direccion,
		@w_moneda_base 	  = em_moneda_base,
		@w_abreviatura 	  = em_abreviatura,
		@w_nmoneda 	  = mo_descripcion,
                @w_emp_revisor    = em_emp_revisor,
                @w_nit_emprev     = em_nit_emprev,
                @w_mat_revisor    = em_mat_revisor
	from cob_conta..cb_empresa,cobis..cl_moneda
	where em_empresa = @i_empresa and
	      mo_moneda = em_moneda_base 
	
	if @@rowcount > 0 
		select @w_existe = 1
	else 
		select @w_existe = 0
end

if @i_operacion = 'E'
begin
   select @w_replegal , @w_revisor , @w_matrevisor , @w_contgen , @w_matcontgen
end

if @i_operacion = 'Q'
begin
	if @w_existe = 1

 	   select @w_empresa,        @w_descripcion,     @w_replegal,
                  @w_contgen,        @w_matcontgen,      @w_revisor,
                  @w_matrevisor,     @w_direccion,       @w_ruc,
	       	  @w_abreviatura,    @w_moneda_base,     @w_nmoneda, 
                  @w_emp_revisor,    @w_nit_emprev,      @w_mat_revisor   
	else
	begin
		/* 'Empresa consultada no existe        ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end
end

/******************     ALL     ********************/

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Empresa'= em_empresa,'Descripcion' = em_descripcion
        	from cob_conta..cb_empresa
   		order by em_empresa

		if @@rowcount = 0
		begin
			/* 'No existen Empresas         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601007
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
		select 'Empresa' = em_empresa, 'Descripcion' = em_descripcion
		from cob_conta..cb_empresa
		where em_empresa > @i_empresa
		order by em_empresa
		if @@rowcount = 0
		begin
			/* 'No existen Empresas         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601007
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end
end

/******************   VALUE     ********************/

if @i_operacion = 'V'
begin
	if @w_existe = 1 
		select @w_descripcion
        else
	begin
		/* 'Empresa consultada no existe        ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end
        return 0
end
/******************   SEARCH    ********************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Codigo' = em_empresa,
			'Nombre' = substring(em_descripcion,1,30) 
        	from cob_conta..cb_empresa
   		order by em_empresa

		if @@rowcount = 0
		begin
			/* 'No existen Empresas         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601007
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
		select 'Codigo' = em_empresa,
			'Nombre' = substring(em_descripcion,1,30) 
		from cob_conta..cb_empresa
		where em_empresa > @i_empresa
		order by em_empresa
		if @@rowcount = 0
		begin
			/* 'No existen Empresas         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601007
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end
end


if @i_operacion = 'C' /* consulta de empresa y niveles de organizacion */
begin
	if @w_existe = 1 
		select @w_descripcion
        else
	begin
		/* 'Empresa consultada no existe        ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end

	select or_descripcion
	from cob_conta..cb_organizacion
	where or_empresa = @i_empresa
	order by or_organizacion

        if @@rowcount = 0
	begin
		/* 'Nivel de Organizacion consultado no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601040
		return 1
	end
	return 0
end


if @i_operacion = 'T'
begin
	if @w_existe = 1 
		select @w_descripcion
        else
	begin
		/* 'Empresa consultada no existe        ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end
	return 0
end

if @i_operacion = 'N'
begin
	if @w_existe = 1
	begin
		select @w_mascara = ''  --JRMZ MARZO 13/08 SE MODIFICA = NULL POR = ''

		select @w_descripcion

		select nc_longitud, nc_descripcion
		from cob_conta..cb_nivel_cuenta
		where nc_empresa = @i_empresa

		select @w_rows = count(*)
		from cob_conta..cb_nivel_cuenta
		where nc_empresa = @i_empresa

		/***** mascara de cuentas para la empresa ****/

		if @w_rows = 0
		begin
			select @w_mascara
			return 0
		end
		else
		begin
			select @w_contador = 1
			select @w_flag1 = 1
			while @w_flag1 > 0
			begin
				select @w_longitud = nc_longitud
				from cob_conta..cb_nivel_cuenta
				where nc_empresa = @i_empresa and
					nc_nivel_cuenta = @w_contador

				if @@rowcount > 0
				begin
					while @w_longitud > 0
					begin
				   	   select @w_mascara = @w_mascara + '#'
					   select @w_longitud = @w_longitud - 1
					end
					if @w_contador < @w_rows
					   select @w_mascara = @w_mascara + '.'
				end
				select @w_contador = @w_contador + 1
				if @w_contador > @w_rows
					select @w_flag1 = 0
			end
		end
		select @w_mascara
		select @w_moneda_base
		return 0
	end
	else
	begin
		/* 'No existe empresa especificada   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end
end
go
