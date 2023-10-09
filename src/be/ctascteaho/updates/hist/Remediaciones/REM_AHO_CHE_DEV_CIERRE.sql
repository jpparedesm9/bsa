use cobis
go

delete from cobis..cl_ttransaccion where tn_trn_code = 200
go

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (200, 'CIERRE DE CUENTA AHORRO SOCIAL', 'CCAS', 'CIERRE DE CUENTA AHORRO SOCIAL')
go

delete from cobis..ad_pro_transaccion where pt_transaccion = 200
go

declare @w_moneda tinyint

select @w_moneda = pa_tinyint
	from cobis..cl_parametro
	where pa_nemonico = 'CMNAC'
	and pa_producto = 'ADM'

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', @w_moneda, 200, 'V', getdate(), 233, NULL)
go

use cob_ahorros
go

delete from cob_ahorros..cp_campoah where cc_transaccion in (200)

INSERT INTO cob_ahorros..cp_campoah (cc_transaccion, cc_campo)
VALUES (200, ' ''No. DE CUENTA'' = ts_cta_banco,''SALDO''= ts_saldo,')

INSERT INTO cob_ahorros..cp_campoah (cc_transaccion, cc_campo)
VALUES (200, ' ''CAUSA'' =(select valor from cobis..cl_tabla a , cobis..cl_catalogo b where  a.codigo = b.tabla and  a.tabla = ''ah_causa_cierre'' and d. ts_causa = b.codigo),')

INSERT INTO cob_ahorros..cp_campoah (cc_transaccion, cc_campo)
VALUES (200, '''AUTORIZANTE''= ts_autorizante,''USUARIO'' = ts_usuario,')

INSERT INTO cob_ahorros..cp_campoah (cc_transaccion, cc_campo)
VALUES (200, '''P. BANCARIO'' = (select pb_descripcion from cob_remesas..pe_pro_bancario a where a.pb_pro_bancario = d. ts_prod_banc),')

go
