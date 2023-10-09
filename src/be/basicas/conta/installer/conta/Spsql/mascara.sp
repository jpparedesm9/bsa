/************************************************************************/
/*	Archivo: 		mascara.sp 			        */
/*	Stored procedure: 	sp_mascara  				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Juan Uria / Gonzalo Jaramillo          	*/
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
/*	   								*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_mascara')
	drop proc sp_mascara

go
create proc sp_mascara     (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 6336, 
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_empresa      	tinyint = null 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_existe	int,		/* codigo existe = 1 
					       no existe = 0 */
	@w_empresa    	tinyint,
	@w_moneda_base 	tinyint,
	@w_mascara	varchar(40),
	@w_mascara2	varchar(20),
	@w_nivel_cuenta tinyint,
	@w_longitud	tinyint,
	@w_rows		tinyint,
	@w_contador	tinyint,
	@w_flag1	tinyint,
	@w_usa_cc	char(1),
	@w_descripcion	descripcion
	
select @w_today = getdate()
select @w_sp_name = 'sp_mascara'
select @w_mascara = null
select @w_mascara2 = null

/*************************************************/
if @t_trn <> 6336
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/*************************************************/

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_empresa    	= @i_empresa 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
select @w_descripcion = em_descripcion 
from cob_conta..cb_empresa
where em_empresa = @i_empresa

if @@rowcount = 0
begin
	/* 'No existe empresa especificada   ' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601018
	return 1
end

select @w_rows = count(*)
from cob_conta..cb_nivel_cuenta
where nc_empresa = @i_empresa
	
if @w_rows = 0
begin
	select @w_mascara,@w_mascara2
end
else
begin
	select @w_mascara2 = '????????????????????'
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
	select @w_mascara,@w_mascara2
end
return 0

go

