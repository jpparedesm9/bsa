
-- Autor: Walther Toledo
-- Fecha: 02/Mar/2023
-- Req. 193221
-- Instalador: \src\be\clientes\installer\sql\cl_catalogo.sql
use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CLI'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ( 'cl_actividad_profesional','cl_recursos_credito'  )
go

--/////////////////////////////
delete cl_catalogo
  from cl_tabla
 where cl_tabla.codigo = cl_catalogo.tabla
  and cl_tabla.tabla in  (  'cl_actividad_profesional','cl_recursos_credito'   )

--/////////////////////////////
delete cl_tabla                          
 where cl_tabla.tabla in    (  'cl_actividad_profesional','cl_recursos_credito'  )
go


use cobis
go
------------------------------------
-- catalogo: cl_actividad_profesional
------------------------------------  
print 'cl_actividad_profesional'
declare @w_id_table int, @w_catalog_name varchar(64)
select @w_catalog_name = 'cl_actividad_profesional'

-- Insert
select @w_id_table = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_id_table, @w_catalog_name, 'Actividad Profesional')
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('CLI', @w_id_table)

insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '000', 'NINGUNA', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '001', 'JUEGOS CON APUESTA, CONCURSOS Y SORTEOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '002', 'COMPRAVENTA DE INMUEBLES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '003', 'SERVICIOS DE FE PÚBLICA (NOTARIOS Y CORREDORES)', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '004', 'INTERCAMBIO DE ACTIVOS VIRTUALES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '005', 'BLINDAJE DE VEHÍCULOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '006', 'PRÉSTAMOS NO FINANCIEROS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '007', 'JOYERÍA, METALES, PIEDRAS PRECIOSAS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '008', 'ARRENDAMIENTO DE INMUEBLES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '009', 'TARJETAS DE SERVICIOS, CRÉDITO O PREPAGADAS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '010', 'PRESTACIÓN DE SERVICIOS PROFESIONALES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '011', 'RECEPCIÓN DE DONATIVOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '012', 'COMERCIALIZACIÓN DE VEHÍCULOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '013', 'TRASLADO DE VALORES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '014', 'EMISIÓN DE CHEQUES DE VIAJERO', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '015', 'COMERCIALIZACIÓN Y SUBASTA DE OBRAS DE ARTE', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '016', 'SERVICIOS DE AGENTES O APODERADOS ADUANALES', 'V')

update cobis..cl_seqnos set siguiente = @w_id_table where tabla = 'cl_tabla'
go


------------------------------------
-- catalogo: cl_recursos_credito
------------------------------------  
print 'cl_recursos_credito'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cl_recursos_credito','Recursos Pago Credito')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'NP','NEGOCIO PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'SP','SALARIO O PENSIÓN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AS','BECA O APOYO SOCIAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AI','AHORRO E INVERSIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PR','PRÉSTAMOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RT','RECURSOS DE TERCERO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RF','RECURSOS DE FAMILIARES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RB','RENTA DE BIENES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'VB','VENTA DE BIENES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'HE','HERENCIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PS','PREMIOS O SORTEOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'OT','OTROS','V')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'TE','TERCEROS','E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AF','APOYO FAMILIAR','E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ED','ENVIO DE DINERO','E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PE','PENSION','E')

update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'

go
