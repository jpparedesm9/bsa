
-- \bsa\src\be\applications\mobileapp\b2c\installer\sql\b2c_param.sql
use cobis
go
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('IDCHAN','IDORIG','IDCOUN','URLPRO','URLDOM','URLPOR','TIFLOW','BOUPRO','BOUDO1','BOUDO2','BOUDO3','BOUDO4','BOUURI','BOUPOR')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-IDCANAL', 'IDCHAN', 'C', '59', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-IDORIGEN', 'IDORIG', 'C', '1', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-IDPAIS', 'IDCOUN', 'C', 'MEX', 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-REDIRURL-PROTOCOLO', 'URLPRO', 'C', 'https://', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-REDIRURL-DOMINIO', 'URLDOM', 'C', 'www.google.com', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-REDIRURL-PUERTO', 'URLPOR', 'C', null, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-FLOW', 'TIFLOW', 'C', 'OCR|SEL|VID', 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-PROTOCOLO', 'BOUPRO', 'C', 'https://', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO1', 'C', 'bion.santander.com.mx', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO2', 'C', null, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO3', 'C', null, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO4', 'C', null, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-URI', 'BOUURI', 'C', '/?token=', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-PUERTO', 'BOUPOR', 'C', null, 'CLI')

-- ==================================================================================
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('FIBRNC','FICHNL','FITRTP', 'FIUPRO', 'FIUDO1', 'FIUDO2', 'FIUDO3', 'FIUPOR', 'FIUURI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-GENERA TOKEN OPACO-BODY REQ-BRANCH', 'FIBRNC', 'C', '0000', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-GENERA TOKEN OPACO-BODY REQ-CHANNEL', 'FICHNL', 'C', '000', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-GENERA TOKEN OPACO-BODY REQ-TRX TYPE', 'FITRTP', 'C', '7002', 'CLI')

-- DEV: https://identy-ui-mxservcorebiom-dev.appls.mex01.mex.dev.mx1.paas.cloudcenter.corp/ ***
-- PRE: https://fingerid.mxservcorebiom.pre.mx.corp
-- PRO: biomovilfi.santander.com.mx
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-PROTOCOLO', 'FIUPRO', 'C', 'https://', 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-DOMINIO1', 'FIUDO1', 'C', 'biomovilfi.santander.com.mx', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-DOMINIO2', 'FIUDO2', 'C', null, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-DOMINIO3', 'FIUDO3', 'C', null, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-PUERTO', 'FIUPOR', 'C', null, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-URI', 'FIUURI', 'C', '/assets/crm-field.htm', 'CLI')

-- ==================================================================================
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('NUMINT')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_tinyint, pa_producto) 
VALUES ('BIOONBOARD - OCR/SCORE - NUMERO DE INTENTOS', 'NUMINT', 'T', 2, 'CLI')

-- ==================================================================================
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('MOVAIN')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) 
VALUES ('FINGERID - MONTO PARA REGLA VALINE PARA SERVICIO DE VALIDACION', 'MOVAIN', 'T', 1, 'CLI')


go
