/******************************************************************/
/*  Archivo:              ve_produ.sql                            */
/*  Base de datos:        cobis                                   */
/*  Producto:             CONTROL VERSIONES                       */
/*  Disenado por:         Santiago Garces G.                      */
/*  Fecha:                06-Oct-98                               */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de MACOSA, representantes exclusivos para  el Ecuador de  la  */
/*  NCR CORPORATION.  Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su  */
/*  representante                                                 */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Creacion del producto mediante insert y delete en las tablas  */
/*  cl_producto, cl_pro_moneda, ba_fecha_cierre, ad_pro_instalado */
/******************************************************************/
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*  06-Oct-98      S.Garces        Emision inicial                */
/*  12-Abr-16      BBO             Migracion SYBASE-SQLServer FAL */
/******************************************************************/


print 'Inicia ve_produ.sql ...'
go

use cobis
go

/******************************************************************/
/*                         cl_producto                            */
/******************************************************************/
print '----->  cl_producto'
go

if exists (select * from cl_producto where pd_producto = 99)
	delete cl_producto where pd_producto = 99
go

insert into cl_producto	(pd_producto, pd_tipo, pd_descripcion, pd_abreviatura,
			 pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
	values (99, 'R', 'CONTROL VERSION', 'VER', getdate(), 'V', null, null)
go

/******************************************************************/
/*                        cl_pro_moneda                           */
/******************************************************************/
print '----->  cl_pro_moneda'
go

if exists (select * from cl_pro_moneda where pm_producto = 99)
	delete cl_pro_moneda where pm_producto = 99
go

declare @w_moneda tinyint
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'


insert into cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion,
			   pm_fecha_aper, pm_estado)
	values (99, 'R', @w_moneda, 'CONTROL VERSION', getdate(),'V')
go

/******************************************************************/
/*                     ad_pro_instalado                           */
/******************************************************************/
print '------> ad_pro_instalado'
go

if exists (select * from ad_pro_instalado where pi_producto = 'VER')
	delete ad_pro_instalado where pi_producto = 'VER'
go

insert into ad_pro_instalado (pi_producto, pi_bdd, pi_transaccion, pi_uso_firmas, 
			      pi_nomfirmas, pi_qrfirmas, pi_trn_nom)
	values ('VER', 'cobis', null, 'S', null, null, null)
go

/******************************************************************/
/*                      ba_fecha_cierre                           */
/******************************************************************/
--****JHI: Se comenta insercion porque este paso lo hace VisualBatch *******
--print '------> ba_fecha_cierre'
--go

--if exists (select * from ba_fecha_cierre where fc_producto = 99)
--	delete ba_fecha_cierre where fc_producto = 99
--go

--insert into ba_fecha_cierre
--	values (99, getdate(), null)
--go
--*****JHI: Se comenta insercion porque este paso lo hace VisualBatch *******

print 'Finaliza ve_produ.sql'
go

