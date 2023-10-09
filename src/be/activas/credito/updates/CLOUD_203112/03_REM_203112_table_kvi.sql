use cobis
go 

--Antes
select top 1 * from cobis..cl_ente_aux

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cl_ente_aux' and COLUMN_NAME = 'ea_nivel_riesgo_1')
begin
  alter table cobis..cl_ente_aux add ea_nivel_riesgo_1 char(1)
end

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cl_ente_aux' and COLUMN_NAME = 'ea_nivel_riesgo_2')
begin
  alter table cobis..cl_ente_aux add ea_nivel_riesgo_2 char(2)
end

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cl_ente_aux' and COLUMN_NAME = 'ea_tipo_calif_eva_cli')
begin
  alter table cobis..cl_ente_aux add ea_tipo_calif_eva_cli varchar(10)
end

--Despues
select top 1 * from cobis..cl_ente_aux


--->>>>>>>>>>>>>>>>>>>Requerimiento #203112 OT Modelo Aceptación Grupal, BC
use cob_credito
go

print 'CREACION TABLA: cr_vigencia_tipo_calif'
if object_id ('dbo.cr_vigencia_tipo_calif') is not null
	drop table dbo.cr_vigencia_tipo_calif
go

create table dbo.cr_vigencia_tipo_calif(
    vg_ente         int,
    vg_oficina      smallint,   
	vg_canal        int,
	vg_vigencia     int,
	vg_tipo_calif   varchar(10),
	vg_usuario      varchar(14),
	vg_fecha_reg    datetime,
	vg_fecha_proc   datetime,
	vg_evaluo_buro  char(1), -- S consulto a buro
	vg_result_eval  varchar(256) -- Resultado evalua reglas
)
go

select * from cob_credito..cr_vigencia_tipo_calif


--->>>>>>>>>>>>>>>>>>>Requerimiento #203112 OT Modelo Aceptación Grupal, BC
use cob_credito_his
go

print 'CREACION TABLA: cr_vigencia_tipo_calif_his'
if object_id ('dbo.cr_vigencia_tipo_calif_his') is not null
	drop table dbo.cr_vigencia_tipo_calif_his
go

create table dbo.cr_vigencia_tipo_calif_his(
    vgh_ente           int,
    vgh_oficina        smallint,   
	vgh_canal          int,
	vgh_vigencia       int,
	vgh_tipo_calif     varchar(10),
	vgh_usuario        varchar(14),
	vgh_fecha_reg      datetime,
	vgh_fecha_proc     datetime,
	vgh_fecha_paso_his datetime,
	vgh_evaluo_buro    char(1), -- S consulto a buro
	vgh_result_eval    varchar(256) -- Resultado evalua reglas
)
go

select * from cob_credito_his..cr_vigencia_tipo_calif_his

go
