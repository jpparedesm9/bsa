/************************************************************************/
/*      Archivo:            ah_dropv.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
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
/*      Este programa realiza la eliminacion de vistas                  */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cob_ahorros
go


print '--------------> ah_retiro'
go
if exists (select 1 from sysobjects where type='V' and name='ah_retiro')
    drop view ah_retiro
go


print '--------------> ah_deposito'
go
if exists (select 1 from sysobjects where type='V' and name='ah_deposito')
    drop view ah_deposito
go


print '--------------> ah_notcredeb'
go
if exists (select 1 from sysobjects where type='V' and name='ah_notcredeb')
    drop view ah_notcredeb
go


print '--------------> ah_apertura_caja'
go
if exists (select 1 from sysobjects where type='V' and name='ah_apertura_caja')
    drop view ah_apertura_caja
go


print '--------------> ah_cierre'
go
if exists (select 1 from sysobjects where type='V' and name='ah_cierre')
    drop view ah_cierre
go


print '--------------> ah_transferencia'
go
if exists (select 1 from sysobjects where type='V' and name='ah_transferencia')
    drop view ah_transferencia
go


print '--------------> ah_tssolape'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tssolape')
    drop view ah_tssolape
go


print '--------------> ah_tsapertura'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsapertura')
    drop view ah_tsapertura
go


print '--------------> ah_tsanulalib'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsanulalib')
    drop view ah_tsanulalib
go


print '--------------> ah_tscambia_estado'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tscambia_estado')
    drop view ah_tscambia_estado
go


print '--------------> ah_tscliente_ctahorro'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tscliente_ctahorro')
    drop view ah_tscliente_ctahorro
go


print '--------------> ah_tsbloqueo'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsbloqueo')
    drop view ah_tsbloqueo
go


print '--------------> ah_tscierre_cta'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tscierre_cta')
    drop view ah_tscierre_cta
go


print '--------------> ah_tssobregiro'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tssobregiro')
    drop view ah_tssobregiro
go


print '--------------> ah_tssolicita_ec'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tssolicita_ec')
    drop view ah_tssolicita_ec
go


print '--------------> ah_tsval_suspenso'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsval_suspenso')
    drop view ah_tsval_suspenso
go


print '--------------> ah_tsgerencia'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsgerencia')
    drop view ah_tsgerencia
go


print '--------------> ah_tspag_otrobanco'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tspag_otrobanco')
    drop view ah_tspag_otrobanco
go


print '--------------> ah_tsrem_ingresochq'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsrem_ingresochq')
    drop view ah_tsrem_ingresochq
go


print '--------------> ah_tsrem_chequedev'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsrem_chequedev')
    drop view ah_tsrem_chequedev
go


print '--------------> ah_tsrem_chequeconf'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsrem_chequeconf')
    drop view ah_tsrem_chequeconf
go


print '--------------> ah_tscalcul_inter'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tscalcul_inter')
    drop view ah_tscalcul_inter
go


print '--------------> ah_tsconsumo'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsconsumo')
    drop view ah_tsconsumo
go


print '--------------> ah_tsefectivo_caja'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsefectivo_caja')
    drop view ah_tsefectivo_caja
go
