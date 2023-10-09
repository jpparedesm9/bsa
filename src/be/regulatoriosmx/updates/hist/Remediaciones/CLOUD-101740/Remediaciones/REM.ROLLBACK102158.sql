
use cob_conta_super 
go 


if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_uno') 
alter table sb_dato_operacion add  do_respuesta_uno            varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_dos ')
alter table sb_dato_operacion add  do_respuesta_dos            varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_tres') 
alter table sb_dato_operacion add  do_respuesta_tres           varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_cuatro') 
alter table sb_dato_operacion add  do_respuesta_cuatro         varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_cinco') 
alter table sb_dato_operacion add  do_respuesta_cinco          varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_seis') 
alter table sb_dato_operacion add  do_respuesta_seis           varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_siete') 
alter table sb_dato_operacion add  do_respuesta_siete          varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_ocho') 
alter table sb_dato_operacion add  do_respuesta_ocho           varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_nueve') 
alter table sb_dato_operacion add  do_respuesta_nueve          varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_diez') 
alter table sb_dato_operacion add  do_respuesta_diez           varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_once') 
alter table sb_dato_operacion add  do_respuesta_once           varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_doce') 
alter table sb_dato_operacion add  do_respuesta_doce           varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_trece') 
alter table sb_dato_operacion add  do_respuesta_trece          varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_catorce') 
alter table sb_dato_operacion add  do_respuesta_catorce        varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_quince') 
alter table sb_dato_operacion add  do_respuesta_quince         varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_dieciseis') 
alter table sb_dato_operacion add  do_respuesta_dieciseis      varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_diecisiete') 
alter table sb_dato_operacion add  do_respuesta_diecisiete     varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_respuesta_dieciocho') 
alter table sb_dato_operacion add  do_respuesta_dieciocho      varchar(20) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_coordinador') 
alter table sb_dato_operacion add  do_coordinador              varchar(64) 

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion' and b.name = 'do_gerente') 
alter table sb_dato_operacion add  do_gerente                  varchar(64) 

                                                                                                                                                                                                                               



if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_uno') 
alter table sb_dato_operacion_tmp add do_respuesta_uno          varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_dos') 
alter table sb_dato_operacion_tmp add do_respuesta_dos          varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_tres') 
alter table sb_dato_operacion_tmp add do_respuesta_tres         varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_cuatro') 
alter table sb_dato_operacion_tmp add do_respuesta_cuatro       varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_cinco') 
alter table sb_dato_operacion_tmp add do_respuesta_cinco        varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_seis') 
alter table sb_dato_operacion_tmp add do_respuesta_seis         varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_siete') 
alter table sb_dato_operacion_tmp add do_respuesta_siete        varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_ocho') 
alter table sb_dato_operacion_tmp add do_respuesta_ocho         varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_nueve')
alter table sb_dato_operacion_tmp add do_respuesta_nueve        varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_diez')
alter table sb_dato_operacion_tmp add do_respuesta_diez         varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_once') 
alter table sb_dato_operacion_tmp add do_respuesta_once         varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_doce') 
alter table sb_dato_operacion_tmp add do_respuesta_doce         varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_trece') 
alter table sb_dato_operacion_tmp add do_respuesta_trece        varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_catorce') 
alter table sb_dato_operacion_tmp add do_respuesta_catorce      varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_quince') 
alter table sb_dato_operacion_tmp add do_respuesta_quince       varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_dieciseis')
alter table sb_dato_operacion_tmp add do_respuesta_dieciseis    varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_diecisiete') 
alter table sb_dato_operacion_tmp add do_respuesta_diecisiete   varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_respuesta_dieciocho') 
alter table sb_dato_operacion_tmp add do_respuesta_dieciocho    varchar(20)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_coordinador') 
alter table sb_dato_operacion_tmp add do_coordinador            varchar(64)

if  not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'sb_dato_operacion_tmp' and b.name = 'do_gerente') 
alter table sb_dato_operacion_tmp add do_gerente                varchar(64)


if object_id ('dbo.sb_dato_verificacion') is not null
	drop table dbo.sb_dato_verificacion


if exists (select 1 from sysindexes  where name = 'sb_dato_encuesta1') 
drop index sb_dato_encuesta1 on sb_dato_verificacion 
if exists (select 1 from sysindexes  where name = 'sb_dato_encuesta2') 
drop index sb_dato_encuesta2 on sb_dato_verificacion 
if exists (select 1 from sysindexes  where name = 'sb_dato_encuesta3') 
drop index sb_dato_encuesta3 on sb_dato_verificacion 



use cob_externos
go 

if not exists (select 1 from sysobjects a, syscolumns b 
	where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_uno') 
alter table ex_dato_operacion add  do_respuesta_uno          varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_dos') 
alter table ex_dato_operacion add  do_respuesta_dos          varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_tres') 
alter table ex_dato_operacion add  do_respuesta_tres         varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_cuatro') 
alter table ex_dato_operacion add  do_respuesta_cuatro       varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_cinco') 
alter table ex_dato_operacion add  do_respuesta_cinco        varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_seis') 
alter table ex_dato_operacion add  do_respuesta_seis         varchar(20)


if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_siete') 
alter table ex_dato_operacion add  do_respuesta_siete        varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_ocho')
alter table ex_dato_operacion add  do_respuesta_ocho         varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_nueve') 
alter table ex_dato_operacion add  do_respuesta_nueve        varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_diez') 
alter table ex_dato_operacion add  do_respuesta_diez         varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_once') 
alter table ex_dato_operacion add  do_respuesta_once         varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_doce') 
alter table ex_dato_operacion add  do_respuesta_doce         varchar(20)
if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_trece') 
alter table ex_dato_operacion add  do_respuesta_trece        varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_catorce') 
alter table ex_dato_operacion add  do_respuesta_catorce      varchar(20)
if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_quince') 
alter table ex_dato_operacion add  do_respuesta_quince       varchar(20)
if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_dieciseis')
alter table ex_dato_operacion add  do_respuesta_dieciseis    varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_diecisiete') 
alter table ex_dato_operacion add  do_respuesta_diecisiete   varchar(20)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_respuesta_dieciocho') 
alter table ex_dato_operacion add  do_respuesta_dieciocho    varchar(20)
if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_coordinador') 
alter table ex_dato_operacion add  do_coordinador            varchar(64)

if not exists (select 1 from sysobjects a, syscolumns b 
where a.id = b.id and a.name = 'ex_dato_operacion' and b.name = 'do_gerente') 
alter table ex_dato_operacion add  do_gerente                varchar(64)

if object_id ('dbo.ex_dato_verificacion') is not null
	drop table dbo.ex_dato_verificacion





