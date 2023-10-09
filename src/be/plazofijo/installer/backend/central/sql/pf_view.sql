/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Vistas                                      */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go
print '********************************'
print '*****  CREACION DE VISTAS ******'
print '********************************'
print ''
print 'Inicio Ejecucion Creacion de Vistas Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Vista: pf_cotizacion'
if exists (select 1 from sysobjects where name = 'pf_cotizacion' and type = 'V')
   drop view pf_cotizacion
go

create view pf_cotizacion as
select
co_fecha             = ct_fecha,
co_hora              = ct_fecha,
co_moneda            = ct_moneda,
co_conta             = ct_compra,
co_compra_cheque     = ct_compra,
co_venta_cheque      = ct_venta,
co_compra_billete    = ct_compra,
co_venta_billete     = ct_venta
from  cob_conta..cb_cotizacion, cobis..cl_moneda a
where ct_moneda      = mo_moneda
and   ct_fecha       = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = a.mo_moneda)
go

print '-->Vista: pf_parametro'
if exists (select 1 from sysobjects where name = 'pf_parametro' and type = 'V')
   drop view pf_parametro
go

create view pf_parametro as
select ret_pag_int   = (select pa_char from cobis..cl_parametro where pa_producto = 'PFI' and pa_nemonico = 'RPI')
go

print ''
print 'Fin Ejecucion Creacion de Vistas Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''