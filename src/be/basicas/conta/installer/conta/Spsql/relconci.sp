/************************************************************************/
/*	Archivo: 		relconci.sp				*/
/*	Stored procedure: 	sp_relconci 				*/
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
/*	   Devuelve el numero de referencia interna para conciliacion   */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relconci')
	drop proc sp_relconci     

go
create proc sp_relconci     (
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
	@i_empresa	tinyint = null 
)
as 
declare @w_today 	datetime,  	/* fecha del dia */ 
	@w_return	int,		/* valor que retorna */ 
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	int,	/* siguiente codigo de empresa */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una empresa */

	@w_empresa	tinyint  	/* codigo de empresa */

select @w_today = getdate()
select @w_sp_name = 'sp_relconci'


/************************************************/
/*  Tipo de Transaccion = 603 			  

if (@t_trn <> 6882 and @i_operacion = 'I') or
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
 ************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion = 'I'
begin
	exec @w_return = cob_conta..sp_cseqnos @i_tabla = 'cb_conciliacion',
                        @i_empresa = @i_empresa,
			@o_siguiente = @w_siguiente out
	if @w_return <> 0
		return @w_return
	else
		select @w_siguiente
end
go
