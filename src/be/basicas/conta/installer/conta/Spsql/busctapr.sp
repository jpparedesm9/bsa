/************************************************************************/
/*	Archivo: 		busctapr.sp			        */
/*	Stored procedure: 	sp_busca_cuenta_pre			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:      3-Agosto-1993 				*/
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
/*	   Criterios de busqueda de cuentas                             */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	16/Ago/1993	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_busca_cuenta_pre')
	drop proc sp_busca_cuenta_pre  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_busca_cuenta_pre   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa		tinyint = null,
	@i_cuenta   		cuenta = null,
	@i_cuenta_padre   	cuenta = null,
	@i_nombre		descripcion = null,
	@i_descripcion  	descripcion= null,
	@i_estado       	char(1) = null ,
	@i_movimiento		char(1) = null,
	@i_nivel_cuenta		tinyint = null,
	@i_categoria		char(10) = null,
	@i_cuenta1		cuenta = null,
	@i_error		smallint = null /* Presenta o no mensaje de error */
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa		tinyint,
	@w_cuenta   		cuenta,
	@w_cuenta_padre   	cuenta,
	@w_nombre		descripcion ,
	@w_descripcion  	descripcion ,
	@w_estado       	char(1)  ,
	@w_movimiento		char(1) ,
	@w_nivel_cuenta		tinyint ,
	@w_categoria		char(10),
	@w_fecha_estado		datetime ,
	@w_nempresa		descripcion,
	@w_ncdesc		descripcion,
	@w_sinonimo		char(20),
	--@w_ncategoria		char(32)   ,
	@w_nivel_cuenta1	tinyint,
	@w_nivel_cuenta2	tinyint,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_busca_cuenta_pre'


if @i_nivel_cuenta is null
begin
	select 	@w_nivel_cuenta1 = 0,
		@w_nivel_cuenta2 = 255
end
else begin
	select	@w_nivel_cuenta1 = @i_nivel_cuenta,
		@w_nivel_cuenta2 = @i_nivel_cuenta
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_cuenta   	= @i_cuenta ,
		i_cuenta_padre  = @i_cuenta_padre ,
		i_nombre	= @i_nombre ,
		i_descripcion  	= @i_descripcion,
		i_estado       	= @i_estado, 
		i_movimiento	= @i_movimiento,
		i_nivel_cuenta	= @i_nivel_cuenta,
		i_categoria	= @i_categoria 
	exec cobis..sp_end_debug
end


/************************************************/
/*  Tipo de Transaccion = 603 			*/

if (@t_trn <> 6564 and @i_operacion = 'V') or
   (@t_trn <> 6566 and @i_operacion = 'Q') or
   (@t_trn <> 6567 and @i_operacion = 'A') or
   (@t_trn <> 6568 and @i_operacion = 'M') or
   (@t_trn <> 6569 and @i_operacion = 'B') 
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



/****** Query ****/
/*****************/

if @i_operacion = 'Q'
begin
	select  @w_empresa = cup_empresa,
		@w_cuenta_padre = cup_cuenta_padre,
		@w_nombre = cup_nombre,
		@w_descripcion = cup_descripcion,
		@w_estado = cup_estado,
		@w_movimiento = cup_movimiento,
		@w_nivel_cuenta = cup_nivel_cuenta,
		@w_ncdesc = np_descripcion,
		@w_categoria = cup_categoria,
		@w_movimiento = cup_movimiento
	from 	cob_conta..cb_cuenta_presupuesto,
		cob_conta..cb_nivel_presupuesto 
	where 	cup_empresa = @i_empresa and
		cup_cuenta = @i_cuenta and
		cup_empresa = np_empresa and
		cup_nivel_cuenta = np_nivel_presupuesto
		
	if @@rowcount > 0
	begin
		--select @w_ncategoria = ca_nombre
		--from cob_conta..cb_categoria
		--where ca_categoria = @w_categoria

	select 	@w_cuenta_padre,
		@w_nombre,
		@w_descripcion,
		@w_estado,
		@w_nivel_cuenta	,
		@w_ncdesc,
		@w_categoria,
		--@w_ncategoria,
		@w_movimiento

		return 0
	end  
	else
	begin
		/* 'Cuenta consultada no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601028
		return 1
	end
end

/*  All */
/********/

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select  'Cuenta' = cup_cuenta,
			'Nombre de la Cuenta' = substring(cup_nombre,1,40),
			'Movimiento' = cup_movimiento ,
			'Naturaleza' = cup_categoria
		from cob_conta..cb_cuenta_presupuesto
		where 	cup_empresa = @i_empresa and
		       (cup_nivel_cuenta between @w_nivel_cuenta1 and 
			@w_nivel_cuenta2) and
			cup_cuenta like @i_cuenta and
			cup_nombre like @i_nombre + '%' and --NPPG
			--cup_categoria like @i_categoria and
			cup_movimiento like @i_movimiento 
		order by cup_cuenta
	end
	else begin
		select  'Cuenta' = cup_cuenta,
			'Nombre de la Cuenta' = substring(cup_nombre,1,40),
			'Movimiento' = cup_movimiento ,
			'Naturaleza' = cup_categoria
		from cob_conta..cb_cuenta_presupuesto
		where 	cup_empresa = @i_empresa and
		       (cup_nivel_cuenta between @w_nivel_cuenta1 and 
			@w_nivel_cuenta2) and
			cup_cuenta like @i_cuenta and
			cup_cuenta > @i_cuenta1 and
			cup_nombre like @i_nombre + '%' and --NPPG
			--cup_categoria like @i_categoria and
			cup_movimiento like @i_movimiento 
		order by cup_cuenta
	end
	if @@rowcount = 0
	begin
          if @i_error <> 1
          begin 
		/* No existen Cuentas          */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601028
          end
          set rowcount 0
          return 1
	end
        set rowcount 0
	return 0
end

/***** Busqueda especial, cuentas de movimiento *****/
if @i_operacion = 'M'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select  'Cuenta' = cup_cuenta,
			'Nombre de Cuenta' = substring(cup_nombre,1,35),
			'Movimiento' = cup_movimiento  
		from cob_conta..cb_cuenta_presupuesto
		where 	cup_empresa = @i_empresa and
			cup_movimiento = 'S'
	end
	else
	begin
		select  'Cuenta' = cup_cuenta,
			'Nombre de Cuenta' = substring(cup_nombre,1,35),
			'Movimiento' = cup_movimiento  
		from cob_conta..cb_cuenta_presupuesto
		where 	cup_empresa = @i_empresa and
			cup_cuenta > @i_cuenta and
			cup_movimiento = 'S'
	end
	if @@rowcount = 0
	begin
		/* 'No existen Cuentas          '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601029
		return 1
	end
	return 0
end	

/**** Value  ****/
/****************/

if @i_operacion = 'V'
begin
	select cup_cuenta, cup_nombre 
	from cob_conta..cb_cuenta_presupuesto
	where 	cup_empresa = @i_empresa and
		cup_cuenta = @i_cuenta

	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601028
		return 1
	end
return 0
end

/*********** Busqueda de cuentas dado el padre de las cuentas ****/
/*****************************************************************/

if @i_operacion = 'B'
begin
	select cup_cuenta,cup_nombre
	from cob_conta..cb_cuenta_presupuesto
	where 	cup_empresa = @i_empresa and
		cup_cuenta_padre = @i_cuenta_padre
	order by cup_cuenta

	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 602028
		return 1
	end
	return 0
end

go
