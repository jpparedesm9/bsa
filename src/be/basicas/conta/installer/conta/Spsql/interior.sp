/************************************************************************/
/*	Archivo: 		interior.sp			        */
/*	Stored procedure: 	sp_interior				*/
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
/*	   Busquedas al catalogo de comprobantes                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	21/Nov/1994	G Jaramillo     Emision Inicial			*/
/*	14/03/1997	Rafael Villota	Personalizacion CajaCoop	*/
/*	17/Jul/1997	F Salgado	Eliminacion opcion 'I' por	*/
/*					cambio en Suc. y Agenc		*/
/*	01/Mar/1999	O.Escand¢n 	Nuevo par metro @i_cuenta	*/
/*					Concepto de consulta		*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_interior')
	drop proc sp_interior 
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_interior  (
	@s_ssn		 int          = null,
	@s_date		 datetime     = null,
	@s_user		 login        = null,
	@s_term		 descripcion  = null,
	@s_corr		 char(1)      = null,
	@s_ssn_corr	 int          = null,
        @s_ofi		 smallint     = null,
	@t_rty		 char(1)      = null,
        @t_trn		 smallint     = null,
	@t_debug	 char(1)      = 'N',
	@t_file		 varchar(14)  = null,
	@t_from		 varchar(30)  = null,
	@i_operacion	 char(1)      = null,
	@i_modo		 smallint     = null,
	@i_empresa	 tinyint      = null,
	@i_oficina	 smallint     = null,
	@i_area  	 smallint     = null,
	@i_asiento       smallint     = null,
	@i_comprobante	 int          = 0,
	@i_comprobante1	 int          = 10000000,
	@i_autorizado	 char(1)       = "%",
	@i_mayorizado	 char(1)       = "%",
	@i_aprobado	 char(1)       = "%",
	@i_fecha_tran	 datetime     = "1990/01/01",
	@i_fecha_tran1	 datetime     = "2099/12/31" ,
	@i_oficina1	 smallint     = null,
	@i_area1  	 smallint     = null,
	@i_comprobante2  int          = null ,
	@i_automatico    smallint     = null,
        @i_formato_fecha tinyint      = 1,
        @i_digitador     descripcion  = "%",
        @i_detalles      smallint     = null,
        @i_programa      int      = 6002, /* codigo de programa batch */
	@i_cuenta	cuenta = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_oficina1	smallint,
	@w_oficina2	smallint,
	@w_area1	smallint,
	@w_area2	smallint ,
        @w_cuenta1      cuenta,
        @w_cuenta2      cuenta,
	@w_automat1	smallint,
	@w_automat2	smallint,	
	@w_comprobante	int,
	@w_comprobante1	int,
	@w_oficina_orig smallint,
	@w_area_orig    smallint,
	@w_tipo_doc	char(1),
	@w_tipo_tran	char(1),
	@w_asiento	smallint,
        @w_cta_proc     char(20), 
        @w_cta_proc1    char(20), 
        @w_cta_proc2    char(20), 
	@w_debito	money,
	@w_credito	money,
	@w_debito_me	money,
	@w_credito_me	money,
	@w_moneda	tinyint,
	@w_concepto	descripcion, 
	@w_contador  	smallint,
	@w_filas	int,
	@w_valido	tinyint,
        @w_condicion    smallint

select @w_today   = getdate()
select @w_sp_name = 'sp_interior'


/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6725 and @i_operacion = 'S')  or
   (@t_trn <> 6726 and @i_operacion = 'O') 
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
		i_empresa 	= @i_empresa,
		i_fecha_tran 	= @i_fecha_tran, 
		i_comprobante1 	= @i_comprobante1,	 
		i_cuenta        = @i_cuenta
	exec cobis..sp_end_debug
end


if @i_automatico is null
begin
	select @w_automat1 = 0,
	       @w_automat2 = 32000
end
else begin
	select @w_automat1 = @i_automatico,
	       @w_automat2 = @i_automatico
end	

set rowcount 20
if @i_operacion = 'O'
  begin
   if @i_modo = 0
      begin
      select 'Ofic'     = as_oficina_dest, 
             'Area'     = as_area_dest  ,
     	     'Comp'     = co_comprobante,
             'Fecha'    = convert(char(12),as_fecha_tran,@i_formato_fecha),
             'May.'     = co_mayorizado,
             'Aut.'     = co_autorizado,
	     'Ast.'     = as_asiento,
	     'Cuenta'   = as_cuenta,
             'Nombre'   = cu_nombre,
	     'Debito'   = as_debito,
	     'Credito'  = as_credito,
	     'Deb_ME'   = as_debito_me,
	     'Crd_ME'   = as_credito_me,
	     'Concepto' = as_concepto
      from cob_conta..cb_comprobante,cob_conta..cb_asiento,
           cob_conta..cb_cuenta
      where
               co_empresa      =       @i_empresa     and
               (co_fecha_tran  between @i_fecha_tran  and @i_fecha_tran1) and 
	       (co_comprobante between @i_comprobante and @i_comprobante1) and 
     	       co_oficina_orig =       @i_oficina     and
	       co_area_orig    =       @i_area        and 
	       (co_automatico  between @w_automat1    and @w_automat2) and
	       (co_mayorizado  like    @i_mayorizado) and
	       (co_autorizado  like    @i_autorizado) and
               (co_digitador   like    @i_digitador)  and
	       as_empresa      =       co_empresa     and
	       as_comprobante  =       co_comprobante and
	       as_fecha_tran   =       co_fecha_tran  and
	       (as_oficina_dest <>      @i_oficina     or
	        as_area_dest    <>      @i_area    )   and 
	       as_empresa      =       cu_empresa     and
	       cu_cuenta       = 	@i_cuenta     and /* OJE */	
	       as_cuenta       =       cu_cuenta     

      order by as_oficina_dest,as_area_dest,co_comprobante,as_asiento
    end
   else
    begin
      select 'Ofic'     = as_oficina_dest, 
             'Area'     = as_area_dest  ,
     	     'Comp'     = co_comprobante,
             'Fecha'    = convert(char(12),as_fecha_tran,@i_formato_fecha),
             'May.'     = co_mayorizado,
             'Aut.'     = co_autorizado,
	     'Ast.'     = as_asiento,
	     'Cuenta'   = as_cuenta,
             'Nombre'   = cu_nombre,
	     'Debito'   = as_debito,
	     'Credito'  = as_credito,
	     'Deb_ME'   = as_debito_me,
	     'Crd_ME'   = as_credito_me,
	     'Concepto' = as_concepto
      from cob_conta..cb_comprobante,cob_conta..cb_asiento,
           cob_conta..cb_cuenta
      where 	co_empresa      =       @i_empresa     	and
               	(co_fecha_tran  between @i_fecha_tran  	and @i_fecha_tran1) and 
--	       	(co_comprobante between @i_comprobante and @i_comprobante1) and 
     	       	co_oficina_orig =       @i_oficina     	and
	       	co_area_orig    =       @i_area        	and 
	       (co_automatico   between @w_automat1    	and @w_automat2) and
	       (co_mayorizado   like    @i_mayorizado) 	and
	       (co_autorizado  	like    @i_autorizado) 	and
               (co_digitador    like    @i_digitador)  	and
		as_empresa      = 	co_empresa	and
		as_comprobante  = 	co_comprobante	and
		as_fecha_tran   = 	co_fecha_tran 	and
		(as_oficina_dest <> 	@i_oficina 	or
		 as_area_dest	<> 	@i_area   )	and 
	      (
               (as_oficina_dest > @i_oficina1) or
	       (as_oficina_dest = @i_oficina1 		and
		as_area_dest    > @i_area1) or
   	       (as_oficina_dest = @i_oficina1 		and
		as_area_dest    = @i_area1 		and
		as_comprobante  > @i_comprobante) or
               (as_oficina_dest = @i_oficina1 		and
		as_area_dest    = @i_area1 		and
		as_comprobante  = @i_comprobante 	and
		as_asiento      > @i_asiento) 
              )						and	
	       as_empresa      =       cu_empresa       and
	       cu_cuenta       = @i_cuenta	        and	/* OJE */	
	       as_cuenta       =       cu_cuenta     
      order by as_oficina_dest,as_area_dest,co_comprobante,as_asiento
    end
  end
else
  if @i_operacion = 'S'
    begin
    if @i_modo = 0
      begin
      select 'Ofic'	= co_oficina_orig, 
             'Area' 	= co_area_orig,
     	     'Comp' 	= co_comprobante,
             'Fecha'    = convert(char(12),as_fecha_tran,@i_formato_fecha),
             'May.'     = co_mayorizado,
             'Aut.'     = co_autorizado,
	     'Ast.'    	= as_asiento,
	     'Cuenta' 	= as_cuenta,
             'Nombre'   = cu_nombre,
	     'Debito' 	= as_debito,
	     'Credito' 	= as_credito,
	     'Deb_ME'  	= as_debito_me,
	     'Crd_ME'  	= as_credito_me,
	     'Concepto' = as_concepto
      from cb_asiento,cb_comprobante, cb_cuenta
      where	as_empresa     	=	@i_empresa     and
	      (as_fecha_tran  	between @i_fecha_tran  and @i_fecha_tran1) and 
	      (as_comprobante 	between @i_comprobante and @i_comprobante1) and 
	       as_oficina_dest 	= 	@i_oficina	and
	       as_area_dest    	= 	@i_area 	and 
	       as_empresa      	=	co_empresa 	and
	       as_comprobante  	= 	co_comprobante 	and
	       as_fecha_tran   	= 	co_fecha_tran 	and
	       (co_oficina_orig	<> 	@i_oficina 	or
	       co_area_orig	<> 	@i_area   ) 	and 
	      (co_automatico  	between @w_automat1    	and @w_automat2) and
	      (co_mayorizado  	like    @i_mayorizado) 	and
              (co_digitador   	like    @i_digitador)  	and
	      (co_autorizado  	like    @i_autorizado)  and
	       as_empresa       =       cu_empresa      and
	       cu_cuenta       = 	@i_cuenta	and /* OJE */	
	       as_cuenta        =       cu_cuenta     
     order by co_oficina_orig,co_area_orig,co_comprobante,as_asiento
   end
   else
    begin
      select 'Ofic' 	= co_oficina_orig, 
             'Area' 	= co_area_orig  ,
     	     'Comp' 	= co_comprobante,
             'Fecha'    = convert(char(12),as_fecha_tran,@i_formato_fecha),
             'May.'     = co_mayorizado,
             'Aut.'     = co_autorizado,
	     'Ast.'    	= as_asiento,
	     'Cuenta' 	= as_cuenta,
             'Nombre'   = cu_nombre,
	     'Debito' 	= as_debito,
	     'Credito' 	= as_credito,
	     'Deb_ME'  	= as_debito_me,
	     'Crd_ME'  	= as_credito_me,
	     'Concepto' = as_concepto
      from cob_conta..cb_asiento,cob_conta..cb_comprobante,
	   cob_conta..cb_cuenta
      where	
		as_empresa      = 	@i_empresa 	and
	      (as_fecha_tran  	between @i_fecha_tran  	and @i_fecha_tran1) and 
	      (as_comprobante 	between @i_comprobante and @i_comprobante1) and 
		as_oficina_dest = 	@i_oficina 	and
		as_area_dest	= 	@i_area 	and 
		as_empresa      = 	co_empresa 	and
		as_comprobante  = 	co_comprobante 	and
		as_fecha_tran   = 	co_fecha_tran 	and
	       (co_oficina_orig <> 	@i_oficina 	or
		co_area_orig	<> 	@i_area  )  	and 
	       (co_automatico   between @w_automat1    	and @w_automat2) and
	       (co_mayorizado   like    @i_mayorizado) 	and
	       (co_autorizado  	like    @i_autorizado) 	and
               (co_digitador    like    @i_digitador)  	and
	      (
               (co_oficina_orig = @i_oficina1 		and
		co_area_orig    = @i_area1 		and
		co_comprobante  = @i_comprobante 	and
		as_asiento      > @i_asiento)
              or
   	       (co_oficina_orig = @i_oficina1 		and
		co_area_orig    = @i_area1 		and
		co_comprobante  > @i_comprobante)
              or
	       (co_oficina_orig = @i_oficina1 		and
		co_area_orig    > @i_area1)
              or
	       (co_oficina_orig > @i_oficina1)
             )						and
	       as_empresa       =       cu_empresa      and
	       cu_cuenta       = @i_cuenta		and	/* OJE */	
	       as_cuenta        =       cu_cuenta     
      order by co_oficina_orig,co_area_orig,co_comprobante,as_asiento
     end
end

if @@rowcount = 0
begin
	/* 'no existen comprobantes' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601060
	return 1
end

return 0
go

