/* ************************************************************************* */
--                    No Bug: 77232
--            Título del Bug: Bug 77232:MAN - Históricas de Servicios / FUN
--                     Fecha: 12/Julio/2016
--  Descripción del Problema: No existe catálogo del campo Tipo Transaccion.
--Descripción de la Solución: Se inserta los datos en la tabla CP_CAMPOAH
--                     Autor: Walther Toledo Q.
/* ************************************************************************* */


use cob_ahorros
go


delete from cp_campoah where cc_transaccion in (
201,202,203,204,205,206,211,212,213,217,218,220,230,232,234,236,258,259,271,
295,296,327,328,332,367,374,375,376,4106,4131,4132,4135,4145,4146,4148
)

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
