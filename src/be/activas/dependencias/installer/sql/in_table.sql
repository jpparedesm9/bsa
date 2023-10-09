
use cob_interfase
go

if exists(select 1 from sysobjects
           where name = 'in_numlet')
   drop table in_numlet
go

create table in_numlet
(
   nl_tipo             char(1)      not null,
   nl_numero           tinyint      not null,
   nl_letras_esp       varchar(24)  not null,
   nl_letras_otro      varchar(24)  not null
)
go