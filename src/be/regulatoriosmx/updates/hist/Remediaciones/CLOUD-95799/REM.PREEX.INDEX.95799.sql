use cob_cartera_his
go 

print '-->creado indice ca_operacion_his'
if exists (select 1  from sys.indexes  where name='ca_operacion_his_1' 
 and object_id = object_id('dbo.ca_operacion_his'))
begin
   drop index ca_operacion_his_1 on dbo.ca_operacion_his
end

create index ca_operacion_his_1
    on dbo.ca_operacion_his (oph_operacion, oph_secuencial) 
go

---------------------------------------------------------------------------
print '-->creado indice ca_rubro_op_his'
if exists (select 1  from sys.indexes  where name='ca_rubro_op_his_1' 
 and object_id = object_id('dbo.ca_rubro_op_his'))
 begin
   drop index ca_rubro_op_his_1 on dbo.ca_rubro_op_his
end

create index ca_rubro_op_his_1
    on dbo.ca_rubro_op_his (roh_operacion, roh_secuencial)
go
--------------------------------------------------------------------------
print '-->creado indice ca_dividendo_his'
if exists (select 1  from sys.indexes  where name='ca_dividendo_his_1' 
	and object_id = object_id('dbo.ca_dividendo_his'))
begin
   drop index ca_dividendo_his_1 on dbo.ca_dividendo_his
end

create index ca_dividendo_his_1
    on dbo.ca_dividendo_his (dih_operacion, dih_secuencial)
go
-------------------------------------------------------------------------
print '-->creado indice ca_amortizacion_his'
if exists (select 1  from sys.indexes  where name='ca_amortizacion_his_1' 
	and object_id = object_id('dbo.ca_amortizacion_his'))
begin
   drop index ca_amortizacion_his_1 on dbo.ca_amortizacion_his
end

create index ca_amortizacion_his_1
    on dbo.ca_amortizacion_his (amh_operacion, amh_secuencial)
go
---------------------------------------------------------------------------
print '-->creado indice ca_correccion_his'
if exists (select 1  from sys.indexes  where name='ca_co_op_his' 
	and object_id = object_id('dbo.ca_correccion_his'))
begin
   drop index ca_co_op_his on dbo.ca_correccion_his
end
create index ca_co_op_his
    on dbo.ca_correccion_his (coh_operacion, coh_secuencial, coh_concepto)
go
----------------------------------------------------------------------------
print '-->creado indice ca_cuota_adicional_his'
if exists (select 1  from sys.indexes  where name='ca_cuota_adicional_his_1' 
	and object_id = object_id('dbo.ca_cuota_adicional_his'))
begin
   drop index ca_cuota_adicional_his_1 on dbo.ca_cuota_adicional_his
end
create index ca_cuota_adicional_his_1
    on dbo.ca_cuota_adicional_his (cah_operacion, cah_secuencial)
go
--------------------------------------------------------------------------
print '-->creado indice ca_valores_his'
if exists (select 1  from sys.indexes  where name='ca_valores_his_1' 
	and object_id = object_id('dbo.ca_valores_his'))
begin
   drop index ca_valores_his_1 on dbo.ca_valores_his
end

create index ca_valores_his_1
    on dbo.ca_valores_his (vah_secuencial, vah_operacion)
go
----------------------------------------------------------------------
print '-->creado indice ca_facturas_his'
if exists (select 1  from sys.indexes  where name='ca_facturas_his_1' 
	and object_id = object_id('dbo.ca_facturas_his'))
begin
   drop index ca_facturas_his_1 on dbo.ca_facturas_his
end
create index ca_facturas_his_1
  on dbo.ca_facturas_his (fach_secuencial, fach_operacion)
go
-------------------------------------------------------------------
print '-->creado indice ca_traslado_interes_his'
if exists (select 1  from sys.indexes  where name='ca_traslado_interes_his_1' 
	and object_id = object_id('dbo.ca_traslado_interes_his'))
begin
   drop index ca_traslado_interes_his_1 on dbo.ca_traslado_interes_his
end
create index ca_traslado_interes_his_1
  on dbo.ca_traslado_interes_his (tih_secuencial, tih_operacion)
go
------------------------------------------------------------------------
print '-->creado indice ca_operacion_ext_his'
if exists (select 1  from sys.indexes  where name='ca_operacion_ext_his_1' 
	and object_id = object_id('dbo.ca_operacion_ext_his'))
begin
   drop index ca_operacion_ext_his_1 on dbo.ca_operacion_ext_his
end
create index ca_operacion_ext_his_1
  on dbo.ca_operacion_ext_his (oeh_secuencial, oeh_operacion)
go
--------------------------------------------------------------------------
update statistics ca_operacion_his
go
update statistics ca_rubro_op_his
go
update statistics ca_dividendo_his
go
update statistics ca_amortizacion_his
go
update statistics ca_correccion_his
go
update statistics ca_cuota_adicional_his
go
update statistics ca_valores_his
go
update statistics ca_facturas_his
go
update statistics ca_traslado_interes_his
go
update statistics ca_operacion_ext_his
go