/****************************************************************/
/* ARCHIVO:         wf_produ.sql	                        */
/* BASE DE DATOS:   cobis        				*/
/* PRODUCTO:        COBIS WORKFLOW                              */
/****************************************************************/
/*                         IMPORTANTE                           */
/* Esta aplicacion es parte de los paquetes bancarios propiedad */
/* de MACOSA S.A.                                               */
/* Su uso no  autorizado queda  expresamente prohibido asi como */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus */
/* usuarios sin el debido consentimiento por escrito de MACOSA. */
/* Este programa esta protegido por la ley de derechos de autor */
/* y por las  convenciones  internacionales de  propiedad inte- */
/* lectual.  Su uso no  autorizado dara  derecho a  MACOSA para */
/* obtener  ordenes de  secuestro o retencion y  para perseguir */
/* penalmente a los autores de cualquier infraccion.            */
/****************************************************************/
/*                          PROPOSITO                           */
/* Creacion del producto COBIS WorkFlow en las tablas de cobis. */
/****************************************************************/
/*                      MODIFICACIONES                          */
/* FECHA         AUTOR             RAZON                        */
/* 31-Jul-2001   Mario Valarezo A. Emision Inicial              */
/****************************************************************/


print 'Inicia wf_produ.sql ...'
go

set nocount on
go

use cobis
go

/******************************************************************/
/*                         cl_producto                            */
/******************************************************************/
print '----->  cl_producto'
go

if exists (select *
             from cl_producto
            where pd_producto = 43)

    delete cl_producto
     where pd_producto = 43
go

insert into cl_producto
       (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura,
        pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
values (43, 'R', 'WORKFLOW', 'CWF',
        getdate (), 'V', null, null)
go

/******************************************************************/
/*                        cl_pro_moneda                           */
/******************************************************************/
print '----->  cl_pro_moneda'
go

if exists (select *
             from cl_pro_moneda
            where pm_producto = 43)

    delete cl_pro_moneda
     where pm_producto = 43
go

insert into cl_pro_moneda
       (pm_producto, pm_tipo, pm_moneda,
        pm_descripcion, pm_fecha_aper, pm_estado)
values (43, 'R', 0,
        'WORKFLOW', getdate (), 'V')
go

/******************************************************************/
/*                     ad_pro_instalado                           */
/******************************************************************/
print '------> ad_pro_instalado'
go

if exists (select *
             from ad_pro_instalado
            where pi_producto = 'CWF')

    delete ad_pro_instalado
     where pi_producto = 'CWF'
go

insert into ad_pro_instalado
       (pi_producto, pi_bdd, pi_transaccion, pi_nomfirmas,
        pi_uso_firmas, pi_qrfirmas, pi_trn_nom, pi_trn_qry)
values ('CWF', 'cob_workflow', null,
        null, null, null, null, null)
go

/******************************************************************/
/*                      ba_fecha_cierre                           */
/******************************************************************/
print '------> ba_fecha_cierre'
go

if exists (select *
             from ba_fecha_cierre
            where fc_producto = 43)

  delete ba_fecha_cierre
   where fc_producto = 43
go

insert into ba_fecha_cierre
       (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
values (43, getdate (), null)
go

print 'Finaliza wf_produ.sql'
go
