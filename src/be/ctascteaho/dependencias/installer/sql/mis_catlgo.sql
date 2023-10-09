

use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ( 'cl_direccion_ec', 'cl_rol','cl_riesgo', 'cl_area_oficina', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_estado_ser')
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cl_direccion_ec', 'cl_rol','cl_riesgo', 'cl_area_oficina', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_estado_ser')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cl_direccion_ec', 'cl_rol','cl_riesgo', 'cl_area_oficina', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_estado_ser')
go

----------------------------------------------------------------------------------------------
declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'
----------------------------------------------------------------------------------------------
 
select @w_codigo= @w_codigo + 1
print 'Tipo de Solicitud'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_direccion_ec', 'Direccion para estado de cuenta')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'C', 'ENVIAR A CASILLA POSTAL DEL CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'D', 'DIRECCION DE CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'R', 'RETENER EN SUCURSAL DEL BANCO', 'V')
----------------------------------------------------------------------------------------------

--PRO Catalogo de Roles para cuentas
select @w_codigo = @w_codigo + 1
print 'TABLAS DE CATALOGO ROLES '
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_rol', 'ROL PARA PRODUCTOS')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'T','TITULAR','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'F','FIRMA AUTORIZADA','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'C','TITULAR SECUNDARIO','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'U','TUTOR','V')

----------------------------------------------------------------------------------------------

select @w_codigo = @w_codigo + 1
print 'TABLAS DE CATALOGO NIVEL RIESGO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_riesgo', 'Nivel de riesgo del cliente')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'A', 'ALTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'M', 'MEDIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'B', 'BAJO', 'V')

----------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'AREA OFICINA'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_area_oficina', 'Área Oficina')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'BCO', 'BANCO COBIS', 'V')
----------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Tipo de Horario'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_tipo_horario', 'Tipo de Horario')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'C', 'CONTINUO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'D', 'DISCONTINUO', 'V')
----------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Sector geográfico'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_sector_geografico', 'Sector geográfico')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'R', 'RURAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'U', 'URBANO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'P', 'PERIURBANO', 'V')
----------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Estados de Registros'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_estado_ser', 'Estados de Registros')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'B', 'Bloqueado',	'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'C', 'Cancelado', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'E', 'Eliminado', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'V', 'Vigente', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'X', 'Producto Deshabilitado', 'V')
----------------------------------------------------------------------------------------------
update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

 go

