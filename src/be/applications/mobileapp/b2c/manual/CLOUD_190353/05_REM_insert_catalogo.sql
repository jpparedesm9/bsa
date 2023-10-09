
use cob_bvirtual
go

truncate table bv_trans_api_detalles

INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('GENIP', 'GENERACION DE NIP', 'orchestation/onboarding', 'POST');

INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('AUTSE', 'AUTORIZACION DE SEGURO', '/customer/saveLifeInsurance', 'POST');

INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('SOLCO', 'AUTORIZACION DE CONTRATO ', '/capture/fingerprint', 'POST');

INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('AUTBU', 'AUTORIZACION DE BURO DE CREDITO', '/customer/evaluation', 'POST');
go
