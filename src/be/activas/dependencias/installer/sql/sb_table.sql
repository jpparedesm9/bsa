use cob_sbancarios
go

if exists(select 1 from sysobjects
           where name = 'sb_instrumentos')
   drop table sb_instrumentos
go

create table sb_instrumentos
(
   in_cod_instrumento   smallint      not null,
   in_nombre            varchar(64)   not null,
   in_estado            char(1)       not null,
   in_cod_producto      tinyint       not null,
   in_moneda            tinyint       null,
   in_tipo_cotizacion   char(1)       not null,
   constraint pk_sb_instrumentos primary key clustered (in_cod_instrumento)
)
go

