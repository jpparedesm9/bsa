/************************************************************************/
/*	Archivo: 		verif_man.sp			        */
/*	Stored procedure: 	sp_verifica_manual  			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Rafael Villota C.                      	*/
/*	Fecha de escritura:     Enero 27 de 1997			*/
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
/*	Verifica si un comprobante contable fue ingresado manual	*/
/*	o automaticamente.						*/
/*	Permite modificar comprobantes contables ingresados manualmente */
/* 	y no mayorizados						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_verifica_manual')
	drop proc sp_verifica_manual
go
create proc sp_verifica_manual (
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
	@i_comprobante	int, 
  	@o_automatico	smallint = null  out
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
        @w_automatico  smallint 

select @w_today = getdate()
select @w_sp_name = 'sp_verifica_manual'

/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6995 and @i_operacion = 'V') or
   (@t_trn <> 6128 and @i_operacion = 'O') or
   (@t_trn <> 6130 and @i_operacion = 'A')
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
		i_comprobante   = @i_comprobante
	exec cobis..sp_end_debug
end

if @i_operacion = 'V'
   begin
      select  @w_automatico = co_automatico
      from cob_conta..cb_comprobante
      where co_comprobante = @i_comprobante

      select @o_automatico = @w_automatico
    end
go
