/************************************************************************/
/*	Archivo: 		temdctip.sp			        */
/*	Stored procedure: 	sp_temdctip				*/
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
/*	   Grava el detalle  de los comprobantes tipo  a la tabla       */
/*	   temporal							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_temdctip')
	drop proc sp_temdctip 
go
create proc sp_temdctip   (
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
	@i_comp_tipo	int = null,
	@i_asiento	smallint = null,
	@i_empresa      tinyint = null,
	@i_cuenta	cuenta = null,
	@i_oficina_dest smallint  = null,
	@i_area_dest	smallint = null,
	@i_debe		money = null,
	@i_haber	money = null,
	@i_debe_me	money = null,
	@i_haber_me 	money = null,
	@i_cotizacion	money = null,
	@i_concepto	char(255) = null,
	@i_tipo_doc	char(1) = null,
	@i_tipo_tran	char(1) = null
)
as 
declare
	@w_today 	datetime,  	/* Fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/

	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */
	@w_empresa    	tinyint,     
	@w_moneda	tinyint,
	@w_cuenta       cuenta

select @w_today = getdate()
select @w_sp_name = 'sp_temdctip'



/************************************************/
/*  Tipo de Transaccion = 612X 			*/

if (@t_trn <> 6340 and @i_operacion = 'I') 
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
		i_empresa  	= @i_empresa,      
		i_cuenta     	= @i_cuenta  
	exec cobis..sp_end_debug
end


/**************** VALIDACIONES ***********************/

	if NOT EXISTS (select * from cb_empresa 
			where em_empresa = @i_empresa)
	begin
		/* 'Empresa especificada no existe    ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018

                delete cob_conta..cb_tcomp_tipo
                where   tt_empresa = @i_empresa and
                        tt_comp_tipo = @i_comp_tipo

                delete cob_conta..cb_tdet_comptipo
                where   tct_empresa = @i_empresa and
                        tct_comp_tipo = @i_comp_tipo

		return 1
	end

	if NOT EXISTS (select * from cob_conta..cb_plan_general
			where 	pg_empresa = @i_empresa and
				pg_oficina = @i_oficina_dest and
				pg_area	   = @i_area_dest and
				pg_cuenta  = @i_cuenta )
	begin
		/* 'Cuenta de movimiento no existe       ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601055

                delete cob_conta..cb_tcomp_tipo
                where   tt_empresa = @i_empresa and
                        tt_comp_tipo = @i_comp_tipo

                delete cob_conta..cb_tdet_comptipo
                where   tct_empresa = @i_empresa and
                        tct_comp_tipo = @i_comp_tipo

		return 1
	end
	else begin
		select @w_moneda = cu_moneda
		from cob_conta..cb_cuenta
		where cu_empresa = @i_empresa and
		      cu_cuenta  = @i_cuenta
	end

if @i_operacion = 'I'
begin
	begin tran
	    insert into cob_conta..cb_tdet_comptipo (tct_comp_tipo,
		tct_asiento,tct_empresa,tct_cuenta,tct_oficina_dest,
		tct_area_dest,tct_debe,tct_haber,tct_debe_me,
		tct_haber_me,tct_cotizacion,tct_concepto,tct_tipo_doc,
		tct_tipo_tran)
	    values (@i_comp_tipo,@i_asiento,@i_empresa,@i_cuenta,
		@i_oficina_dest,@i_area_dest,@i_debe,@i_haber,@i_debe_me,
		@i_haber_me, @i_cotizacion,@i_concepto,@i_tipo_doc,
		@i_tipo_tran)
	    if @@error <> 0
	    begin
	    /* 'Error en insercion de detalle de plan especifico en tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603035
		return 1
	    end
	commit tran
return 0
end

go
