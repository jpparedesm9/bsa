use cobis
go

if exists(select 1 from sysobjects
           where name = 'te_caracteristicas_tasa')
   drop table te_caracteristicas_tasa
go
		   
create table te_caracteristicas_tasa
(
   ca_tasa          catalogo   not null,
   ca_periodo       smallint   not null,
   ca_modalidad     char(1)    not null,
   ca_estado        char(1)    not null,
   ca_rango         char(1)    not null,
   ca_nro_tasas     smallint   null,
   ca_num_periodo   int        not null
)

create unique nonclustered index te_caracteristicas_tasa_Key
    on te_caracteristicas_tasa (ca_tasa,ca_periodo,ca_modalidad)

go


if exists(select 1 from sysobjects
           where name = 'ad_rastro_catalogo')
   drop table ad_rastro_catalogo
go
		   
create table ad_rastro_catalogo
(
   rc_codigo_tabla    smallint      not null,
   rc_tabla           varchar(30)   not null,
   rc_codigo          catalogo      null,
   rc_valor           descripcion   null,
   rc_estado          estado        null,
   rc_tabla_dbf       varchar(30)   not null,
   rc_fecha_ult_mod   datetime      not null 
)

create nonclustered index ad_rastro_catalogo_key
    on ad_rastro_catalogo (rc_codigo_tabla, rc_fecha_ult_mod)

go
