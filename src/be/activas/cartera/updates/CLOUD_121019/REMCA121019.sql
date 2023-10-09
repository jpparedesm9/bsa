/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Soporte #120922: Anexar correo del analista en la entrega de referencias de pag
--Fecha                      : 01/07/2019
--Descripción del Problema   : No existen campos para correo 
--Descripción de la Solución : Crear campos para correo
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/
--------------------------------------------------------------------------------------------
-- AGREGAR CAMPOS
--------------------------------------------------------------------------------------------

use cob_cartera
go

--Agregar campo nombre5
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'grv_dest_nombre5 ' and TABLE_NAME = 'ca_gen_ref_cuota_vigente')
begin
    alter table cob_cartera..ca_gen_ref_cuota_vigente add grv_dest_nombre5 varchar (60) null
end
else
begin
	alter table cob_cartera..ca_gen_ref_cuota_vigente alter column grv_dest_nombre5 varchar (60) null
end

--Agregar campo nombre5
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'grv_dest_cargo5 ' and TABLE_NAME = 'ca_gen_ref_cuota_vigente')
begin
    alter table cob_cartera..ca_gen_ref_cuota_vigente add grv_dest_cargo5 varchar (100) null
end
else
begin
	alter table cob_cartera..ca_gen_ref_cuota_vigente alter column grv_dest_cargo5 varchar (100) null
end

--Agregar campo nombre5
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'grv_dest_email5 ' and TABLE_NAME = 'ca_gen_ref_cuota_vigente')
begin
    alter table cob_cartera..ca_gen_ref_cuota_vigente add grv_dest_email5 varchar (255) null
end
else
begin
	alter table cob_cartera..ca_gen_ref_cuota_vigente alter column grv_dest_email5 varchar (255) null
end
