/*************************************************************************************/
--No Historia                : MEJ-96015
--Titulo de la Historia      : MEJORA: Correcciones en estructuras BD
--Fecha                      : 08/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Correcciones en estructuras BD
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
   select
   count(1) as 'registros ca_operacion_his actual',
   sum(oph_monto) as 'sum(oph_monto) en ca_operacion_his actual'
   from ca_operacion_his

   exec sp_rename 'ca_operacion_his','ca_operacion_his_96015'
end
go

if exists (select 1 from sys.indexes  where name='ca_operacion_his_1' and object_id = object_id('ca_operacion_his_96015'))
begin
   exec sp_rename 'ca_operacion_his_96015.ca_operacion_his_1','ca_operacion_his_96015_1','INDEX'
end
go

select * into ca_operacion_his from cob_cartera..ca_operacion_his where 1 = 2
go

insert into ca_operacion_his
select * from ca_operacion_his_96015
go

if exists (select 1 from sys.indexes  where name='ca_operacion_his_1' and object_id = object_id('ca_operacion_his'))
 begin
   drop index ca_operacion_his_1 on ca_operacion_his
end
create index ca_operacion_his_1 on ca_operacion_his (oph_operacion, oph_secuencial)
go

update statistics ca_operacion_his
go

exec sp_recompile 'ca_operacion_his'
go

sp_help ca_operacion_his
go

if object_id('ca_operacion_his') is not null
begin
   select
   count(1) as 'registros ca_operacion_his ajustada',
   sum(oph_monto) as 'sum(oph_monto) en ca_operacion_his ajustada'
   from ca_operacion_his
end
go

---------------------------------------------------------------------------
print '-->ca_rubro_op_his'
go

sp_help ca_rubro_op_his
go

if object_id('ca_rubro_op_his') is not null
begin
   select
   count(1) as 'registros ca_rubro_op_his actual',
   sum(roh_valor) as 'sum(roh_valor) en ca_rubro_op_his actual'
   from ca_rubro_op_his

   exec sp_rename 'ca_rubro_op_his','ca_rubro_op_his_96015'
end
go

if exists (select 1 from sys.indexes  where name='ca_rubro_op_his_1' and object_id = object_id('ca_rubro_op_his_96015'))
begin
   exec sp_rename 'ca_rubro_op_his_96015.ca_rubro_op_his_1','ca_rubro_op_his_96015_1','INDEX'
end
go

select * into ca_rubro_op_his from cob_cartera..ca_rubro_op_his where 1 = 2
go

insert into ca_rubro_op_his
select * from ca_rubro_op_his_96015
go

if exists (select 1 from sys.indexes  where name='ca_rubro_op_his_1' and object_id = object_id('ca_rubro_op_his'))
 begin
   drop index ca_rubro_op_his_1 on ca_rubro_op_his
end
create index ca_rubro_op_his_1 on ca_rubro_op_his (roh_operacion, roh_secuencial)
go

update statistics ca_rubro_op_his
go

exec sp_recompile 'ca_rubro_op_his'
go

sp_help ca_rubro_op_his
go

if object_id('ca_rubro_op_his') is not null
begin
   select
   count(1) as 'registros ca_rubro_op_his ajustada',
   sum(roh_valor) as 'sum(roh_valor) en ca_rubro_op_his ajustada'
   from ca_rubro_op_his
end
go

---------------------------------------------------------------------------
print '-->ca_amortizacion_his'
go

sp_help ca_amortizacion_his
go

if object_id('ca_amortizacion_his') is not null
begin
   select
   count(1) as 'registros ca_amortizacion_his actual',
   sum(amh_acumulado) as 'sum(amh_acumulado) en ca_amortizacion_his actual'
   from ca_amortizacion_his

   exec sp_rename 'ca_amortizacion_his','ca_amortizacion_his_96015'
end
go

if exists (select 1 from sys.indexes  where name='ca_amortizacion_his_1' and object_id = object_id('ca_amortizacion_his_96015'))
begin
   exec sp_rename 'ca_amortizacion_his_96015.ca_amortizacion_his_1','ca_amortizacion_his_96015_1','INDEX'
end
go

select * into ca_amortizacion_his from cob_cartera..ca_amortizacion_his where 1 = 2
go

insert into ca_amortizacion_his
select * from ca_amortizacion_his_96015
go

if exists (select 1 from sys.indexes  where name='ca_amortizacion_his_1' and object_id = object_id('ca_amortizacion_his'))
 begin
   drop index ca_amortizacion_his_1 on ca_amortizacion_his
end
create index ca_amortizacion_his_1 on ca_amortizacion_his (amh_operacion, amh_secuencial)
go

update statistics ca_amortizacion_his
go

exec sp_recompile 'ca_amortizacion_his'
go

sp_help ca_amortizacion_his
go

if object_id('ca_amortizacion_his') is not null
begin
   select
   count(1) as 'registros ca_amortizacion_his ajustada',
   sum(amh_acumulado) as 'sum(amh_acumulado) en ca_amortizacion_his ajustada'
   from ca_amortizacion_his
end
go

---------------------------------------------------------------------------
print '-->ca_correccion_his'
go

sp_help ca_correccion_his
go

if object_id('ca_correccion_his') is not null
begin
   select count(1) as 'registros ca_correccion_his actual',
   sum(coh_correccion_mn) as 'sum(coh_correccion_mn) en ca_correccion_his actual'
   from ca_correccion_his

   exec sp_rename 'ca_correccion_his','ca_correccion_his_96015'
end
go

if exists (select 1 from sys.indexes  where name='ca_co_op_his' and object_id = object_id('ca_correccion_his_96015'))
begin
   exec sp_rename 'ca_correccion_his_96015.ca_co_op_his','ca_co_op_his_96015','INDEX'
end
go

select * into ca_correccion_his from cob_cartera..ca_correccion_his where 1 = 2
go

insert into ca_correccion_his
select * from ca_correccion_his_96015
go

if exists (select 1 from sys.indexes  where name='ca_co_op_his' and object_id = object_id('ca_correccion_his'))
 begin
   drop index ca_co_op_his on ca_correccion_his
end
create index ca_co_op_his on ca_correccion_his (coh_operacion, coh_secuencial, coh_concepto)
go

update statistics ca_correccion_his
go

exec sp_recompile 'ca_correccion_his'
go

sp_help ca_correccion_his
go

if object_id('ca_correccion_his') is not null
begin
   select count(1) as 'registros ca_correccion_his ajustada',
   sum(coh_correccion_mn) as 'sum(coh_correccion_mn) en ca_correccion_his ajustada'
   from ca_correccion_his
end
go

---------------------------------------------------------------------------
print '-->ca_valores_his'
go

sp_help ca_valores_his
go

if object_id('ca_valores_his') is not null
begin
   select count(1) as 'registros ca_valores_his actual',
   sum(vah_valor) as 'sum(vah_valor) en vah_valor actual'
   from ca_valores_his

   exec sp_rename 'ca_valores_his','ca_valores_his_96015'
end
go

if exists (select 1 from sys.indexes  where name='ca_valores_his_1' and object_id = object_id('ca_valores_his_96015'))
begin
   exec sp_rename 'ca_valores_his_96015.ca_valores_his_1','ca_valores_his_96015_1','INDEX'
end
go

select * into ca_valores_his from cob_cartera..ca_valores_his where 1 = 2
go

insert into ca_valores_his
select * from ca_valores_his_96015
go

if exists (select 1 from sys.indexes  where name='ca_valores_his_1' and object_id = object_id('ca_valores_his'))
 begin
   drop index ca_valores_his_1 on ca_valores_his
end
create index ca_valores_his_1 on ca_valores_his (vah_operacion, vah_secuencial)
go

update statistics ca_valores_his
go

exec sp_recompile 'ca_valores_his'
go

sp_help ca_valores_his
go

if object_id('ca_valores_his') is not null
begin
   select count(1) as 'registros ca_valores_his ajustada',
   sum(vah_valor) as 'sum(vah_valor) en vah_valor ajustada'
   from ca_valores_his
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
create index ca_traslado_interes_his_1 on ca_traslado_interes_his (tih_operacion, tih_secuencial)
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
create index ca_operacion_ext_his_1 on ca_operacion_ext_his (oeh_operacion, oeh_secuencial)
go

sp_help ca_operacion_ext_his
go

---------------------------------------------------------------------------
