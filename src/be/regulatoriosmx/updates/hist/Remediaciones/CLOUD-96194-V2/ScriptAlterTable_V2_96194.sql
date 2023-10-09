
---------------------------------------------------------------------------------------
--------------------------AGREGAR CAMPO PARA REPORTES        --------------------------
---------------------------------------------------------------------------------------
use cob_externos
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subproducto' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_subproducto varchar(10) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_subproducto  varchar(10) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_uno' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_uno varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_uno  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dos' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_dos varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_dos  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_tres' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_tres varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_tres  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cuatro' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_cuatro varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_cuatro  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cinco' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_cinco varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_cinco  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_seis' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_seis varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_seis  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_siete' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_siete varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_siete  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_ocho' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_ocho varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_ocho  varchar(20) null 
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_nueve' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_nueve varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_nueve  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diez' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_diez varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_diez  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_once' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_once varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_once  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_doce' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_doce varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_doce  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_trece' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_trece varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_trece  varchar(20) null 
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_catorce' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_catorce varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_catorce  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_quince' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_quince varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_quince  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciseis' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_dieciseis varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_dieciseis  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diecisiete' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_diecisiete varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_diecisiete  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciocho' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_respuesta_dieciocho varchar(20) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_respuesta_dieciocho  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_coordinador' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_coordinador varchar(64) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_coordinador  varchar(64) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_gerente' and TABLE_NAME = 'ex_dato_operacion')
    alter table cob_externos..ex_dato_operacion add do_gerente varchar(64) null 
else
	alter table cob_externos..ex_dato_operacion alter column do_gerente  varchar(64) null 
go

use cob_conta_super
go
--sb_dato_operacion
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subproducto' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_subproducto varchar(10) null
else
	alter table cob_conta_super..sb_dato_operacion alter column do_subproducto varchar(10) null
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_uno' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_uno varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_uno  varchar(20) null 
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dos' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_dos varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_dos  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_tres' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_tres varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_tres  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cuatro' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_cuatro varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_cuatro  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cinco' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_cinco varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_cinco  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_seis' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_seis varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_seis  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_siete' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_siete varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_siete  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_ocho' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_ocho varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_ocho  varchar(20) null 
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_nueve' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_nueve varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_nueve  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diez' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_diez varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_diez  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_once' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_once varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_once  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_doce' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_doce varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_doce  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_trece' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_trece varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_trece  varchar(20) null 
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_catorce' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_catorce varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_catorce  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_quince' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_quince varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_quince  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciseis' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_dieciseis varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_dieciseis  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diecisiete' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_diecisiete varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_diecisiete  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciocho' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_respuesta_dieciocho varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_respuesta_dieciocho  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_coordinador' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_coordinador varchar(64) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_coordinador  varchar(64) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_gerente' and TABLE_NAME = 'sb_dato_operacion')
    alter table cob_conta_super..sb_dato_operacion add do_gerente varchar(64) null 
else
	alter table cob_conta_super..sb_dato_operacion alter column do_gerente  varchar(64) null 
go




--sb_dato_operacion_tmp

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subproducto' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_subproducto varchar(10) null
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_subproducto varchar(10) null
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_uno' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_uno varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_uno  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dos' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_dos varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_dos  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_tres' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_tres varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_tres  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cuatro' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_cuatro varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_cuatro  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_cinco' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_cinco varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_cinco  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_seis' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_seis varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_seis  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_siete' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_siete varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_siete  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_ocho' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_ocho varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_ocho  varchar(20) null 
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_nueve' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_nueve varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_nueve  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diez' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_diez varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_diez  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_once' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_once varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_once  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_doce' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_doce varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_doce  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_trece' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_trece varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_trece  varchar(20) null 
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_catorce' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_catorce varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_catorce  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_quince' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_quince varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_quince  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciseis' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_dieciseis varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_dieciseis  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_diecisiete' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_diecisiete varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_diecisiete  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_respuesta_dieciocho' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_respuesta_dieciocho varchar(20) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_respuesta_dieciocho  varchar(20) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_coordinador' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_coordinador varchar(64) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_coordinador  varchar(64) null 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_gerente' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table cob_conta_super..sb_dato_operacion_tmp add do_gerente varchar(64) null 
else
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_gerente  varchar(64) null 
go
