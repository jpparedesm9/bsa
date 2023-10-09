use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CLI'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in (
   'cl_giro_negocio'
   )
go

--/////////////////////////////
delete cl_catalogo
  from cl_tabla
 where cl_tabla.codigo = cl_catalogo.tabla
  and cl_tabla.tabla in  (
   'cl_giro_negocio'
   )
--/////////////////////////////
delete cl_tabla                          
 where cl_tabla.tabla in    (
   'cl_giro_negocio'
   )
go

------------------------------------------------
-- giros de negocio
------------------------------------------------
print 'cl_giro_negocio'

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cl_giro_negocio', 'Giros de Negocio')

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'S', 'SERVICIO', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'P', 'PRODUCCION', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'A', 'ALIMENTOS', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'E', 'EDUCACION', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'T', 'TURISMO', 'V', NULL, NULL, NULL)
GO



insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in (
   'cl_giro_negocio'
   )
go



