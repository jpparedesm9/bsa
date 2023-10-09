/************************************************************************/
/*	Archivo: 		relsearc.sp				*/
/*	Stored procedure: 	sp_relacion				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           G. Jaramillo                        	*/
/*	Fecha de escritura:     04-Agosto-1993				*/
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
/*	   Mantenimiento al catalogo de Plan General                    */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	28/29/1997	MV.Garay        cambio en operacion S MVG       */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relsearc')
	drop proc sp_relsearc

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_relsearc    (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_empresa 	tinyint = null,
	@i_cuenta 	cuenta = null,
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_transer	char(1) = null,
	@i_cuenta1	cuenta = null,
	@i_cuenta2	cuenta = null,
	@i_oficina1	smallint = null,
	@i_area1	smallint = null,
	@i_sinonimo	char(20) = null

)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */

	@w_empresa 	tinyint ,
	@w_cuenta 	cuenta,
	@w_movimiento 	char(1),
	@w_nombre	descripcion,
	@w_estado 	char(1) ,
        @flag1 		int, 
	@flag2 		int, 
	@flag3 		int, 
	@padre_cta	cuenta,
	@padre_area	smallint,
	@padre_oficina	smallint,
	@temp_oficina	smallint,
	@temp_area	smallint,
	@cuenta_nom 	varchar(64),
	@oficina_nom	varchar(64),
	@w_tipo_plan	char(2),
	@w_depto	char(2),
	@w_moneda	tinyint,
	@w_moneda_base	tinyint,
	@w_extranjera	char(1),
	@w_usadeci	char(1),
	@w_area		int,
	@w_area1	int,
	@w_area2	int,
	@w_oficina1	int,
	@w_oficina2	int,
	@w_cont 	int 

select @w_today = getdate()
select @w_sp_name = 'sp_relsearc'

/************************************************/
/*  Tipo de Transaccion = 607X 			*/

if (@t_trn <> 6075 and @i_operacion = 'S')
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
		s_ssn		= @s_ssn,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa 	= @i_empresa,   
		i_cuenta 	= @i_cuenta,
		i_oficina 	= @i_oficina 
	exec cobis..sp_end_debug
end

if @i_area is null
begin
	select  @w_area1 = 0,
	       	@w_area2 = 999999 
end
else begin
	select 	@w_area1 = @i_area,
	       	@w_area2 = @i_area
end


if @i_oficina is null
begin
	select 	@w_oficina1 = 0,
	      	@w_oficina2 = 999999 
end
else begin
	select  @w_oficina1 = @i_oficina,
		@w_oficina2 = @i_oficina
end


if @i_operacion = 'S'    /* Search */
begin
	set rowcount 100 -- MVG se cambio el rowconut de 500 a 80  
	if @i_modo = 0
	begin
		select pg_oficina,pg_area
		from cb_oficina,cb_area,cb_plan_general
		where
		 	pg_empresa = @i_empresa and
			pg_cuenta = @i_cuenta  and
			of_empresa = @i_empresa and
                        of_oficina > 0 and
			of_oficina  = pg_oficina and 
			ar_empresa = @i_empresa and
                        ar_area > 0 and
			ar_area = pg_area  and
                 	of_movimiento = 'S' and
			ar_movimiento = 'S' 
                order by pg_area,pg_oficina
		
		if @@rowcount = 0
		begin
		      /* 'No existen Cuentas'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601029
			return 1
		end
	end
	if @i_modo = 1
	begin

		select pg_oficina,pg_area
		from cb_oficina,cb_area,cb_plan_general
		where
                        of_oficina = pg_oficina and 
		 	pg_empresa = @i_empresa and
			pg_cuenta = @i_cuenta  and
                        ((ar_area = @i_area1 and
                          of_oficina > @i_oficina1) or
                         (ar_area > @i_area1)) and 
			of_empresa = @i_empresa and
			ar_empresa = @i_empresa and
                        pg_area = ar_area and 
                 	of_movimiento = 'S' and
			ar_movimiento = 'S' 
                order by pg_area,pg_oficina


		if @@rowcount = 0
		begin
			return 1
		end
	end			
	if @i_modo = 2
	begin
                select pg_oficina,pg_area
                from    cb_oficina,cb_area,cb_plan_general
                where
                        pg_empresa = @i_empresa and
                        pg_cuenta = @i_cuenta and
                        ((of_oficina > @i_oficina1 and ar_area = @i_area1) or 
                         (ar_area > @i_area1)) and
                        of_empresa = @i_empresa and
                        ar_empresa = @i_empresa and
                        ar_area    > 0 and
                        pg_oficina = of_oficina and
                        pg_area = ar_area and
                        of_movimiento = 'S' and
                        ar_movimiento = 'S'                          
                order by pg_area,pg_oficina

		if @@rowcount = 0
		begin
			return 1
		end
	end			
	
	return 0
end
go
