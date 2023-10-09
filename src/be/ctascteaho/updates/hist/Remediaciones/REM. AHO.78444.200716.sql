
/*************************************************/
-- Fecha Creación del Script:  20/07/2016
-- Historial  Dependencias:
-- KME    20/07/2016   Se añade data inicial
-- /*************************************************/ 
use cob_ahorros
go

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
