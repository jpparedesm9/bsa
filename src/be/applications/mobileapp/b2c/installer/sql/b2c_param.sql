/******************************************************************************/
/*  Archivo:            b2c_param.sql                                          */
/*  Base de datos:      cob_bvirtual                                          */
/*  Producto:           Banca Virtual                                         */
/******************************************************************************/
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/******************************************************************************/
/*              PROPOSITO                                                     */
/*  Creacion tabla de servicio y Vistas                                       */
/******************************************************************************/
/*              MODIFICACIONES                                                */
/******************************************************************************/
/* FECHA        VERSION       AUTOR              RAZON                        */
/******************************************************************************/
/* 28/Nov/2018   4.1.0.5    Tania Baidal     Emision Inicial Instalador B2C   */
/******************************************************************************/

use cobis
go

delete from cobis..cl_parametro
where pa_nemonico = 'B2CNPV'

insert into cobis..cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_tinyint,pa_producto)
values ('NUMERO PREGUNTAS VERIFICACION ', 'B2CNPV', 'T', 3, 'BVI')
go


delete from cobis..cl_parametro
where pa_nemonico = 'B2CMIF'

insert into cobis..cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_tinyint,pa_producto)
values ('B2C - MAXIMO INTENTOS FALLIDOS', 'B2CMIF', 'T', 10, 'BVI')
go

delete from cobis..cl_parametro
where pa_nemonico = 'B2CSBV'

insert into cobis..cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_tinyint,pa_producto)
values ('B2C - SERVICIO BANCA VIRTUAL', 'B2CSBV', 'T', 8, 'BVI')

go
delete from cl_parametro where pa_nemonico in ('MBSTO','TLSC','MTDS') and pa_producto = 'BVI'
go

insert into cl_parametro 
values('B2C - TIMEOUT SESSION','MBSTO','T',NULL,5,NULL,NULL,NULL,NULL,NULL,'BVI')

insert into cobis..cl_parametro 
values('B2C - TELEFONO SERVICIO TUIIO','TLSC','C','099367289',NULL,NULL,NULL,NULL,NULL,NULL,'BVI')

insert into cl_parametro 
values('B2C - TIEMPO DE SESION','MTDS','T',NULL,59,NULL,NULL,NULL,NULL,NULL,'BVI')
go

delete cl_parametro where pa_nemonico ='WPPMOM' and pa_producto = 'CLI'
insert into cl_parametro values ('WEB PAY PLUS MONTO MINIMO', 'WPPMOM', 'F', null, null, null, null, null, null, 1, 'CLI')


go
delete from cl_parametro where pa_nemonico = 'VCLAN'

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo , pa_char, pa_producto) values('VALIDA CLIENTES ANTIGUOS','VCLAN','C','S','ADM')
go


declare 
@w_producto_abrev      varchar(3)

select @w_producto_abrev  = pd_abreviatura from cl_producto where pd_descripcion = 'BANCA VIRTUAL'
delete cl_parametro where pa_nemonico in ('ENRTPL', 'OTPTPL', 'IMGTPL', 'B2CMEN') 

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TEMPLATE SMS ENROLAMIENTO', 'ENRTPL', 'I', null, null, null, 50470, null, null, null, @w_producto_abrev)
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TEMPLATE SMS OTP', 'OTPTPL', 'I', null, null, null, 50471, null, null, null, @w_producto_abrev)
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TEMPLATE IMAGEN BIENVENIDA', 'IMGTPL', 'I', null, null, null, 50472, null, null, null, @w_producto_abrev)
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('B2C - TIPO MEDIO DE ENVIO ','B2CMEN', 'T','SMS', null, null, null, null, null, null, 'BVI')

go

-- =======================================================================
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in (
	'IDCHAN','IDORIG','IDCOUN','URLPRO','URLDOM','URLPOR',
	'TIFLOW','BOUPRO','BOUDO1','BOUDO2','BOUDO3','BOUDO4',
	'BOUURI','BOUPOR')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-IDCANAL', 'IDCHAN', 'C', '59', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-IDORIGEN', 'IDORIG', 'C', '1', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-IDPAIS', 'IDCOUN', 'C', 'MEX', 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-REDIRURL-PROTOCOLO', 'URLPRO', 'C', 'https://', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-REDIRURL-DOMINIO', 'URLDOM', 'C', 'www.google.com', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-REDIRURL-PUERTO', 'URLPOR', 'C', null, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-GENERA TOKEN OPACO-BODY REQ-FLOW', 'TIFLOW', 'C', 'OCR|SEL|VID', 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-PROTOCOLO', 'BOUPRO', 'C', 'https://', 'CLI')
-- https://bioonboarding-web-mx-secmgmt-pmi-authesrv-dev.appls.mex01.mex.dev.mx1.paas.cloudcenter.corp/?token=
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO1', 'C', 'bioonboarding-web-mx-secmgmt-', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO2', 'C', 'pmi-authesrv-dev.appls.mex01.', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO3', 'C', 'mex.dev.mx1.paas.cloudcenter.', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('BIOONBOARD-URL PARA TOKEN OPACO-DOMINIO', 'BOUDO4', 'C', 'corp', 'CLI')
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

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-DOMINIO1', 'FIUDO1', 'C', 'identy-ui-mxservcorebiom-dev.', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-DOMINIO2', 'FIUDO2', 'C', 'appls.mex01.mex.dev.mx1.paas.', 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) VALUES ('FINGERID-URL PARA TOKEN OPACO-DOMINIO3', 'FIUDO3', 'C', 'cloudcenter.corp', 'CLI')

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

---------------------------------------------------------------------------------------------------------------
use cobis
go

delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('APRDIG')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) 
VALUES ('ACTIVACION PRODUCTO DIGITAL', 'APRDIG', 'C', 'N', 'CLI')
go

---------------------------------------------------------------------------------------------------------------
delete from cobis..cl_parametro where pa_nemonico in ('TOVCO','TOVSM') and pa_producto='BVI'
insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_smallint, pa_producto)
values('TIEMPO DE VIGENCIA OTP CORREO','TOVCO','S',120,'BVI')
insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_smallint, pa_producto)
values('TIEMPO DE VIGENCIA OTP SMS','TOVSM','S',120,'BVI')
go

