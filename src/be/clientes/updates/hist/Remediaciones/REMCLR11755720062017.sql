/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-R117557 Modificaciones - Demo 1
--Fecha                      : 20/06/2017
--Descripción del Problema   :  No existe el servicio, agregado y modificación de catalogos
--Descripción de la Solución :  Agregar el servicio
--Autor                      : Paúl Ortiz Vera
--Instalador                 : cl_services_authorization.sql    -      4_sta_catalogo.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

-- Creacion de nuevo campo

use cobis
go


IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'nc_destino_credito' AND TABLE_NAME = 'cl_negocio_cliente')
BEGIN
    ALTER TABLE cl_negocio_cliente ADD nc_destino_credito varchar(10) null
END


--Modificacion de Catalogos


use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'MIS'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('cl_ecivil', 'cl_nivel_estudio', 'cl_profesion', 'cl_fuente_ingreso', 'cl_parentesco')
go

--/////////////////////////////
delete cl_catalogo
  from cl_tabla
 where cl_tabla.codigo = cl_catalogo.tabla
  and cl_tabla.tabla in  ('cl_ecivil', 'cl_nivel_estudio', 'cl_profesion', 'cl_fuente_ingreso', 'cl_recursos_credito', 'cl_parentesco', 'cl_tpropiedad', 'cl_destino_credito')
--/////////////////////////////
delete cl_tabla                          
 where cl_tabla.tabla in ('cl_ecivil', 'cl_nivel_estudio', 'cl_profesion', 'cl_fuente_ingreso', 'cl_recursos_credito', 'cl_parentesco', 'cl_tpropiedad', 'cl_destino_credito')
go



declare @w_codigo smallint

select @w_codigo = isnull(max(codigo),0) + 1
from cl_tabla


------------------------------------
-- catalogo: cl_ecivil
------------------------------------  

print 'Estado Civil'
insert into cl_tabla values (@w_codigo, 'cl_ecivil', 'Estado Civil')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'SO', 'SOLTERO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'CA', 'CASADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'DI', 'DIVORCIADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'VI', 'VIUDO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'UN', 'UNION LIBRE','V')


------------------------------------
-- catalogo: cl_nivel_estudio
------------------------------------  

select @w_codigo = @w_codigo + 1

print 'Nivel de Estudios'
insert into cl_tabla values (@w_codigo, 'cl_nivel_estudio', 'Nivel de Estudios')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '001', 'PRIMARIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '002', 'SECUNDARIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '003', 'PREPARATORIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '004', 'TECNICA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '005', 'PROFESIONAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '006', 'SIN ESTUDIOS','V')


------------------------------------
-- catalogo: cl_profesion
------------------------------------  

select @w_codigo = @w_codigo + 1

print 'Profesiones'
insert into cl_tabla values (@w_codigo, 'cl_profesion', 'Profesiones')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '000', 'HOGAR','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '001', 'COMERCIANTE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '002', 'EMPRESARIO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '003', 'JUBILADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '004', 'DESEMPLEADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '005', 'ASALARIADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '006', 'ESTUDIANTE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '007', 'OTRO','V')


------------------------------------
-- catalogo: cl_parentesco
------------------------------------  

select @w_codigo = @w_codigo + 1

print 'Nexo con el Cliente'
insert into cl_tabla values (@w_codigo, 'cl_parentesco', 'Nexo con el Cliente')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'AB', 'ABUELO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'AM', 'AMIGO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'CU', 'CUNADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'HE', 'HERMANO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'HI', 'HIJO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'MA', 'MADRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'PA', 'PADRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'PR', 'PRIMO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'SO', 'SOBRINO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'SU', 'SUEGRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'TI', 'TIO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'YE', 'YERNO','V')
go


------------------------------------
-- catalogo: cl_fuente_ingreso
------------------------------------  
print 'cl_fuente_ingreso'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cl_fuente_ingreso','Fuentes de Ingreso')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'EM','EMPLEO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'TE','TERCEROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RE','REMESAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'OT','OTROS','V')
go


------------------------------------
-- catalogo: cl_recursos_credito
------------------------------------  
print 'cl_recursos_credito'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cl_recursos_credito','Recursos Pago Credito')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'NP','NEGOCIO PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'TE','TERCEROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ED','ENVIO DE DINERO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AF','APOYO FAMILIAR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PE','PENSION','V')
go




------------------------------------
-- catalogo: cl_tpropiedad
------------------------------------  
print 'cl_tpropiedad'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_tpropiedad','Tipo de Propiedad')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PRO','PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'REN','RENTADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'FAM','DE FAMILIARES','V')
go


------------------------------------
-- catalogo: cl_destino_credito
------------------------------------  
print 'cl_destino_credito'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_destino_credito','Destino del Credito')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CA','COMPRA DE ACTIVO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CT','CAPITAL DE TRABAJO','V')


------------------------------------------------
-- Actualizacion secuencial tabla de catalogos
------------------------------------------------
update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in (
	'cl_ecivil', 
	'cl_nivel_estudio', 
	'cl_profesion', 
	'cl_fuente_ingreso', 
	'cl_recursos_credito', 
	'cl_parentesco', 
	'cl_tpropiedad', 
	'cl_destino_credito'
   )
go

