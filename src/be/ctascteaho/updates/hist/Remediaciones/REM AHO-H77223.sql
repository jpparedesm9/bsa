/************************************************************************/
/*  Archivo:            REM AHO-H77223.sql                              */
/*  Base de datos:      cobis                                           */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Eduardo Williams                                */
/*  Fecha de escritura: 19-Jul-2016                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
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
/*                        PROPOSITO                                     */
/* Script de instalacion para AHO-H77223 y AHO-H77224                   */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/************************************************************************/
/*  FECHA             AUTOR               RAZON                         */
/*  19/Jul/2016       Eduardo Williams    Emision inicial               */
/*  22/Jul/2016       Eduardo Williams    Se agrega creacion de tabla   */
/*                                        cl_cuentas_embargo            */
/************************************************************************/
use cobis
go

/**************************************************/
/*                 Parametros                     */
/**************************************************/
delete from cl_parametro where pa_producto = 'AHO' and pa_nemonico in ('VCHPRO', 'VCHREM')
go
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('Visualizar campo cheques propios en deposito de ahorros', 'VCHPRO', 'C', 'N', 'AHO'),
       ('Visualizar campo cheques remesas en deposito de ahorros', 'VCHREM', 'C', 'N', 'AHO')
go
delete from cl_parametro where pa_producto = 'ADM' and pa_nemonico in ('TIDB')
go
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_float, pa_producto)
values ('TASA DE IMPUESTO AL DEBITO BANCARIO', 'TIDB', 'F', 0, 'ADM')
go
print 'Parametros...OK'
go

/**************************************************/
/*      Parametros para deposito inicial          */
/**************************************************/
delete from cob_ahorros..ah_trn_deposito_inicial
go
insert into cob_ahorros..ah_trn_deposito_inicial (di_tran, di_causal, di_descripcion, di_estado)
values (300, '0',    'TRANSFERENCIA ENTRE CUENTAS CREDITO',                              'V'),
       (251, '0',    'DEPOSITO DE AHORROS CON LIBRETA',                                  'V'),
       (252, '0',    'DEPOSITO DE AHORROS',                                              'V'),
       (253, '0',    'NOTA CREDITO - SIN CAUSAL',                                        'V'),
       (253, '107',  'NOTA CREDITO - DEVOLUCION GMF',                                    'V'),
       (253, '108',  'NOTA CREDITO - DEVOLUCION RETENCION EN LA FUENTE',                 'V'),
       (253, '109',  'NOTA CREDITO - CAMPAÐA AHORROS EMPLEADOS',                         'V'),
       (253, '110',  'NOTA CREDITO - TRANSFERENCIA DE CUENTAS OTROS BANCOS',             'V'),
       (253, '12',   'NOTA CREDITO - CANCELACION  DEPOSITOS PLAZO FIJO',                 'V'),
       (253, '17',   'NOTA CREDITO - TRANSFERENCIA DE SALDOS',                           'V'),
       (253, '200',  'NOTA CREDITO - CORRECCION DE DEPOSITOS',                           'V'),
       (253, '205',  'NOTA CREDITO - PAGO A PROVEEDORES',                                'V'),
       (253, '21',   'NOTA CREDITO - DESEMBOLSO DE CREDITO',                             'V'),
       (253, '218',  'NOTA CREDITO - ABONO MANUAL DE INTERESES',                         'V'),
       (253, '229',  'NOTA CREDITO - AJUSTE POR ERROR EN NUMERO DE CUENTA',              'V'),
       (253, '237',  'NOTA CREDITO - CAMARA Y REMESAS',                                  'V'),
       (253, '242',  'NOTA CREDITO - POR GIRO WESTERN UNION',                            'V'),
       (253, '30',   'NOTA CREDITO - REVERSO DE APERTURA DEPOSITOS PLAZO FIJO',          'V'),
       (253, '4',    'NOTA CREDITO - DEVOLUCION COMISION REMESAS',                       'V'),
       (253, '43',   'NOTA CREDITO - REVERSA COMISION VENTA CHQ GERENCIA',               'V'),
       (253, '47',   'NOTA CREDITO - ABONO INTERESES RECALCULADOS',                      'V'),
       (253, '48',   'NOTA CREDITO - REINTEGRO PAGO DE CARTERA',                         'V'),
       (253, '49',   'NOTA CREDITO - ** POR DEFINIR ENTREGA MONTO MIN INEMBARGABLE **',  'V'),
       (253, '6',    'NOTA CREDITO - CONFIRMACION CH REMESAS COB',                       'V'),
       (253, '39',   'DEPOSITO A CUENTA POR CB',                                         'V')
go
print 'Parametros para deposito inicial...OK'
go

/**************************************************/
/*            Tabla cl_cuentas_embargo            */
/**************************************************/
if exists (select 1 from sysobjects where name = 'cl_cuentas_embargo')
   drop table cl_cuentas_embargo
go
create table cl_cuentas_embargo
(ce_cliente         int        not null,
 ce_fecha_crea      datetime   not null,
 ce_fecha_mod       datetime   not null,
 ce_fecha_cierre    datetime   null,
 ce_tipo_emb        char(1)    not null,
 ce_estado          char(1)    null,
 ce_cta_banco       cuenta     null,
 ce_num_emb         smallint   not null,
 ce_valor_ret       money      not null,
 ce_producto        tinyint    not null,
 ce_valor_emb       money      not null,
 ce_parametro_emb   varchar(6) not null)
go
print 'Tabla cl_cuentas_embargo...OK'
go

print 'INSTALACION OK'
go
