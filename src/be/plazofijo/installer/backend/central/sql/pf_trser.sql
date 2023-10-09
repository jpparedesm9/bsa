/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Transacciones de Servicio                   */
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
GO

SET QUOTED_IDENTIFIER ON
GO

print '*************************************'
print '*****  CREACION DE TR SERVICIO ******'
print '*************************************'
print ''
print 'Inicio Ejecucion Creacion de Transacciones de Servicio Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Transaccion Servicio: ts_autoretenedor'
if exists (select 1 from sysobjects where name = 'ts_autoretenedor' and type = 'V')
   drop view ts_autoretenedor
go

create view ts_autoretenedor as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
autoretenedor        = ts_char1_01,
fecha_autoret        = ts_datetime_01,
retienimp            = ts_char1_02,
monto                = ts_money_01,
ente                 = ts_int_01,
num_cuenta           = ts_cuenta_01,
hora                 = ts_datetime_03
from  cob_pfijo..pf_tran_servicio
where ts_tipo_transaccion in (14959)
go

print '-->Transaccion Servicio: ts_auxiliar_tip'
if exists (select 1 from sysobjects where name = 'ts_auxiliar_tip' and type = 'V')
   drop view ts_auxiliar_tip
go

create view ts_auxiliar_tip as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
tipo_deposito        = ts_int_04,
moneda               = ts_tinyint_02,
tipo                 = ts_varchar5_01,
valor                = ts_catalogo_01,
estado               = ts_char1_01,
fecha_crea           = ts_datetime_01,
fecha_elim           = ts_datetime_02,
porcentaje           = ts_money_01,
ofi		             = ts_ofi  
from  pf_tran_servicio
where ts_tipo_transaccion in (14136,14336,14436)
go

print '-->Transaccion Servicio: ts_beneficiario'
if exists (select 1 from sysobjects where name = 'ts_beneficiario' and type = 'V')
   drop view ts_beneficiario
go

create view ts_beneficiario as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
sesion               = ts_sesn,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
operacion            = ts_int_01,
ente                 = ts_int_02,
rol                  = ts_catalogo_02,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02
from  pf_tran_servicio
where ts_tipo_transaccion in (14109,14209,14309,14201)
go

print '-->Transaccion Servicio: ts_bloqueo_legal'
if exists (select 1 from sysobjects where name = 'ts_bloqueo_legal' and type = 'V')
   drop view ts_bloqueo_legal
go

create view ts_bloqueo_legal as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
operacion            = ts_int_01,
bl_secuencial        = ts_tinyint_01,
valor_juzgado        = ts_money_01,
valor_banco          = ts_money_02,
tipo                 = ts_catalogo_01,
fecha_oficio         = ts_datetime_01,
num_oficio           = ts_varchar30_01,
autoridad            = ts_varchar255_01,
bl_usuario           = ts_login_01,
fecha_crea           = ts_datetime_02,
fecha_mod            = ts_datetime_03,
observacion          = ts_descripcion_01,
motivo               = ts_catalogo_02,
valor_int_banco      = ts_money_03,
oficina              = ts_smallint_01,
ente                 = ts_int_02
from  pf_tran_servicio
where ts_tipo_transaccion in (14157,14539,14344)
go

print '-->Transaccion Servicio: ts_cancelacion'
if exists (select 1 from sysobjects where name = 'ts_cancelacion' and type = 'V')
   drop view ts_cancelacion
go

create view ts_cancelacion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
operacion            = ts_int_01,
funcionario          = ts_login_01,
oficina              = ts_smallint_01,
pen_monto            = ts_money_01,
valor                = ts_money_02,
pen_porce            = ts_float_01,
secuencia            = ts_int_02,
solicitante          = ts_int_03,
tipo                 = ts_char1_01,
estado               = ts_char1_02,
fpago                = ts_catalogo_01,
fecha_ven            = ts_datetime_01,
fecha_pg_int         = ts_datetime_02,
accion_sgte          = ts_catalogo_02,
estado_op            = ts_catalogo_03,
autorizado           = ts_login_02,
comentario           = ts_descripcion_01,
fecha_crea           = ts_datetime_03,
fecha_mod            = ts_datetime_04
from  pf_tran_servicio
where ts_tipo_transaccion in (14903,14913)
go

print '-->Transaccion Servicio: ts_cierre_modulo'
if exists (select 1 from sysobjects where name = 'ts_cierre_modulo' and type = 'V')
   drop view ts_cierre_modulo
go

CREATE VIEW ts_cierre_modulo as
select
secuencial           = ts_secuencial,
cod_alterno          = ts_alterno, 
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_varchar30_01,
hora                 = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal, 
oficina              = ts_smallint_02, 
lsrv                 = ts_lsrv, 
srv                  = ts_srv,
func_autoriza        = ts_smallint_01
from  cob_pfijo..pf_tran_servicio
where ts_tipo_transaccion in (14169, 14170, 14171)
go

print '-->Transaccion Servicio: ts_condicion'
if exists (select 1 from sysobjects where name = 'ts_condicion' and type = 'V')
   drop view ts_condicion
go

create view ts_condicion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
operacion            = ts_int_01,    
condicion            = ts_tinyint_01,
comentario           = ts_varchar255_01,    
fecha_crea           = ts_datetime_01,    
fecha_mod            = ts_datetime_02    
from  pf_tran_servicio
where ts_tipo_transaccion in (14116, 14216, 14316)
go

print '-->Transaccion Servicio: ts_cotizacion'
if exists (select 1 from sysobjects where name = 'ts_cotizacion' and type = 'V')
   drop view ts_cotizacion
go

create view ts_cotizacion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
ofi                  = ts_ofi, 
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
moneda               = ts_tinyint_01,
fecha_cotizacion     = ts_datetime_03,
compra               = ts_money_01,
venta                = ts_money_02,     
valor                = ts_money_03,     
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02
from  pf_tran_servicio
where ts_tipo_transaccion in (14142, 14236, 14340)
go

print '-->Transaccion Servicio: ts_cuotas'
if exists (select 1 from sysobjects where name = 'ts_cuotas' and type = 'V')
   drop view ts_cuotas
go

create view ts_cuotas as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
cliente              = ts_int_01,
operacion            = ts_int_02,
cuota                = ts_tinyint_01,   
fecha_pago           = ts_datetime_01,
valor_cuota          = ts_money_01,
retencion            = ts_money_02,
capital              = ts_money_03,
fecha_crea           = ts_datetime_02,
moneda               = ts_tinyint_02,
oficina              = ts_smallint_01 ,
fecha_caja           = ts_datetime_03, 
num_cupon            = ts_cuenta_01,
num_impre            = ts_tinyint_03,
estado               = ts_catalogo_01,
preimpreso           = ts_int_03, 
fecha_mod            = ts_datetime_04,
valor_neto           = ts_money_04,
retenido             = ts_char1_01,
forma_pago           = ts_catalogo_02,
custodia             = ts_char1_02        
from  pf_tran_servicio
where ts_tipo_transaccion in (14146, 14964)
go

print '-->Transaccion Servicio: ts_det_condicion'
if exists (select 1 from sysobjects where name = 'ts_det_condicion' and type = 'V')
   drop view ts_det_condicion
go

create view ts_det_condicion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
operacion            = ts_int_01,    
condicion            = ts_tinyint_01,    
ente                 = ts_int_02,    
fecha_crea           = ts_datetime_01,    
fecha_mod            = ts_datetime_02    
from  pf_tran_servicio
where ts_tipo_transaccion in (14117, 14217, 14317)
go

print '-->Transaccion Servicio: ts_det_pago'
if exists (select 1 from sysobjects where name = 'ts_det_pago' and type = 'V')
   drop view ts_det_pago
go

create view ts_det_pago as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
operacion            = ts_int_01,
ente                 = ts_int_02,
tipo                 = ts_catalogo_01,
forma_pago           = ts_catalogo_02,
cuenta               = ts_cuenta_01,
monto                = ts_money_01,
porcentaje           = ts_float_01,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
moneda_pago          = ts_smallint_01,
descripcion          = ts_descripcion_01,
oficina              = ts_int_03
from  pf_tran_servicio
where ts_tipo_transaccion in (14901,14903,14942,14167,14201)
go

print '-->Transaccion Servicio: ts_emision_cheque'
if exists (select 1 from sysobjects where name = 'ts_emision_cheque' and type = 'V')
   drop view ts_emision_cheque
go

create view ts_emision_cheque as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
fecha_mov            = ts_datetime_01,    
ec_secuencial        = ts_int_01,    
ec_tran              = ts_int_02,    
operacion            = ts_int_03,    
numero               = ts_int_04,    
moneda               = ts_tinyint_01,    
valor                = ts_money_01,    
descripcion          = ts_descripcion_01,    
fecha_emision        = ts_datetime_02,    
fecha_crea           = ts_datetime_03,
fecha_mod            = ts_datetime_04,
caja                 = ts_char1_01,
fecha_caja           = ts_datetime_05,
estado               = ts_char1_02,
fpago                = ts_catalogo_08
from  pf_tran_servicio
where ts_tipo_transaccion = 14231
go

print '-->Transaccion Servicio: ts_fpago'
if exists (select 1 from sysobjects where name = 'ts_fpago' and type = 'V')
   drop view ts_fpago
go

create view ts_fpago as 
select                                
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
tipo_fpago           = ts_int_04,
descripcion          = ts_varchar30_01,
mnemonico            = ts_varchar4_01,
ttransito            = ts_smallint_01,
automatico           = ts_char1_01,
estado               = ts_char1_02,
producto             = ts_tinyint_02,
fecha_crea           = ts_datetime_01,
fecha_modi           = ts_datetime_02,
compensa             = ts_char1_03,
area_contable        = ts_int_01,
exonera_gmf          = ts_char1_04 
from  pf_tran_servicio 
where ts_tipo_transaccion in (14132,14232,14330) 
go

print '-->Transaccion Servicio: ts_funcionario'
if exists (select 1 from sysobjects where name = 'ts_funcionario' and type = 'V')
   drop view ts_funcionario
go

create view ts_funcionario as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
funcionario          = ts_login_01,
func_relacionado     = ts_login_02,
tautorizacion        = ts_catalogo_01,
fecha_crea           = ts_datetime_01,
fecha_elim           = ts_datetime_02,
estado               = ts_char1_01,
seqnos               = ts_int_01
from pf_tran_servicio
where ts_tipo_transaccion in (14133, 14333)
go

print '-->Transaccion Servicio: ts_hist_tasa'
if exists (select 1 from sysobjects where name = 'ts_hist_tasa' and type = 'V')
   drop view ts_hist_tasa
go

create view ts_hist_tasa as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
secuencial_historico = ts_int_01,
tipo_deposito        = ts_catalogo_01,
moneda               = ts_tinyint_01,
tipo_monto           = ts_catalogo_02,
tipo_plazo           = ts_catalogo_03,
tasa_min             = ts_float_01,
tasa_max             = ts_float_02,           
vigente              = ts_float_03, 
tasa_min_ant         = ts_float_04,
tasa_max_ant         = ts_float_05,
tasa_vigente_ant     = ts_float_06,
estado               = ts_char1_01,
fecha_creacion       = ts_datetime_01,
usuario_ant          = ts_login_01
from  pf_tran_servicio
where ts_tipo_transaccion in (14160, 14242)
go

print '-->Transaccion Servicio: ts_hist_tasa_variable'
if exists (select 1 from sysobjects where name = 'ts_hist_tasa_variable' and type = 'V')
   drop view ts_hist_tasa_variable
go

create view ts_hist_tasa_variable as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
secuencial_historico = ts_int_01,
mnemonico_prod       = ts_catalogo_01,
moneda               = ts_tinyint_01,
tipo_monto           = ts_catalogo_02,
tipo_plazo           = ts_catalogo_03,
spread_min           = ts_float_01,
spread_max           = ts_float_02,
spread_vigente       = ts_float_03,
spread_min_ant       = ts_float_04,
spread_max_ant       = ts_float_05,
spread_vigente_ant   = ts_float_06,
estado               = ts_char1_01,
operador             = ts_char1_02,
mnemonico_tasa       = ts_catalogo_04,
fecha_creacion       = ts_datetime_01,
tasa_min             = ts_money_01,
tasa_max             = ts_money_02,
tasa_min_ant         = ts_money_03,
tasa_max_ant         = ts_money_04,
usuario_ant          = ts_login_01,
momento              = ts_catalogo_05,
prorroga             = ts_catalogo_06,
segmento             = ts_catalogo_07,
ivc                  = ts_catalogo_08
from  pf_tran_servicio
where ts_tipo_transaccion in (14161, 14243)
go

print '-->Transaccion Servicio: ts_historia'
if exists (select 1 from sysobjects where name = 'ts_historia' and type = 'V')
   drop view ts_historia
go

create view ts_historia as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
operacion            = ts_int_01,
secuencia2           = ts_smallint_01,
transaccion          = ts_int_02,
valor                = ts_money_01,
funcionario          = ts_login_01,
oficina              = ts_int_03,
fecha_crea           = ts_datetime_02,
fecha_mod            = ts_datetime_03
from  pf_tran_servicio
where ts_tipo_transaccion in (14901,14903,14908)
go

print '-->Transaccion Servicio: ts_instruccion'
if exists (select 1 from sysobjects where name = 'ts_instruccion' and type = 'V')
   drop view ts_instruccion
go

create view ts_instruccion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
operacion            = ts_int_02,
instruccion          = ts_varchar255_01
from  pf_tran_servicio
where ts_tipo_transaccion in (14151,14238)
go

print '-->Transaccion Servicio: ts_limite'
if exists (select 1 from sysobjects where name = 'ts_limite' and type = 'V')
   drop view ts_limite
go

create view ts_limite as      
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
tipo_deposito        = ts_int_04,
moneda               = ts_smallint_01,
limite               = ts_smallint_02,
tipo                 = ts_varchar3_01,    
valor                = ts_catalogo_01,
limite_max           = ts_smallint_03,
limite_min           = ts_smallint_04,
usa_limites          = ts_char1_01,        
fecha_crea           = ts_datetime_01,
fecha_elim           = ts_datetime_02
from  pf_tran_servicio
where ts_tipo_transaccion in (14135,14235,14335)
go

print '-->Transaccion Servicio: ts_monto'
if exists (select 1 from sysobjects where name = 'ts_monto' and type = 'V')
   drop view ts_monto
go

create view ts_monto as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
tipo_monto           = ts_int_01,
descripcion          = ts_varchar30_01,
mnemonico            = ts_catalogo_01, 
monto_min            = ts_money_01,
monto_max            = ts_money_02,     
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
ofi		             = ts_ofi
from  pf_tran_servicio
where ts_tipo_transaccion in (14112, 14212, 14312)
go

print '-->Transaccion Servicio: ts_mov_monet'
if exists (select 1 from sysobjects where name = 'ts_mov_monet' and type = 'V')
   drop view ts_mov_monet
go

create view ts_mov_monet as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
operacion            = ts_int_01,
transaccion          = ts_int_02,
secuencia            = ts_int_03,
sub_secuencia        = ts_tinyint_01,
producto             = ts_catalogo_01,
cuenta               = ts_cuenta_01,
valor                = ts_money_01,
tipo                 = ts_char1_01,
beneficiario         = ts_int_04,
impuesto             = ts_money_02,
secuencia2           = ts_int_05,
moneda               = ts_smallint_01,
valor_ext            = ts_money_03,
estado               = ts_char1_02,
fecha_aplicacion     = ts_datetime_01,
fecha_crea           = ts_datetime_02,
fecha_mod            = ts_datetime_03,
fecha_valor          = ts_datetime_04,
ica                  = ts_money_04
from  pf_tran_servicio
where ts_tipo_transaccion in (14901, 14903, 14908, 14986, 14987, 14155)
go

print '-->Transaccion Servicio: ts_mov_monet_prob'
if exists (select 1 from sysobjects where name = 'ts_mov_monet_prob' and type = 'V')
   drop view ts_mov_monet_prob
go

CREATE view ts_mov_monet_prob as 
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
operacion            = ts_int_04,
secuencia            = ts_int_01,
subsecuencia         = ts_int_02,
motivo               = ts_catalogo_01,
banco                = ts_catalogo_02,
cuenta               = ts_cuenta_01,
cheque               = ts_int_03,
valor                = ts_money_01,
estado               = ts_char1_02,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02 
from  pf_tran_servicio
where ts_tipo_transaccion in (14339,14139)
go

print '-->Transaccion Servicio: ts_operacion'
if exists (select 1 from sysobjects where name = 'ts_operacion' and type = 'V')
   drop view ts_operacion
go

create view ts_operacion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
num_banco            = ts_cuenta_01,
operacion            = ts_int_01,
ente                 = ts_int_02,
toperacion           = ts_catalogo_01,
categoria            = ts_catalogo_02,
producto             = ts_tinyint_01,
oficina              = ts_smallint_01,
moneda               = ts_tinyint_02,
num_dias             = ts_smallint_02,
monto                = ts_money_01,
monto_pg_int         = ts_money_02,
monto_pgdo           = ts_money_03,
monto_blq            = ts_money_04,
tasa                 = ts_float_01,
int_ganado           = ts_float_02,
int_estimado         = ts_money_05,
int_pagados          = ts_money_06,
int_provision        = ts_money_07,
total_int_ganados    = ts_money_08,
total_int_pagados    = ts_money_09,
total_int_estimado   = ts_money_10,
total_int_acumulado  = ts_money_12,
ppago                = ts_char3_01,
dia_pago             = ts_tinyint_03,
historia             = ts_smallint_03,
duplicados           = ts_tinyint_05,
renovaciones         = ts_smallint_04,
incremento           = ts_smallint_05,
estado               = ts_catalogo_03,
pignorado            = ts_char1_01,
oficial              = ts_login_01,
descripcion          = ts_varchar255_01,
fecha_valor          = ts_datetime_01,
fecha_ven            = ts_datetime_02,
fecha_pg_int         = ts_datetime_03,
fecha_ult_pg_int     = ts_datetime_04,
fecha_crea           = ts_datetime_05,
fecha_mod            = ts_datetime_06,
fecha_ingreso        = ts_datetime_07,
totalizado           = ts_char1_02,
fecha_total          = ts_datetime_08,
tipo_plazo           = ts_catalogo_04,
tipo_monto           = ts_catalogo_05,
causa_mod            = ts_catalogo_06,
retenido             = ts_char1_03,
total_retencion      = ts_money_11,
retienimp            = ts_char1_04,
tasa_efectiva        = ts_float_03,
accion_sgte          = ts_catalogo_07,
mon_sgte             = ts_smallint_06,
tcapitalizacion      = ts_char1_05,
fpago                = ts_catalogo_08,
base_calculo         = ts_smallint_07,
casilla              = ts_tinyint_06,
direccion            = ts_tinyint_07,
imprime              = ts_char1_06,
porc_comision        = ts_float_04,
comision             = ts_money_13,
cupon                = ts_char1_07,
categoria_cupon      = ts_catalogo_09,
custodia             = ts_char1_08,
nueva_tasa           = ts_float_05,
incremento_prorroga  = ts_float_06,
ced_ruc              = ts_numero,
aprobado             = ts_char1_09,
sucursal             = ts_smallint_08,
ica                  = ts_char1_10
from  pf_tran_servicio
where ts_tipo_transaccion in (14201, 14301, 14901, 14903, 14904, 14905, 14910, 14911, 14958, 14959, 14960, 14986, 14987, 14155, 14769)
go

print '-->Transaccion Servicio: ts_pignoracion'
if exists (select 1 from sysobjects where name = 'ts_pignoracion' and type = 'V')
   drop view ts_pignoracion
go

create view ts_pignoracion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
operacion            = ts_int_01,
producto             = ts_catalogo_01,
cuenta               = ts_cuenta_01,
valor                = ts_money_01,
tasa                 = ts_float_01,
funcionario          = ts_login_01,
oficina              = ts_smallint_01,
spread               = ts_float_02,
fecha_crea           = ts_datetime_01,     
fecha_mod            = ts_datetime_02,
observacion          = ts_descripcion_01,
ofi                  = ts_ofi
from  pf_tran_servicio
where ts_tipo_transaccion in (14107,14207,14307)
go

print '-->Transaccion Servicio: ts_plazo'
if exists (select 1 from sysobjects where name = 'ts_plazo' and type = 'V')
   drop view ts_plazo
go

create view ts_plazo as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
tipo_plazo           = ts_int_01,
mnemonico            = ts_catalogo_01,
plazo_contable       = ts_catalogo_02,
descripcion          = ts_varchar30_01,
plazo_min            = ts_smallint_01,
plazo_max            = ts_smallint_02,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
ofi		             = ts_ofi
from  pf_tran_servicio
where ts_tipo_transaccion in (14114,14214,14314)
go

print '-->Transaccion Servicio: ts_ppago'
if exists (select 1 from sysobjects where name = 'ts_ppago' and type = 'V')
   drop view ts_ppago
go

create view ts_ppago as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
codigo               = ts_char3_01, 
descripcion          = ts_descripcion_01, 
factor_en_meses      = ts_tinyint_01, 
estado               = ts_char1_01,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02
from pf_tran_servicio where ts_tipo_transaccion in (14121,14221,14321)
go

print '-->Transaccion Servicio: ts_renovacion'
if exists (select 1 from sysobjects where name = 'ts_renovacion' and type = 'V')
   drop view ts_renovacion
go

create view ts_renovacion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
operacion            = ts_int_01,
renovacion           = ts_tinyint_01,
incremento           = ts_money_01,
tasa                 = ts_float_01,
num_dias             = ts_smallint_01,
paga_beneficiarios   = ts_char1_01,
tcapitalizacion      = ts_char1_02,
fpago                = ts_char1_03,
ppago                = ts_char3_01,
dia_pago             = ts_tinyint_02,
cuenta_int           = ts_cuenta_01,
producto_int         = ts_catalogo_01,
oficial              = ts_login_01,
estado               = ts_char1_04,
descripcion          = ts_descripcion_01,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02
from  pf_tran_servicio
where ts_tipo_transaccion in (14104, 14204, 14304)
go

print '-->Transaccion Servicio: ts_retencion'
if exists (select 1 from sysobjects where name = 'ts_retencion' and type = 'V')
   drop view ts_retencion
go

create view ts_retencion as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
operacion            = ts_int_01,
rt_secuencial        = ts_tinyint_01,
valor                = ts_money_01,
int_retencion        = ts_float_01,
suspendida           = ts_char1_01,
motivo               = ts_catalogo_01,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
cupon                = ts_tinyint_02,
cuenta               = ts_cuenta_01,
producto             = ts_catalogo_02,
observacion          = ts_descripcion_01,
funcionario          = ts_login_01
from  pf_tran_servicio
where ts_tipo_transaccion in (14108,14208,14308)
go

print '-->Transaccion Servicio: ts_tasa'
if exists (select 1 from sysobjects where name = 'ts_tasa' and type = 'V')
   drop view ts_tasa
go

create view ts_tasa as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
tipo_deposito        = ts_catalogo_01,
moneda               = ts_tinyint_01,
tipo_monto           = ts_catalogo_02,
tipo_plazo           = ts_catalogo_03,
tasa_min             = ts_float_01,
tasa_max             = ts_float_02,           
vigente              = ts_float_03,           
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
tipo		         = ts_char1_01,
tipo_pago	         = ts_catalogo_04,
momento              = ts_catalogo_05,
prorroga             = ts_catalogo_06,
segmento             = ts_catalogo_07,
ivc                  = ts_catalogo_08
from  pf_tran_servicio
where ts_tipo_transaccion in (14110, 14210, 14310, 14240)
go


print '-->Transaccion Servicio: ts_tipo_deposito'
if exists (select 1 from sysobjects where name = 'ts_tipo_deposito' and type = 'V')
   drop view ts_tipo_deposito
go

create view ts_tipo_deposito as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv,
tipo_deposito        = ts_int_04,
mnemonico            = ts_varchar5_01,
descripcion          = ts_varchar30_01,
forma_pago           = ts_catalogo_01,
capitalizacion       = ts_char1_01,
dias_reverso         = ts_tinyint_02,
base_calculo         = ts_catalogo_02,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
estado               = ts_char1_02,
mantiene_stock       = ts_char1_03,
stock                = ts_int_01,
emision_inicial      = ts_int_02,
anio_comercial       = ts_char1_04,
tasa_variable        = ts_char1_05,
tasa_efectiva        = ts_char1_06,
retiene_impto        = ts_char3_01,
tran_sabado          = ts_char1_07,
paga_comision        = ts_char1_08,
cupon                = ts_char1_09,
cambio_tasa          = ts_char1_10,
incr_decr            = ts_char1_11,
area_contable        = ts_int_03,
tipo_persona         = ts_catalogo_03,
dias_reales          = ts_correccion,
tipo_tasa_var        = ts_varchar3_01,
desmaterializa       = ts_char1_12,
ofi		             = ts_smallint_03,
periodo_tasa	     = ts_smallint_01,
num_serie            = ts_cuenta_01
from  pf_tran_servicio
where ts_tipo_transaccion in (14134, 14234, 14334)
go

print '-->Transaccion Servicio: ts_rango_prorroga'
if exists (select 1 from sysobjects where name = 'ts_rango_prorroga' and type = 'V')
   drop view ts_rango_prorroga
go

create view ts_rango_prorroga as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
rango_prorroga       = ts_int_01,
mnemonico            = ts_catalogo_01,
descripcion          = ts_varchar30_01,
prorroga_min         = ts_smallint_01,
prorroga_max         = ts_smallint_02,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
ofi		             = ts_smallint_03
from  pf_tran_servicio
where ts_tipo_transaccion in (14172, 14272, 14372)
go

print '-->Transaccion Servicio: ts_archivo_carga_tasas'
if exists (select 1 from sysobjects where name = 'ts_archivo_carga_tasas' and type = 'V')
   drop view ts_archivo_carga_tasas
go

create view ts_archivo_carga_tasas as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
clase                = ts_clase,
fecha                = ts_fecha,
usuario              = ts_usuario,
terminal             = ts_terminal,
srv                  = ts_srv,
lsrv                 = ts_lsrv, 
secuencial_archivo   = ts_int_01,
nombre_archivo       = ts_descripcion_01,
estado               = ts_char1_01,
fecha_vigencia       = ts_datetime_03,
numero_registros     = ts_int_02,
observacion          = ts_varchar255_01,
fecha_crea           = ts_datetime_01,
fecha_mod            = ts_datetime_02,
ofi		             = ts_smallint_03
from  pf_tran_servicio
where ts_tipo_transaccion in (14173, 14273, 14373, 14473, 14573, 14673, 14873)
go

print ''
print 'Fin Ejecucion Creacion de Transacciones de Servicio Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''