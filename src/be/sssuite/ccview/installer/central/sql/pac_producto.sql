
/******************************************************************/
/* PROPOSITO: SCRIPT DE REGISTRO DE VISTA CONSOLIDADA DE CLIENTES */
/******************************************************************/

use cobis
go  

print 'ELIMINAR PRODUCTO VISTA CONSOLIDADA DE CLIENTES'
go
delete cobis..cl_producto
  where	pd_producto = 73
go

print 'CREAR PRODUCTO VISTA CONSOLIDADA DE CLIENTES'
go
insert into cobis..cl_producto
  (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura,pd_fecha_apertura,
  pd_estado,pd_saldo_minimo,pd_costo)
  values (73, 'R', 'VISTA CONSOLIDADA DE CLIENTES', 'VCC', getdate(), 'V', $0, $0)
go

print 'CREACION DE MONEDAS DEL PRODUCTO VISTA CONSOLIDADA DE CLIENTES'
go
if exists (select * from cl_pro_moneda where pm_producto = 73)
  delete cl_pro_moneda where pm_producto = 73
go
insert into cl_pro_moneda
  (pm_producto, pm_tipo, pm_moneda, pm_descripcion,pm_fecha_aper, pm_estado)
  values (73, 'R', 0, 'VISTA CONSOLIDADA DE CLIENTES', getdate(), 'V')
go

print 'CREAR PRODUCTO VISTA CONSOLIDADA DE CLIENTES'
go
declare @w_tbl int
select @w_tbl = codigo from cobis..cl_tabla where tabla like 'cl_producto'
if not exists (select 1 from cobis..cl_catalogo
  where tabla = @w_tbl
  and codigo = '73')
begin
  insert into cobis..cl_catalogo( tabla, codigo, valor, estado) values (@w_tbl, '73', 'VISTA CONSOLIDADA DE CLIENTES', 'V')
end
go
