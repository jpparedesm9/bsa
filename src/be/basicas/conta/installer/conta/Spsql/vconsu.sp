/************************************************************************/
/*	Archivo: 		vconsu.sp			        */
/*	Stored procedure: 	sp_vconsu				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
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
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa agrupa los comprobantes auxiliares y los pasa	*/
/*      a definitivos.                                                  */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_valida_consu')
	drop proc sp_valida_consu
go

create proc sp_valida_consu (
	@i_empresa     tinyint		= null,
	@i_fecha       datetime         = null,
	@i_digitador   descripcion	= null,
	@i_producto    tinyint		= null)
as

declare 
   @w_fecha_min	  datetime,
   @w_filas	      int,
   @w_error	      int,
   @w_return      int,
   @w_fecha	      datetime, 
   @w_producto    tinyint

select co_fecha_ini
into #fechas
from   cob_conta..cb_corte
where  co_empresa    = @i_empresa
and    co_fecha_ini <= @i_fecha
and    co_estado    in ('A','V')

if @@rowcount = 0
begin	/* 'PERIODO O CORTE NO VIGENTE O CERRADO' */
   print 'Error en la consulta de la fecha minima de corte activo o vigente'
   return 1
end

--update statistics cob_conta_tercero..ct_scomprobante

delete cob_conta..cb_errores_consu
where (ec_producto = @i_producto or @i_producto = 0)

select 	 sc_producto,		sc_fecha_tran,		sc_comprobante,
		 sc_oficina_orig,	sc_area_orig,		sc_perfil,
		 sa_oficina_dest,	sa_area_dest,       sa_cuenta,
		 sa_tipo_doc,       sa_debito,          sa_credito,
		 sa_debito_me,      sa_credito_me,      
		 sa_concepto = '(%'+ convert(varchar(4),sc_producto) + '-' + convert(varchar(4),sc_automatico) + '%)'+sa_concepto,
		 sc_descripcion
into   #_tmp
from   cob_conta_tercero..ct_scomprobante with (index = ct_scomprobante_Key nolock),
	    cob_conta_tercero..ct_sasiento with (index = ct_sasiento_AKey0 nolock)
where  sc_fecha_tran in (select co_fecha_ini from #fechas)
and    sc_estado     = 'B'
and    sc_empresa    = @i_empresa
and    (sc_producto   = @i_producto or @i_producto = 0)
and    sa_empresa     = sc_empresa	
and    sa_producto    = sc_producto	
and    sa_fecha_tran  = sc_fecha_tran	
and    sa_comprobante = sc_comprobante
and    sa_asiento     >= 0

select @w_filas = @@rowcount,
       @w_error = @@error

if @w_filas = 0
   return 0

if @w_error <> 0
begin
   print 'Error en generacion de tabla de trabajo para comprobantes por validar'
   return 1
end	        


exec @w_return = cob_conta..sp_consu_pro 
@i_empresa     = @i_empresa,
@i_digitador   = @i_digitador

if @w_return <> 0 
   return 1

return 0
go
