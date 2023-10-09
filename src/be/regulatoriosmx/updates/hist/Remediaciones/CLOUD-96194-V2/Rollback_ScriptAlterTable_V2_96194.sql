
---------------------------------------------------------------------------------------
--------------------------AGREGAR CAMPO PARA REPORTES        --------------------------
---------------------------------------------------------------------------------------
use cob_externos
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subproducto' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_subproducto
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_uno' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_uno
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dos' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_dos
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_tres' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_tres
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cuatro' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_cuatro
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cinco' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_cinco
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_seis' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_seis
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_siete' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_siete
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_ocho' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_ocho
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_nueve' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_nueve
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diez' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_diez 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_once' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_once
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_once
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_doce' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_doce
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_trece' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_trece
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_catorce' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_catorce 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_quince' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_quince
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciseis' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_dieciseis
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diecisiete' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_diecisiete
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciocho' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_respuesta_dieciocho
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_coordinador' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_coordinador 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_gerente' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion drop column do_gerente
go

use cob_conta_super
go
--sb_dato_operacion
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subproducto' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_subproducto
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_uno' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_uno
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dos' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_dos 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_tres' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_tres
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cuatro' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_cuatro
go

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cinco' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_cinco
go

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_seis' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_seis
go

if  exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_siete' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_siete 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_ocho' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_ocho
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_nueve' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_nueve 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diez' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_diez
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_once' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_once
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_doce' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_doce
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_trece' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_trece
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_catorce' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_catorce 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_quince' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_quince 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciseis' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_dieciseis
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diecisiete' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_diecisiete
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciocho' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_respuesta_dieciocho
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_coordinador' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_coordinador 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_gerente' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion drop column do_gerente 
go




--sb_dato_operacion_tmp

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subproducto' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_subproducto 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_uno' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_uno
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dos' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_dos
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_tres' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_tres
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cuatro' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_cuatro
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cinco' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_cinco
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_seis' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_seis
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_siete' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_siete
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_ocho' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_ocho 
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_nueve' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_nueve
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diez' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_diez
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_once' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_once
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_doce' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_doce
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_trece' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_trece
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_catorce' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_catorce
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_quince' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_quince
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciseis' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_dieciseis
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diecisiete' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_diecisiete   varchar(20) null 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciocho' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_respuesta_dieciocho
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_coordinador' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_coordinador     
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_gerente' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_gerente 
go
