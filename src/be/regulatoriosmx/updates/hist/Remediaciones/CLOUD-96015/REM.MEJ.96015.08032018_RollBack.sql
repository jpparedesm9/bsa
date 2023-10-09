/*************************************************************************************/
--No Historia                : MEJ-96015
--Titulo de la Historia      : MEJORA: Correcciones en estructuras BD
--Fecha                      : 08/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Correcciones en estructuras BD (RollBack)
--Autor                      : Jorge Salazar Andrade
--Instalador                 : ca_table_his.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/Activas/Cartera/Backend/sql
/*************************************************************************************/
use cob_cartera_his
go 

print '-->ca_operacion_his'
go

sp_help ca_operacion_his
go

if object_id('ca_operacion_his') is not null
begin
   select count(1) as 'registros actuales ca_operacion_his' from ca_operacion_his
   exec sp_rename 'ca_operacion_his','ca_operacion_his_96015_RB'
end
go

if exists (select 1 from sys.indexes  where name='ca_operacion_his_1' and object_id = object_id('ca_operacion_his_96015_RB'))
begin
   exec sp_rename 'ca_operacion_his_96015_RB.ca_operacion_his_1','ca_operacion_his_96015_RB_1','INDEX'
end
go

if object_id('ca_operacion_his_96015') is not null
begin
   exec sp_rename 'ca_operacion_his_96015','ca_operacion_his'
end
go

if exists (select 1 from sys.indexes  where name='ca_operacion_his_96015_1' and object_id = object_id('ca_operacion_his'))
begin
   exec sp_rename 'ca_operacion_his.ca_operacion_his_96015_1','ca_operacion_his_1','INDEX'
end
go

update statistics ca_operacion_his
go

exec sp_recompile 'ca_operacion_his'
go

sp_help ca_operacion_his
go

if object_id('ca_operacion_his') is not null
begin
   select count(1) as 'registros procesados ca_operacion_his' from ca_operacion_his
end
go

---------------------------------------------------------------------------
print '-->ca_rubro_op_his_96015 -> ca_rubro_op_his'
go

sp_help ca_rubro_op_his
go

if object_id('ca_rubro_op_his') is not null
begin
   select count(1) as 'registros actuales ca_rubro_op_his' from ca_rubro_op_his
   exec sp_rename 'ca_rubro_op_his','ca_rubro_op_his_96015_RB'
end
go

if exists (select 1 from sys.indexes  where name='ca_rubro_op_his_1' and object_id = object_id('ca_rubro_op_his_96015_RB'))
begin
   exec sp_rename 'ca_rubro_op_his_96015_RB.ca_rubro_op_his_1','ca_rubro_op_his_96015_RB_1','INDEX'
end
go

if object_id('ca_rubro_op_his_96015') is not null
begin
   exec sp_rename 'ca_rubro_op_his_96015','ca_rubro_op_his'
end
go

if exists (select 1 from sys.indexes  where name='ca_rubro_op_his_96015_1' and object_id = object_id('ca_rubro_op_his'))
begin
   exec sp_rename 'ca_rubro_op_his.ca_rubro_op_his_96015_1','ca_rubro_op_his_1','INDEX'
end
go

update statistics ca_rubro_op_his
go

exec sp_recompile 'ca_rubro_op_his'
go

sp_help ca_rubro_op_his
go

if object_id('ca_rubro_op_his') is not null
begin
   select count(1) as 'registros procesados ca_rubro_op_his' from ca_rubro_op_his
end
go

---------------------------------------------------------------------------
print '-->ca_amortizacion_his_96015 -> ca_amortizacion_his'
go

sp_help ca_amortizacion_his
go

if object_id('ca_amortizacion_his') is not null
begin
   select count(1) as 'registros actuales ca_amortizacion_his' from ca_amortizacion_his
   exec sp_rename 'ca_amortizacion_his','ca_amortizacion_his_96015_RB'
end
go

if exists (select 1 from sys.indexes  where name='ca_amortizacion_his_1' and object_id = object_id('ca_amortizacion_his_96015_RB'))
begin
   exec sp_rename 'ca_amortizacion_his_96015_RB.ca_amortizacion_his_1','ca_amortizacion_his_96015_RB_1','INDEX'
end
go

if object_id('ca_amortizacion_his_96015') is not null
begin
   exec sp_rename 'ca_amortizacion_his_96015','ca_amortizacion_his'
end
go

if exists (select 1 from sys.indexes  where name='ca_amortizacion_his_96015_1' and object_id = object_id('ca_amortizacion_his'))
begin
   exec sp_rename 'ca_amortizacion_his.ca_amortizacion_his_96015_1','ca_amortizacion_his_1','INDEX'
end
go

update statistics ca_amortizacion_his
go

exec sp_recompile 'ca_amortizacion_his'
go

sp_help ca_amortizacion_his
go

if object_id('ca_amortizacion_his') is not null
begin
   select count(1) as 'registros procesados ca_amortizacion_his' from ca_amortizacion_his
end
go

---------------------------------------------------------------------------
print '-->ca_correccion_his_96015 -> ca_correccion_his'
go

sp_help ca_correccion_his
go

if object_id('ca_correccion_his') is not null
begin
   select count(1) as 'registros actuales ca_correccion_his' from ca_correccion_his
   exec sp_rename 'ca_correccion_his','ca_correccion_his_96015_RB'
end
go

if exists (select 1 from sys.indexes  where name='ca_co_op_his' and object_id = object_id('ca_correccion_his_96015_RB'))
begin
   exec sp_rename 'ca_correccion_his_96015_RB.ca_co_op_his','ca_co_op_his_96015_RB','INDEX'
end
go

if object_id('ca_correccion_his_96015') is not null
begin
   exec sp_rename 'ca_correccion_his_96015','ca_correccion_his'
end
go

if exists (select 1 from sys.indexes  where name='ca_co_op_his_96015' and object_id = object_id('ca_correccion_his'))
begin
   exec sp_rename 'ca_correccion_his.ca_co_op_his_96015','ca_co_op_his','INDEX'
end
go

update statistics ca_correccion_his
go

exec sp_recompile 'ca_correccion_his'
go

sp_help ca_correccion_his
go

if object_id('ca_correccion_his') is not null
begin
   select count(1) as 'registros procesados ca_correccion_his' from ca_correccion_his
end
go

---------------------------------------------------------------------------
print '-->ca_valores_his'
go

sp_help ca_valores_his
go

if object_id('ca_valores_his') is not null
begin
   select count(1) as 'registros actuales ca_valores_his' from ca_valores_his
   exec sp_rename 'ca_valores_his','ca_valores_his_96015_RB'
end
go

if exists (select 1 from sys.indexes  where name='ca_valores_his_1' and object_id = object_id('ca_valores_his_96015_RB'))
begin
   exec sp_rename 'ca_valores_his_96015_RB.ca_valores_his_1','ca_valores_his_96015_RB_1','INDEX'
end
go

if object_id('ca_valores_his_96015') is not null
begin
   exec sp_rename 'ca_valores_his_96015','ca_valores_his'
end
go

if exists (select 1 from sys.indexes  where name='ca_valores_his_96015_1' and object_id = object_id('ca_valores_his'))
begin
   exec sp_rename 'ca_valores_his.ca_valores_his_96015_1','ca_valores_his_1','INDEX'
end
go

update statistics ca_valores_his
go

exec sp_recompile 'ca_valores_his'
go

sp_help ca_valores_his
go

if object_id('ca_valores_his') is not null
begin
   select count(1) as 'registros procesados ca_valores_his' from ca_valores_his
end
go

---------------------------------------------------------------------------
print '-->ca_traslado_interes_his'
go

sp_help ca_traslado_interes_his
go

if exists (select 1 from sys.indexes  where name='ca_traslado_interes_his_1' and object_id = object_id('ca_traslado_interes_his'))
 begin
   drop index ca_traslado_interes_his_1 on ca_traslado_interes_his
end
create index ca_traslado_interes_his_1 on ca_traslado_interes_his (tih_secuencial, tih_operacion)
go

sp_help ca_traslado_interes_his
go

---------------------------------------------------------------------------
print '-->ca_operacion_ext_his'
go

sp_help ca_operacion_ext_his
go

if exists (select 1 from sys.indexes  where name='ca_operacion_ext_his_1' and object_id = object_id('ca_operacion_ext_his'))
 begin
   drop index ca_operacion_ext_his_1 on ca_operacion_ext_his
end
create index ca_operacion_ext_his_1 on ca_operacion_ext_his (oeh_secuencial, oeh_operacion)
go

sp_help ca_operacion_ext_his
go

---------------------------------------------------------------------------
