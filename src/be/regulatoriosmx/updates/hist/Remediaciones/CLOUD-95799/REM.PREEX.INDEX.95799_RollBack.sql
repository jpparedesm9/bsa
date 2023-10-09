use cob_cartera_his
go 

print '-->eliminado indice ca_operacion_his'
if exists (select 1  from sys.indexes  where name='ca_operacion_his_1' 
 and object_id = object_id('dbo.ca_operacion_his'))
begin
   drop index ca_operacion_his_1 on dbo.ca_operacion_his
end

---------------------------------------------------------------------------
print '-->eliminado indice ca_rubro_op_his'
if exists (select 1  from sys.indexes  where name='ca_rubro_op_his_1' 
 and object_id = object_id('dbo.ca_rubro_op_his'))
 begin
   drop index ca_rubro_op_his_1 on dbo.ca_rubro_op_his
end

-------------------------------------------------------------------------
print '-->eliminado indice ca_dividendo_his'
if exists (select 1  from sys.indexes  where name='ca_dividendo_his_1' 
	and object_id = object_id('dbo.ca_dividendo_his'))
begin
   drop index ca_dividendo_his_1 on dbo.ca_dividendo_his
end

-------------------------------------------------------------------------
print '-->eliminado indice ca_amortizacion_his'
if exists (select 1  from sys.indexes  where name='ca_amortizacion_his_1' 
	and object_id = object_id('dbo.ca_amortizacion_his'))
begin
   drop index ca_amortizacion_his_1 on dbo.ca_amortizacion_his
end

---------------------------------------------------------------------------
print '-->eliminado indice ca_correccion_his'
if exists (select 1  from sys.indexes  where name='ca_co_op_his' 
	and object_id = object_id('dbo.ca_correccion_his'))
begin
   drop index ca_co_op_his on dbo.ca_correccion_his
end

----------------------------------------------------------------------------
print '-->eliminado indice ca_cuota_adicional_his'
if exists (select 1  from sys.indexes  where name='ca_cuota_adicional_his_1' 
	and object_id = object_id('dbo.ca_cuota_adicional_his'))
begin
   drop index ca_cuota_adicional_his_1 on dbo.ca_cuota_adicional_his
end

--------------------------------------------------------------------------
print '-->eliminado indice ca_valores_his'
if exists (select 1  from sys.indexes  where name='ca_valores_his_1' 
	and object_id = object_id('dbo.ca_valores_his'))
begin
   drop index ca_valores_his_1 on dbo.ca_valores_his
end

----------------------------------------------------------------------
print '-->eliminado indice ca_facturas_his'
if exists (select 1  from sys.indexes  where name='ca_facturas_his_1' 
	and object_id = object_id('dbo.ca_facturas_his'))
begin
   drop index ca_facturas_his_1 on dbo.ca_facturas_his
end

-------------------------------------------------------------------
print '-->eliminado indice ca_traslado_interes_his'
if exists (select 1  from sys.indexes  where name='ca_traslado_interes_his_1' 
	and object_id = object_id('dbo.ca_traslado_interes_his'))
begin
   drop index ca_traslado_interes_his_1 on dbo.ca_traslado_interes_his
end

------------------------------------------------------------------------
print '-->eliminado indice ca_operacion_ext_his'
if exists (select 1  from sys.indexes  where name='ca_operacion_ext_his_1' 
	and object_id = object_id('dbo.ca_operacion_ext_his'))
begin
   drop index ca_operacion_ext_his_1 on dbo.ca_operacion_ext_his
end

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