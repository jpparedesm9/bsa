use cobis
go

if exists(select 1 from sysobjects
           where name = 'te_pizarra')
   drop table te_pizarra
go
		   
create table te_pizarra
(
   pi_cod_pizarra       int        not null,      
   pi_moneda            tinyint    not null, 
   pi_valor             float      not null, 
   pi_fecha_fin         datetime   null,
   pi_fecha_inicio      datetime   null,
   pi_referencia        catalogo   not null, 
   pi_periodo           smallint   null,
   pi_modalidad         char(1)    null,
   pi_tipo_valor        char(1)    not null, 
   pi_tipo_tasa         char(1)    null,
   pi_rango_desde       smallint   null,
   pi_rango_hasta       smallint   null,
   pi_caracteristica    char(1)    not null 
)
go

if exists(select 1 from sysobjects
           where name = 'te_tpizarra')
   drop table te_tpizarra
go

create table te_tpizarra
	(
	pi_cod_pizarra    INT NOT NULL,
	pi_moneda         TINYINT NOT NULL,
	pi_valor          FLOAT NOT NULL,
	pi_fecha_fin      DATETIME,
	pi_fecha_inicio   DATETIME,
	pi_referencia     catalogo NOT NULL,
	pi_periodo        SMALLINT,
	pi_modalidad      CHAR (1),
	pi_tipo_valor     CHAR (1) NOT NULL,
	pi_tipo_tasa      CHAR (1),
	pi_rango_desde    SMALLINT,
	pi_rango_hasta    SMALLINT,
	pi_caracteristica CHAR (1) NOT NULL,
	pi_autoriza       CHAR (1),
	pi_login          login
	)
GO


if exists(select 1 from sysobjects
           where name = 'te_tasas_referenciales')
   drop table te_tasas_referenciales
go

create table te_tasas_referenciales
	(
	tr_tasa        catalogo NOT NULL,
	tr_descripcion descripcion NOT NULL,
	tr_estado      CHAR (1) NOT NULL
	)
go

create unique index te_tasas_referenciales_Key
	ON te_tasas_referenciales (tr_tasa)
go




