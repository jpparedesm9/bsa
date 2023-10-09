--Caso196073 - Envio de documentos digitales
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Tabla de Canales
use cobis
go

if object_id ('dbo.cl_canal') is not null
  drop table dbo.cl_canal
go

create table cl_canal(
  ca_nombre      varchar(256),
  ca_canal       int,        
  ca_estado      char(1),
  ca_fecha_crea  datetime
)
go

insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('b2c_digital', 3,  'V', getdate())
insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('b2b',         20, 'V', getdate())
insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('b2c',         8,  'V', getdate())
insert into cl_canal (ca_nombre, ca_canal, ca_estado, ca_fecha_crea) values ('web',         4,  'V', getdate())

select * from cl_canal

go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--ANTES
select * from cob_credito..cr_reporte_on_boarding

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos
use cob_credito
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_est_des_alfresco')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_est_des_alfresco char(1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_canal')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_canal int
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_carpeta')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_carpeta varchar(10)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_codigo_tipo_doc')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_codigo_tipo_doc smallint
end
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Actualizacion Registros de Documentos
use cob_credito
go

declare @w_canal int

select @w_canal = ca_canal 
from cobis..cl_canal
where ca_nombre = 'b2c_digital'

--AutoOnboarding
update cr_reporte_on_boarding 
set ra_est_des_alfresco = 'N',
    ra_canal = @w_canal
where ra_cod_documento 
in ('100', '101', '102', '103', '104', '105')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Nuevos Registros de Documentos
use cob_credito
go

declare @w_canal int

select @w_canal = ca_canal 
from cobis..cl_canal
where ca_nombre = 'web'

delete from cr_reporte_on_boarding where ra_cod_documento 
in ('109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120', '121')

--Grupal
insert into cr_reporte_on_boarding values ('109', null,                      'CONTRATO GRUPAL',                             'N', 'S', 'GRUPAL',     '_gr',  'S', @w_canal, 'Inbox',    2)
insert into cr_reporte_on_boarding values ('110', null,                      'CARATULA DE CREDITO GRUPAL',                  'N', 'S', 'GRUPAL',     '_gr',  'S', @w_canal, 'Inbox',    11)
insert into cr_reporte_on_boarding values ('111', null,                      'TABLA DE AMORTIZACION GRUPAL',                'N', 'S', 'GRUPAL',     '_gr',  'S', @w_canal, 'Inbox',    10)
insert into cr_reporte_on_boarding values ('112', null,                      'SOLICITUD DE CREDITO COMPLEMENTARIA',         'N', 'N', 'GRUPAL',     '_gr',  'N', @w_canal, 'Customer', null)
insert into cr_reporte_on_boarding values ('113', 'PagoCorresponsal.jasper', 'FICHA DE PAGO GRUPAL',                        'S', 'S', 'GRUPAL',     '_gr',  'N', @w_canal, null,       null)
--Revolvente
insert into cr_reporte_on_boarding values ('114', null,                      'CONTRATO DE LINEA DE CREDITO REVOLVENTE LCR', 'N', 'S', 'REVOLVENTE', '_lcr', 'S', @w_canal, 'Inbox',    15)
insert into cr_reporte_on_boarding values ('115', null,                      'CARATULA LCR',                                'N', 'S', 'REVOLVENTE', '_lcr', 'S', @w_canal, 'Inbox',    14)
insert into cr_reporte_on_boarding values ('116', null,                      'SOLICITUD COMPLEMENTARIA LCR',                'N', 'N', 'REVOLVENTE', '_lcr', 'N', @w_canal, 'Inbox',    30)
--Individual
insert into cr_reporte_on_boarding values ('117', null,                      'CONTRATO DE INCLUSION INDIVIDUAL',            'N', 'S', 'INDIVIDUAL', '_in',  'S', @w_canal, 'Inbox',    8)
insert into cr_reporte_on_boarding values ('118', null,                      'CARATULA DE CREDITO INDIVIDUAL',              'N', 'S', 'INDIVIDUAL', '_in',  'S', @w_canal, 'Inbox',    6)
insert into cr_reporte_on_boarding values ('119', null,                      'TABLA DE AMORTIZACION GRUPAL',                'N', 'S', 'INDIVIDUAL', '_in',  'S', @w_canal, 'Inbox',    10)
insert into cr_reporte_on_boarding values ('120', null,                      'SOLICITUD DE CREDITO COMPLEMENTARIA',         'N', 'N', 'INDIVIDUAL', '_in',  'N', @w_canal, 'Customer', null)
insert into cr_reporte_on_boarding values ('121', 'PagoCorresponsal.jasper', 'FICHA DE PAGO INDIVIDUAL',                    'S', 'S', 'INDIVIDUAL', '_in',  'N', @w_canal, null,       null)
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

--DESPUES
select * from cr_reporte_on_boarding
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos Tabla Detalle
use cob_credito
go

--ANTES
select * from cob_credito..cr_cli_reporte_on_boarding_det

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_est_des_alfresco')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_est_des_alfresco char(1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_canal')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_canal int
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_id_inst_proc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_id_inst_proc int
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_grupo')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_grupo int
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_carpeta')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_carpeta varchar(10)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_nombre_doc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_nombre_doc varchar(255)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_codigo_tipo_doc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_codigo_tipo_doc smallint
end

--DESPUES
select * from cr_cli_reporte_on_boarding_det
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
