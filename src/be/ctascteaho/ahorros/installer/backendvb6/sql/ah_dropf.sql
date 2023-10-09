/************************************************************************/
/*      Archivo:            ah_dropf.sql                                 */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de los indices                */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/

use cob_ahorros
go

if exists( select 1 from sysindexes where name='i_ah_acumulador')
    drop index ah_acumulador.i_ah_acumulador
 go 


if exists( select 1 from sysindexes where name='idx1')
    drop index ah_aut_retiro_ofic.idx1
 go 


if exists( select 1 from sysindexes where name='ah_ciudad_deposito_Alt')
    drop index ah_ciudad_deposito.ah_ciudad_deposito_Alt
 go 

if exists( select 1 from sysindexes where name='ah_ciudad_deposito_Alt1')
    drop index ah_ciudad_deposito.ah_ciudad_deposito_Alt1
 go 

if exists( select 1 from sysindexes where name='i_idx_ah_condonacion')
    drop index ah_condonacion.i_idx_ah_condonacion
 go 

if exists( select 1 from sysindexes where name='i_idx_ah_condonacion_ente')
    drop index ah_condonacion.i_idx_ah_condonacion_ente
 go 

if exists( select 1 from sysindexes where name='idx1')
    drop index ah_ctas_cancelar.idx1
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_idx1')
    drop index ah_cuenta.ah_cuenta_idx1
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_idx2')
    drop index ah_cuenta.ah_cuenta_idx2
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_idx3')
    drop index ah_cuenta.ah_cuenta_idx3
 go 

if exists( select 1 from sysindexes where name='ah_cuenta_idx4')
    drop index ah_cuenta.ah_cuenta_idx4
 go 

if exists( select 1 from sysindexes where name='i_ah_cliente')
    drop index ah_cuenta.i_ah_cliente
 go 

if exists( select 1 from sysindexes where name='i_ah_cuenta')
    drop index ah_cuenta.i_ah_cuenta
 go 

if exists( select 1 from sysindexes where name='i_ah_nombre')
    drop index ah_cuenta.i_ah_nombre
 go 

if exists( select 1 from sysindexes where name='i_ah_oficina')
    drop index ah_cuenta.i_ah_oficina
 go 


if exists( select 1 from sysindexes where name='i_ah_cuenta_tmp')
    drop index ah_cuenta_tmp.i_ah_cuenta_tmp
 go 

if exists( select 1 from sysindexes where name='i_ah_servicio_tmp')
    drop index ah_cuenta_tmp.i_ah_servicio_tmp
 go 

if exists( select 1 from sysindexes where name='ah_errorlog_1')
    drop index ah_errorlog.ah_errorlog_1
 go 

if exists( select 1 from sysindexes where name='ah_fecha_promedio_alt')
    drop index ah_fecha_promedio.ah_fecha_promedio_alt
 go 

if exists( select 1 from sysindexes where name='idx1')
    drop index ah_param_dtn.idx1
 go 

if exists( select 1 from sysindexes where name='ah_relacion_navidad_codigo')
    drop index ah_relacion_navidad.ah_relacion_navidad_codigo
 go 



if exists( select 1 from sysindexes where name='idx1')
    drop index ah_tran_mensual.idx1
 go 

if exists( select 1 from sysindexes where name='ah_tran_monet_Key')
    drop index ah_tran_monet.ah_tran_monet_Key
 go 

if exists( select 1 from sysindexes where name='ah_tran_monet_branch')
    drop index ah_tran_monet.ah_tran_monet_branch
 go 

if exists( select 1 from sysindexes where name='ah_tran_monet_sec')
    drop index ah_tran_monet.ah_tran_monet_sec
 go 

if exists( select 1 from sysindexes where name='ah_tran_monet_tran')
    drop index ah_tran_monet.ah_tran_monet_tran
 go 

if exists( select 1 from sysindexes where name='ah_tran_monet_sec_tmp')
    drop index ah_tran_monet_tmp.ah_tran_monet_sec_tmp
 go 

if exists( select 1 from sysindexes where name='ah_tran_monet_tran_tmp')
    drop index ah_tran_monet_tmp.ah_tran_monet_tran_tmp
 go 

if exists( select 1 from sysindexes where name='ah_tran_monet_valor_tmp')
    drop index ah_tran_monet_tmp.ah_tran_monet_valor_tmp
 go 

if exists( select 1 from sysindexes where name='idx1')
    drop index ah_tran_rechazos.idx1
 go 

if exists( select 1 from sysindexes where name='ah_tran_servicio_ofi_cta')
    drop index ah_tran_servicio.ah_tran_servicio_ofi_cta
 go 

if exists( select 1 from sysindexes where name='ah_tran_servicio_tran')
    drop index ah_tran_servicio.ah_tran_servicio_tran
 go 

if exists( select 1 from sysindexes where name='ah_tran_servicio_ofi_cta_tmp')
    drop index ah_tran_servicio_tmp.ah_tran_servicio_ofi_cta_tmp
 go 


if exists( select 1 from sysindexes where name='ah_tran_servicio_tran_tmp')
    drop index ah_tran_servicio_tmp.ah_tran_servicio_tran_tmp
 go 

if exists( select 1 from sysindexes where name='idx1')
    drop index ah_trn_deposito_inicial.idx1
 go 

if exists( select 1 from sysindexes where name='idx1')
    drop index ah_universo_ahmensual.idx1
 go

if exists( select 1 from sysindexes where name='i_vs_ssn')
    drop index ah_val_suspenso.i_vs_ssn
 go 

if exists( select 1 from sysindexes where name='if_cp_campoah')
    drop index cp_campoah.if_cp_campoah
 go 

if exists( select 1 from sysindexes where name='if_cp_campoah_monet')
    drop index cp_campoah_monetario.if_cp_campoah_monet
 go 

 
-- ---------------------------------------------------------------------
-- ------------------------COB_AHORROS_HIS------------------------------
use cob_ahorros_his
go
-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------

if exists( select 1 from sysindexes where name='ah_his_movimiento_1')
    drop index ah_his_movimiento.ah_his_movimiento_1
 go 

