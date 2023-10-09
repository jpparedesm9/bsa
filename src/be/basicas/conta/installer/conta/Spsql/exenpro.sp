/************************************************************************/
/*	Archivo: 		exenpro.sp 			        */
/*	Stored procedure: 	sp_exenpro     				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           					*/
/*	Fecha de escritura:     					*/
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
/*	Mantenimiento de exenciones de Impueesto por producto  .        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_exenpro')
	drop proc sp_exenpro
go

create proc sp_exenpro(
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
	@i_modo			smallint = null,
	@i_empresa		tinyint = null,
        @i_regimen              catalogo = null,
	@i_producto             tinyint = null,
	@i_impuesto		char(1) = null,
	@i_concepto       	char(4) = null

)
as 
declare
	@w_sp_name		varchar(32),	/* nombre del stored procedure*/
	@w_asociada		varchar(10),
	@w_impuesto		char(1) 

select @w_sp_name = 'sp_exenpro'



if (@t_trn <> 6258 and @i_operacion = 'I') or
   (@t_trn <> 6259 and @i_operacion = 'D') or
   (@t_trn <> 6260 and @i_operacion = 'S') 

begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_modo 		= @i_modo,
                i_regimen       = @i_regimen,
		i_impuesto 	= @i_impuesto,
		i_concepto	= @i_concepto
	exec cobis..sp_end_debug
end



if @i_operacion = 'I'
begin
	if exists (select 1 from cb_exencion_producto
		where ep_empresa = @i_empresa
                and   ep_regimen = @i_regimen
                and   ep_producto = @i_producto
		and   ep_impuesto = @i_impuesto
		and   ep_concepto = @i_concepto)
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603079
		return 1
	end
	else
	begin
		insert into cb_exencion_producto
		       (ep_empresa,ep_regimen,ep_producto,
                        ep_impuesto,ep_concepto)
		values (@i_empresa,@i_regimen,@i_producto,
			@i_impuesto,@i_concepto)
		if @@error <> 0 
		begin
			/* 'Error en creacion de ciudad' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603079
			return 1
		end
	end
	return 0
end

if @i_operacion = 'D'
begin
	if exists (select 1 from cb_exencion_producto
		where ep_empresa = @i_empresa
                and   ep_regimen = @i_regimen
                and   ep_producto = @i_producto
		and   ep_impuesto = @i_impuesto
		and   ep_concepto = @i_concepto
)
	begin
		delete cb_exencion_producto
		where ep_empresa = @i_empresa
                and   ep_regimen = @i_regimen
                and   ep_producto = @i_producto
		and   ep_impuesto = @i_impuesto
		and   ep_concepto = @i_concepto
		if @@error <> 0 
		begin
			/* 'Error en eliminacion de ciudad' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607134
			return 1
		end
	end
	else
	begin
		/* 'Error en eliminacion de ciudad' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607134
		return 1
	end
	return 0
end



if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select  'PRODUCTO' = ep_producto,
			'DESCRIPCION' = pd_descripcion,
			'IMPUESTO' = ep_impuesto, 
			'CONCEPTO' = ep_concepto
		from cb_exencion_producto, cobis..cl_producto
		where ep_empresa = @i_empresa
                and   ep_regimen = @i_regimen
		and   pd_producto = ep_producto
                order by ep_producto,ep_impuesto,ep_concepto
	end
	else
	begin
		select  'PRODUCTO' = ep_producto,
			'DESCRIPCION' = pd_descripcion,
			'IMPUESTO' = ep_impuesto, 
			'CONCEPTO' = ep_concepto
		from cb_exencion_producto, cobis..cl_producto
		where ep_empresa = @i_empresa
                and   ep_regimen = @i_regimen
		and   pd_producto = ep_producto
		and   (
			(ep_producto > @i_producto) or
			(ep_producto = @i_producto and ep_impuesto > @i_impuesto) or
                        (ep_producto = @i_producto and ep_impuesto = @i_impuesto and ep_concepto > @i_concepto)  
		)
                order by ep_producto,ep_impuesto,ep_concepto

	end
	set rowcount 0
	return 0
end



go
