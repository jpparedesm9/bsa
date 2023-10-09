use cobis		
go

/*BORRA TODO LO EXISTENTE EN EL CATALOGO DEL MODULO PARA PODERLO REGENERAR*/
delete cl_catalogo_pro
	where cp_producto = 'VER'

delete cl_catalogo
	from cl_tabla, cl_catalogo 
	where cl_tabla.tabla like 've_%' and
	      cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla 
	where tabla like 've_%'
go

/*INSERTA LOS CAMPOS CORRESPONDIENTES AL MODULO EN EL CATALOGO*/

declare @w_codigo smallint

print 'Propositos'
select @w_codigo = max(isnull(codigo,0)) + 1 from cl_tabla
insert into cl_tabla values (@w_codigo, 've_proposito', 'PROPOSITOS DE CATALOGACION')
insert into cl_catalogo_pro values ('VER', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'PRU', 'PRUEBAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'DES', 'DESARROLLO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'PRO', 'PRODUCCION', 'V')

update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'
go
