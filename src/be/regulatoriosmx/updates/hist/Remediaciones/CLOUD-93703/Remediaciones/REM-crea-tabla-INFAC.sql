use cob_conta_super
go
if exists(select 1 from sysobjects where name = 'sb_xml_interfactura')
    drop table sb_xml_interfactura
go
--Creacion de tablas Para Interfactura
CREATE TABLE sb_xml_interfactura(
in_codigo INT IDENTITY,
in_fecha  DATETIME,--2
in_banco  VARCHAR(15),--3
in_cliente_rfc VARCHAR(30),--4
in_email VARCHAR(254),--5
in_folio_fiscal VARCHAR(60),--6
in_certificado VARCHAR (30),--7
in_sello_digital VARCHAR(1500),--8
in_sello_sat VARCHAR(1500),--9
in_num_se_certificado VARCHAR(30),--10
in_fecha_certificacion DATETIME,--11
in_cadena_cer_dig_sat VARCHAR(1500),--12
in_nombre_archivo VARCHAR(100),
in_observacion VARCHAR(300)--12
)

go
if exists(select 1 from sysobjects where name = 'tmp_sb_xml_interfactura')
    drop table tmp_sb_xml_interfactura
go

CREATE TABLE tmp_sb_xml_interfactura(
tmp_in_fecha	        DATETIME,
tmp_in_nombre_archivo	VARCHAR (50),
tmp_in__observacion     VARCHAR (200)
)

GO

