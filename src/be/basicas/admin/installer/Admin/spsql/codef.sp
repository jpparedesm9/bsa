/************************************************************************/
/*	Archivo: 		codef.sp				*/
/*	Stored procedure: 	sp_cons_default				*/
/*	Base de datos:  	cobis					*/
/*	Producto: 		Cuentas Corrientes			*/
/*	Disenado por:  		Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de escritura: 	14-Jun-1993				*/
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
/*	Determina el tipo de dato de un parametro de default definido	*/
/*	para una transaccion.						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	14-Jun-1993	S Ortiz		Emision inicial			*/
/*	04/May/94	F.Espinosa	Parametros tipo "S"		*/
/************************************************************************/

use cobis
go
if exists (select * from sysobjects where name = 'sp_cons_default')
	drop proc sp_cons_default
go










create proc sp_cons_default (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint = null,
	@i_pro			tinyint, 
	@i_tipo			char (1),
	@i_mon			tinyint,
	@i_trn			smallint,
	@i_nem			char (6),
	@i_cat			char (1)
) as
declare		@w_sp_name		varchar (30),
		@w_return		int,
		@w_int			int,
		@w_smallint		smallint,
		@w_float		float,
		@w_money		money,
		@o_tdato		descripcion,
		@o_valor		descripcion

/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_cons_default'

/*  Modo de debug  */


if @t_trn = 1584
begin

/*  Chequea existencias  */
if not exists	(select *
		   from	cl_pro_moneda
		  where	pm_producto = @i_pro
		    and	pm_tipo	    = @i_tipo
		    and	pm_moneda   = @i_mon)
begin
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 101031
	return 1
end

/*  Determina tipo de dato  */
select	@o_tdato    = df_tdato,
	@w_int	    = dt_int,
	@w_smallint = dt_smallint,
	@w_float    = dt_float,
	@w_money    = dt_money
  from	cl_def_tran,
	cl_default_tr
 where	dt_producto    = @i_pro
   and	dt_tipo	       = @i_tipo
   and	dt_moneda      = @i_mon
   and	dt_transaccion = @i_trn
   and	dt_default     = @i_nem
   and	dt_categoria	= @i_cat
   and	df_nemonico = dt_default

if @@rowcount != 1
begin
	/*  No existe default definido para transaccion  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 151034
	return 1
end

if @w_int is not null
   select @o_valor = convert(varchar(30), @w_int)
else	if @w_smallint is not null
		select @o_valor = convert(varchar(30), @w_smallint)
	else	if @w_float is not null
			select @o_valor = convert(varchar(30), @w_float)
		else	if @w_money is not null
				select @o_valor = convert(varchar(30), @w_money)



select	@o_tdato, @o_valor
end

else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
go

