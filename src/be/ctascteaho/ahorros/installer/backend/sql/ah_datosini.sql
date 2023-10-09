/************************************************************************/
/*      Archivo:            ah_batch.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Walther Toledo                              */
/*      Fecha de escritura: 12/Julio/2016                               */
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
/*      Este programa realiza la creacion de datos iniciales para la    */
/*      correcta funcionalidad del modulo.                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*     FECHA         AUTOR                RAZON                         */
/* 12/Julio/2016     Walther Toledo       Migracion a CEN               */
/* 22/Julio/2016     Eduardo Williams     Tabla ah_trn_deposito_inicial */
/************************************************************************/

use cob_ahorros
go

delete from cp_campoah where cc_transaccion in (
201,202,203,204,205,206,211,212,213,217,218,220,230,232,234,236,258,259,271,
295,296,327,328,332,367,374,375,376,4106,4131,4132,4135,4145,4146,4148,200)

INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (201, ' ''No. DE CTA'' = ts_cta_banco,''No ID'' = ts_ced_ruc,''NOMBRE DE CLIENTE'' = (select en_nomlar from cobis..cl_ente where en_ente = ts_cliente),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (201, ' ''ESTADO CTA'' = (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_estado_cta''  and convert(varchar(10), ts_estado )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (201, ' ''FECHA Y HORA ACT'' = ts_fecha_ven,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (201, ' ''ORIGEN. CTA''= (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_tipocta ''and d. ts_causa = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (202, '''No. DE CUENTA'' = ts_cta_banco,''CLIENTE''= ts_cliente,''IDENTIFICACION'' = ts_ced_ruc, ''DIRECCION ESTADO CTA''= ts_descripcion_ec,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (202, '''TITULARIDAD''= (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.codigo = b.tabla and  a.tabla = ''re_titularidad'' and d. ts_tipo = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (202, '''CICLO''= (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.codigo = b.tabla and  a.tabla = ''ah_ciclo'' and d. ts_ciclo = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (202, '''OFICIAL''= (select fu_nombre  from cobis..cl_funcionario, cobis..cc_oficial where  oc_funcionario = fu_funcionario and oc_oficial = ts_oficial),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (205, ' ''No. DE CUENTA'' = ts_cta_banco,''TIPO. CTA''=(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''bv_tipo_cliente'' and d. ts_tipocta = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (205, ' ''CLIENTE''= ts_cliente,''IDENTIFICACION'' = ts_ced_ruc,''DIRECCION'' = ts_direccion_ec,''ESTADO''= (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.codigo = b.tabla and  a.tabla = ''ah_estado_cta'' and d. ts_estado = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (205, ' ''DESCRIPCION''= ts_descripcion_ec,''NUMERO DE LIBRETA'' = ts_numlib,''VALOR''= ts_valor, ''ORIGEN CTA''= ts_causa,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (203, ' ''No. DE CUENTA'' = ts_cta_banco,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (203, ' ''ESTADO'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_estado_cta'' and d. ts_estado = b.codigo),''USUARIO''= ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (204, ' ''No. DE CUENTA'' = ts_cta_banco,''USUARIO''= ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (204, ' ''ESTADO'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_estado_cta'' and d. ts_estado = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (206, ' ''No. DE CUENTA'' = ts_cta_banco,''CLIENTE''= ts_cliente,''TIPO''= ts_tipo,''IDENTIFICACION'' = ts_ced_ruc,''USUARIO''= ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (211, ' ''No. DE CUENTA'' = ts_cta_banco,''AUTORIZANTE''= ts_autorizante,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (211, ' ''TIPO'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_tbloqueo'' and d. ts_tipo = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (211, ' ''CAUSA'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_causa_bloqueo_mov'' and d. ts_causa = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (211, '''SOLICITANTE''= ts_autoriz_aut,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (212, ' ''No. DE CUENTA'' = ts_cta_banco,''AUTORIZANTE''= ts_autorizante,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (212, ' ''CAUSA'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_motivo_levbloq_mov'' and d. ts_causa = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (212, ' ''TIPO'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_tbloqueo'' and d. ts_tipo = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (212, '''SOLICITANTE''= ts_autoriz_aut,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (217, ' ''No. DE CUENTA'' = ts_cta_banco,''VALOR''= ts_valor,''AUTORIZANTE''= ts_autorizante,''ACCION''= ts_accion,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (217, '''SOLICITANTE''= ts_autoriz_aut,''FECHA. VENC'' = ts_fecha_ven, ''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (218, ' ''No. DE CUENTA'' = ts_cta_banco,''VALOR''= ts_valor,''AUTORIZANTE''= ts_autorizante,''ACCION''= ts_accion,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (218, ' ''CAUSA'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_caulev_blqva'' and d. ts_causa = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (218, '''SOLICITANTE''= ts_autoriz_aut,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (327, ' ''No. DE CUENTA'' = ts_cta_banco,''VALOR''= ts_valor,''AUTORIZANTE''= ts_autorizante,''ACCION''= ts_accion,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (328, ' ''No. DE CUENTA'' = ts_cta_banco,''VALOR''= ts_valor, ''AUTORIZANTE''= ts_autorizante,''ACCION''= ts_accion,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (213, ' ''No. DE CUENTA'' = ts_cta_banco,''SALDO''= ts_saldo,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (213, ' ''CAUSA'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_causa_cierre'' and d. ts_causa = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (213, '''AUTORIZANTE''= ts_autorizante,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (213, '''P. BANCARIO'' = (select pb_descripcion from cob_remesas..pe_pro_bancario a where a.pb_pro_bancario = d. ts_prod_banc),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (234, ' ''No. DE CUENTA'' = ts_cta_banco,''ORIGEN''= ts_origen,''USUARIO''= ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (258, '''OFICINA CTA''= (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''cl_oficina''  and convert(varchar(10), d. ts_oficina_cta )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (259, '''No. DE CUENTA'' = ts_cta_banco, ''SALDO'' = ts_saldo,''CHEQUE DESDE'' = ts_cheque_desde,''DPTO.'' = ts_departamento,''USUARIO''= ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (271, '''No. DE CUENTA'' = ts_cta_banco, ''VALOR''= ts_valor,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (295, '''No. DE CUENTA'' = ts_cta_banco,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (295, '''CLIENTE''= (select en_nomlar from cobis..cl_ente where  en_ente = d. ts_cliente),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (295, '''USUARIO''= ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (296, '''No. DE CUENTA'' = ts_cta_banco,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (296, '''CLIENTE''= (select en_nomlar from cobis..cl_ente where  en_ente = d. ts_cliente),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (296, '''USUARIO''= ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (220, '''No. DE CUENTA'' = ts_cta_banco,''ORIGEN''= ts_origen,''DISPONIBLE''= ts_saldo,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (220, ' ''OFICINA. CTA''= (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''cl_oficina''  and convert(varchar(10), d. ts_oficina_cta )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (220, '''PROM. DISP''= ts_monto,''SALDO CONTABLE''= ts_interes,''DISP. A GIRAR''= ts_valor,''TRN CLIENTE'' = ts_rol_ente,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (230, '''No. DE CUENTA'' = ts_cta_banco,''FECHA''= convert(varchar(10), ts_tsfecha,103),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (230, ' ''OFICINA CTA''= (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''cl_oficina''  and convert(varchar(10), d. ts_oficina_cta )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (230, '''DISPONIBLE'' = ts_saldo,''PROM. DISP'' = ts_monto,''SALDO CONTABLE''= ts_interes,''DISP. A GIRAR'' = ts_valor,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (230, '''TRN CLIENTE'' = ts_rol_ente,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (232, '''No. DE CUENTA'' = ts_cta_banco, ''TRN CLIENTE'' = ts_rol_ente, ''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (236, '''No. DE CUENTA'' = ts_cta_banco, ''TRN CLIENTE'' = ts_rol_ente, ''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (332, ' ''No. DE CUENTA''= ts_cta_banco,''MONTO LIBERADO''= ts_valor,''LIBERADO POR'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (367, ' ''No. DE CUENTA'' = ts_cta_banco, ''SALDO'' = ts_valor, ''INTERES'' = ts_interes,''ESTADO'' = ts_causa,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (375, ' ''No. DE CUENTA'' = ts_cta_banco, ''SALDO'' = ts_valor, ''INTERES'' = ts_interes,''ESTADO'' = ts_causa,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (376, ' ''No. DE CUENTA'' = ts_cta_banco, ''SALDO'' = ts_valor, ''INTERES'' = ts_interes,''ESTADO'' = ts_causa,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4106, ' ''No. DE CUENTA'' = ts_cta_banco, ''EXONERA'' = ts_marca_gmf, ''CONCEPTO'' = substring( ts_descripcion_ec ,1,45), ''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4106, '''OFICINA CTA''= (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''cl_oficina''  and convert(varchar(10), d. ts_oficina_cta )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4145, ' ''No. DE CUENTA'' = ts_cta_banco, ''CLIENTE'' = ts_cliente,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4145, ' ''DESCRIPCION'' = ts_descripcion_ec, ''FECHA APERTURA'' = (select convert(varchar(11),ah_fecha_aper,109) from cob_ahorros..ah_cuenta where ah_cta_banco = ts_cta_banco),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4135, ' ''No. DE CUENTA'' = ts_cta_banco, ''CLIENTE'' = ts_cliente,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4135, ' ''DESCRIPCION'' = ts_observacion, ''VALOR ACTUAL'' = ts_saldo, ''VALOR PACTADO'' = ts_monto,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4135, ' ''FECHA APERTURA'' = (select ah_fecha_aper from cob_ahorros..ah_cuenta where ah_cta_banco = ts_cta_banco),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4135, ' ''PERIODOS INCUMPLIDOS'' = (select cc_periodos_incump from cob_remesas..re_cuenta_contractual where cc_cta_banco = ts_cta_banco),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4131, ' ''DESC. OPERACION'' = ts_descripcion_ec, ''No. DE CUENTA'' = ts_cta_banco, ''NOMBRE'' = ts_observacion,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4131, ' ''FORMA AUTORIZACION'' = ts_tipo, ''MONTO AUTORIZADO'' = ts_valor, ''USUARIO AUTORIZA'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4132, ' ''DESC. OPERACION'' = ts_descripcion_ec, ''No. DE CUENTA'' = ts_cta_banco, ''NOMBRE'' = ts_observacion,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4132, ' ''FORMA AUTORIZACION'' = ts_tipo, ''MONTO AUTORIZADO'' = ts_valor, ''USUARIO AUTORIZA'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4145, ' ''ESTADO CTA'' = (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_estado_cta''  and convert(varchar(10), ts_estado )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4145, ' ''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4146, ' ''No. DE CUENTA'' = ts_cta_banco, ''CLIENTE'' = ts_cliente,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4146, ' ''DESCRIPCION'' = ts_descripcion_ec, ''FECHA APERTURA'' = (select convert(varchar(11),ah_fecha_aper,109) from cob_ahorros..ah_cuenta where ah_cta_banco = ts_cta_banco),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4146, ' ''ESTADO CTA'' = (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_estado_cta''  and convert(varchar(10), ts_estado )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4146, ' ''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4148, '''No. DE CUENTA'' = ts_cta_banco, ''CONCEPTO'' = substring( ts_descripcion_ec ,1,30), ''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (4148, '''OFICINA CTA''= (select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''cl_oficina''  and convert(varchar(10), d. ts_oficina_cta )=  b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (374, '''No. DE CUENTA'' = ts_cta_banco, ''SALDO'' = ts_valor, ''INTERES'' = ts_interes,''ESTADO'' = ts_causa,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (200, ' ''No. DE CUENTA'' = ts_cta_banco,''SALDO''= ts_saldo,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (200, ' ''CAUSA'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_causa_cierre'' and d. ts_causa = b.codigo),')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (200, '''AUTORIZANTE''= ts_autorizante,''USUARIO'' = ts_usuario,')


INSERT INTO cp_campoah (cc_transaccion, cc_campo)
VALUES (200, '''P. BANCARIO'' = (select pb_descripcion from cob_remesas..pe_pro_bancario a where a.pb_pro_bancario = d. ts_prod_banc),')

-----------cp_campoah_monetario


delete from cp_campoah_monetario where ah_transaccion_m in (
213,221,224,227,224,237,240,252,253,263,264,300,304,308,
309,315,316,334,371,392,258,380)

  
INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (213, ' ''No. DE CUENTA''= tm_cta_banco,''VALOR''= tm_valor,''SALDO LIB.''= tm_saldo_lib,''SALDO INT.''= tm_saldo_interes,''SALDO DISPONIBLE''= tm_saldo_disponible,''INTERESES''= tm_interes,''MULTA''= tm_chq_ot_plazas,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (213, ' ''TITULAR''= (select ah_nombre from cob_ahorros..ah_cuenta where ah_cta_banco = v. tm_cta_banco),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (213, ' ''P. BANCARIO''= (select pb_descripcion from cob_remesas..pe_pro_bancario where pb_pro_bancario = v. tm_prod_banc),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (221, ' ''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor,  ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (221, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''ah_causa_nc'' and a.codigo = b.tabla and v. tm_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (224, '''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor, ''CORRESPONSAL'' = tm_ctadestino,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (224, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''cc_causa_dev'' and a.codigo = b.tabla and v. tm_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (237, '''CUENTA DEBITO''= tm_cta_banco,''CUENTA CREDITO''= tm_ctadestino,''VALOR''= tm_valor,''TIP.TRNF''= tm_tipo_xfer,''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (240, '''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (240, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''cc_causa_dev'' and a.codigo = b.tabla and v. tm_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (252, ' ''No. DE CUENTA'' = tm_cta_banco,''EFECTIVO''= tm_valor,''CHEQUES PROPIOS''= tm_chq_propios,''CHEQUE LOCALES''= tm_chq_locales,''CHEQUES REMESAS''= tm_chq_ot_plazas,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (253, ' ''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (253, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''ah_causa_nc'' and a.codigo = b.tabla and v. tm_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (263, ' ''No. DE CUENTA'' = tm_cta_banco,  ''VALOR''= tm_valor, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (264, ' ''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor,''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (264, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''ah_causa_nd'' and a.codigo = b.tabla and v. tm_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (300, '''CUENTA CREDITO''= tm_cta_banco,''CUENTA DEBITO''= tm_ctadestino,''VALOR''= tm_valor,''TIP.TRNF''= tm_tipo_xfer,''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (304, '''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor,''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (308, '''No. DE CUENTA'' = tm_cta_banco, ''BASE INTERES''= tm_interes, ''TASA''= tm_efectivo, ''VALOR''= tm_valor,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (308, '''GMF'' = tm_monto_imp, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (309, '''No. DE CUENTA'' = tm_cta_banco, ''BASE INTERES''= tm_interes, ''TASA''= tm_efectivo, ''VALOR''= tm_valor,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (309, '''GMF'' = tm_monto_imp, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (315, ' ''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor, ''SALDO DISPONIBLE''= tm_saldo_disponible, ''FECHA EFEC'' = tm_fecha_efec,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (315, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''ah_causa_nc'' and a.codigo = b.tabla and v. tm_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (316, ' ''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor,''SALDO DISPONIBLE''= tm_saldo_disponible,''FECHA EFEC'' = tm_fecha_efec,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (316, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''ah_causa_nd'' and a.codigo = b.tabla and v. tm_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (334, '''No. DE CUENTA'' = tm_cta_banco, ''BASE INTERES''= tm_interes, ''VALOR''= tm_valor,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (334, '''GMF'' = tm_monto_imp, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (371, ' ''No. DE CUENTA'' = tm_cta_banco,  ''VALOR''= tm_valor, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (392, ' ''No. DE CUENTA'' = tm_cta_banco,  ''VALOR''= tm_valor, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (258, ' ''No. DE CUENTA'' = ts_cta_banco, ''VALOR''= ts_valor,')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (258, '''CAUSA'' = (select valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = ''ah_causa_nd'' and a.codigo = b.tabla and d.ts_causa = b.codigo),')
GO

INSERT INTO cp_campoah_monetario (ah_transaccion_m, ah_campo_m)
VALUES (380, ' ''No. DE CUENTA'' = tm_cta_banco, ''VALOR''= tm_valor, ''SALDO DISPONIBLE''= tm_saldo_disponible,')
GO

/**************************************************/
/*      Parametros para deposito inicial          */
/**************************************************/
delete from cob_ahorros..ah_trn_deposito_inicial
go
insert into cob_ahorros..ah_trn_deposito_inicial (di_tran, di_causal, di_descripcion, di_estado)
values (300, '0',   'TRANSFERENCIA ENTRE CUENTAS CREDITO',                             'V'),
       (251, '0',   'DEPOSITO DE AHORROS CON LIBRETA',                                 'V'),
       (252, '0',   'DEPOSITO DE AHORROS',                                             'V'),
       (253, '0',   'NOTA CREDITO - SIN CAUSAL',                                       'V'),
       (253, '107', 'NOTA CREDITO - DEVOLUCION GMF',                                   'V'),
       (253, '108', 'NOTA CREDITO - DEVOLUCION RETENCION EN LA FUENTE',                'V'),
       (253, '109', 'NOTA CREDITO - CAMPAÐA AHORROS EMPLEADOS',                        'V'),
       (253, '110', 'NOTA CREDITO - TRANSFERENCIA DE CUENTAS OTROS BANCOS',            'V'),
       (253, '12',  'NOTA CREDITO - CANCELACION  DEPOSITOS PLAZO FIJO',                'V'),
       (253, '17',  'NOTA CREDITO - TRANSFERENCIA DE SALDOS',                          'V'),
       (253, '200', 'NOTA CREDITO - CORRECCION DE DEPOSITOS',                          'V'),
       (253, '205', 'NOTA CREDITO - PAGO A PROVEEDORES',                               'V'),
       (253, '21',  'NOTA CREDITO - DESEMBOLSO DE CREDITO',                            'V'),
       (253, '218', 'NOTA CREDITO - ABONO MANUAL DE INTERESES',                        'V'),
       (253, '229', 'NOTA CREDITO - AJUSTE POR ERROR EN NUMERO DE CUENTA',             'V'),
       (253, '237', 'NOTA CREDITO - CAMARA Y REMESAS',                                 'V'),
       (253, '242', 'NOTA CREDITO - POR GIRO WESTERN UNION',                           'V'),
       (253, '30',  'NOTA CREDITO - REVERSO DE APERTURA DEPOSITOS PLAZO FIJO',         'V'),
       (253, '4',   'NOTA CREDITO - DEVOLUCION COMISION REMESAS',                      'V'),
       (253, '43',  'NOTA CREDITO - REVERSA COMISION VENTA CHQ GERENCIA',              'V'),
       (253, '47',  'NOTA CREDITO - ABONO INTERESES RECALCULADOS',                     'V'),
       (253, '48',  'NOTA CREDITO - REINTEGRO PAGO DE CARTERA',                        'V'),
       (253, '49',  'NOTA CREDITO - ** POR DEFINIR ENTREGA MONTO MIN INEMBARGABLE **', 'V'),
       (253, '6',   'NOTA CREDITO - CONFIRMACION CH REMESAS COB',                      'V'),
       (253, '39',  'DEPOSITO A CUENTA POR CB',                                        'V')
go

-----------------------------------------------------------------------------------------------
--Obtener el codigo del pais - 
use cobis
go
declare @w_pais smallint,
        @w_id_moneda int,
        @w_descripcion varchar(100)
SELECT @w_pais = pa_smallint 
  FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CP' 
   AND pa_producto = 'ADM'
------ Moneda UDI
select @w_descripcion = 'UNIDADES DE INVERSION'

delete from cl_moneda
 where mo_nemonico = 'UDI'
   and mo_pais=@w_pais

SELECT @w_id_moneda = max(mo_moneda) + 1
  FROM cobis..cl_moneda
INSERT INTO cl_moneda (mo_moneda, mo_descripcion, mo_pais, mo_estado, mo_decimales, mo_simbolo, mo_nemonico, mo_cod_ctaunico)
VALUES (@w_id_moneda, @w_descripcion , @w_pais, 'V', 'S', 'UDI', 'UDI', NULL)

------ Moneda MEXICO
select @w_descripcion = 'PESOS MEXICANOS'

delete from cl_moneda
 where mo_nemonico = 'MXN'
   and mo_pais=@w_pais
SELECT @w_id_moneda = 0

DELETE FROM cl_moneda WHERE mo_moneda = @w_id_moneda
INSERT INTO cl_moneda (mo_moneda, mo_descripcion, mo_pais, mo_estado, mo_decimales, mo_simbolo, mo_nemonico)
VALUES (@w_id_moneda, @w_descripcion, @w_pais, 'V', 'S', 'MX', 'MXN')

go
-----------------------------------------------------------------------------------------------

use cob_remesas
go
delete from cob_remesas..re_equivalencias where eq_tabla  ='ROLDEUDOR' and eq_val_cfijo in ('C','T','F','U')

insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','C','C','CODEUDOR')
insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','T','T','TITULAR DE LA CUENTA a DEPOSITO')
insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','F','F','FIRMA AUTORIZADA')
insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','U','U','TUTOR')


delete from cob_remesas..re_equivalencias where eq_tabla  ='CATPRODUC' and eq_descripcion ='ORDINARIO'

insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
select 4,36,'CATPRODUC',pb_pro_bancario,'ORD','ORDINARIO' from cob_remesas..pe_pro_bancario 

go
-----------------------------------------------------------------------------------------------

use cob_remesas
go

delete from cob_remesas..re_accion_nd where an_producto = 4

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '10', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '11', 'E', 'S', NULL, 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '139', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '14', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '140', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '141', 'E', 'N', NULL, 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '143', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '152', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '156', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '157', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '158', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '159', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '160', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '161', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '162', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '164', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '165', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '166', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '167', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '168', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '182', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '183', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '184', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '185', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '205', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '213', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '233', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '234', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '236', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '237', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '238', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '24', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '248', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '26', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '260', 'V', 'N', 'S', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '261', 'E', 'N', 'S', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '27', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '28', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '30', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '31', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '32', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '33', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '34', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '35', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '36', 'V', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '37', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '38', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '39', 'V', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '4', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '40', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '41', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '44', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '46', 'V', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '50', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '57', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '58', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '75', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '84', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '85', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '86', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '87', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '88', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '9', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '91', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '92', 'V', 'S', 'N', 'N', 'N')

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '93', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cob_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '7', 'V', 'S', NULL, 'S', 'S')

go

-----------------------------------------------------------------------------------------------
--Parametrizar codigo del cliente BANCO COBIS 
DELETE FROM cobis..cl_parametro WHERE pa_nemonico = 'ENCO' AND pa_producto = 'CLI'

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ENTE BANCO COBIS', 'ENCO', 'I', NULL, NULL, NULL, @w_ente, NULL, NULL, NULL, 'CLI')

-----------------------------------------------------------------------------------------------
use cobis
go
delete from cobis..cl_cliente 
 where cl_det_producto in 
	   (select dp_det_producto from cl_det_producto where dp_producto=4) 

delete from cobis..cl_det_producto 
 where dp_producto=4

-----------------------------------------------------------------------------------------------

USE cob_remesas
go

DELETE  FROM cob_remesas..re_contrato_producto

SELECT * FROM cob_remesas..re_contrato_producto
DECLARE  @w_cp_prod_banc INT

IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PAHCT')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PAHCT'
  
      
INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'AHPROP.RPT', 'CONTRATO AHORROS CONTRACTUAL PERSONA', 'SI')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'AHPROJ.RPT', 'CONTRATO AHORROS CONTRACTUAL JURIDICO', 'NO')


END

IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCANOR')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCANOR'
  
  
INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CONAHO.RPT', 'CONTRATO AHORROS PERSONA', 'SI')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'CONAHJ.RPT', 'CONTRATO AHORROS JURIDICO', 'NO')



END



IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCAME')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCAME'
  
  

INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CONAHO.RPT', 'CONTRATO AHORROS PERSONA', 'SI')


END




IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCAASO')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCAASO'
  
  

INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'CERASJ.RPT', 'CERTIFICADO APORTACION JURIDICO', 'NO')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CERASA.RPT', 'CERTIFICADO APORTACION PERSONA', 'SI')


END



IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCAASA')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCAASA'
  

INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'CERASJ.RPT', 'CERTIFICADO APORTACION JURIDICO', 'NO')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CERASA.RPT', 'CERTIFICADO APORTACION PERSONA', 'SI')


END

go