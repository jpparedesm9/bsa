
/**********************************************************************************************************************/
--No Bug                       : NA
--Titulo de la Historia        : CGS-R127478 Resultado Tecnologico - Clientes
--Fecha                        : 14/08/2017
--Descripcion del Problema     : No existe campo nuevo en la tabla
--Descripcion de la Solucion   : Crear scripts de insercion de campo
--Autor                        : Paul Ortiz Vera
/**********************************************************************************************************************/


---------------------------------------------------------------------------------------
-------------------------- Crear tabla de  validar secciones --------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go


IF OBJECT_ID ('dbo.cl_seccion_validar') IS NOT NULL
	DROP TABLE dbo.cl_seccion_validar
GO

CREATE TABLE dbo.cl_seccion_validar
	(
	sv_ente               int not null,
	sv_seccion            catalogo null,
	sv_completado         char(1) null
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_seccion_validar_Key
	ON dbo.cl_seccion_validar (sv_ente, sv_seccion)
GO



--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : 8_sta_error.sql


use cobis
go
delete cobis..cl_errores
where numero in (103149,103150,103151)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103149, 0, ' No existe el registro que desea actualizar ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103150, 0, ' Error al actualizar la seccion del cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103151, 0, ' Error al actualizar Prospecto a Cliente ')

go


--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : 4_sta_catalogo.sql


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_modulo_cliente')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_modulo_cliente')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_modulo_cliente')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_modulo_cliente', 'Modulos de Clientes')

--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1', 'INFORMACION GENERAL', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '2', 'DIRECCIONES Y CORREO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '3', 'NEGOCIOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '4', 'REFERENCIAS', 'V', NULL, NULL, NULL)


-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_modulo_cliente')
go



---------------------------------------------------------------------------------------
--------------------------Crear tabla de dispositivos móviles--------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'ea_tecnologico' AND TABLE_NAME = 'cl_ente_aux')
BEGIN
    ALTER TABLE cobis..cl_ente_aux ADD ea_tecnologico char(10) NULL 
END
else
begin
 ALTER TABLE cobis..cl_ente_aux ALTER COLUMN ea_tecnologico char(10) NULL 
end


---------------------------------------------------------------------------------------
--------------------------  Crear Nuevos registros en tabla  --------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_datosini.sql
use cob_credito
go

delete cr_pregunta_ver_dat
go
insert into cr_pregunta_ver_dat values ('G' ,1 ,'Los ingresos mensuales son de: #SUELDO#')
insert into cr_pregunta_ver_dat values ('G' ,2 ,'Los gastos mensuales son de: #GASTOS#')
insert into cr_pregunta_ver_dat values ('G' ,3 ,'El grupo se llama: #NOM_GRUPO#')
insert into cr_pregunta_ver_dat values ('G' ,4 ,'¿En caso de que no pague algun miembro esta dispuesto  hacer el pago solidario?')
insert into cr_pregunta_ver_dat values ('G' ,5 ,'El nombre de el/la Sr/Sra presidente/a es: #PRESIDENTE#')
insert into cr_pregunta_ver_dat values ('G' ,6 ,'La dirección del  Señor o Señora #NOM_CLIENTE# es: #DIRECCION#?')
insert into cr_pregunta_ver_dat values ('G' ,7 ,'¿Usted sabe cuanto tiempo lleva viviendo el/la Sr/Sra #NOM_CLIENTE#  en la direccion #DIRECCION#? Tiempo: #TIEMPO_VIV#')
insert into cr_pregunta_ver_dat values ('G' ,8 ,'¿Conoce a que se dedica el/la Sr/Sra #NOM_CLIENTE#? Actividad: #ACTIVIDAD#')
insert into cr_pregunta_ver_dat values ('G' ,9,'"Usted sabe si el/la Sr/Sra  #NOM_CLIENTE# trabaja en el comercio #COMERCIO#')
insert into cr_pregunta_ver_dat values ('G' ,10,'Usted sabe  si el/la  Sr/Sra #NOM_CLIENTE# es dueño(a) del comercio')
insert into cr_pregunta_ver_dat values ('G' ,11,'Conoce  cuanto tiempo lleva el/la Sr/Sra #NOM_CLIENTE# laborando en el comercio #COMERCIO#? Tiempo: #TIEMPO_TR#')
insert into cr_pregunta_ver_dat values ('G' ,12,'¿El local es #LOCAL#?')
insert into cr_pregunta_ver_dat values ('G' ,13, '¿Tiene Correo electrónico?')
insert into cr_pregunta_ver_dat values ('G' ,14, '¿Con que frecuencia utiliza su correo electrónico?')
insert into cr_pregunta_ver_dat values ('G' ,15, '¿Tienes Redes sociales?')
insert into cr_pregunta_ver_dat values ('G' ,16, 'Tipo de celular')
insert into cr_pregunta_ver_dat values ('G' ,17, '¿Cómo paga su teléfono?')
--Individual
insert into cr_pregunta_ver_dat values ('I' ,1 ,'Los ingresos mensuales son de: #SUELDO#')
insert into cr_pregunta_ver_dat values ('I' ,2 ,'Los gastos mensuales son de: #GASTOS#')
insert into cr_pregunta_ver_dat values ('I' ,3 ,'La dirección del  Señor o Señora #NOM_CLIENTE# es: #DIRECCION#?')
insert into cr_pregunta_ver_dat values ('I' ,4 ,'¿Usted sabe cuanto tiempo lleva viviendo el/la Sr/Sra #NOM_CLIENTE#  en la direccion #DIRECCION#? Tiempo: #TIEMPO_VIV#')
insert into cr_pregunta_ver_dat values ('I' ,5 ,'¿Conoce a que se dedica el/la Sr/Sra #NOM_CLIENTE#? Actividad: #ACTIVIDAD#')
insert into cr_pregunta_ver_dat values ('I' ,6,'"Usted sabe si el/la Sr/Sra  #NOM_CLIENTE# trabaja en el comercio #COMERCIO#')
insert into cr_pregunta_ver_dat values ('I' ,7,'Usted sabe  si el/la  Sr/Sra #NOM_CLIENTE# es dueño(a) del comercio')
insert into cr_pregunta_ver_dat values ('I' ,8,'Conoce  cuanto tiempo lleva el/la Sr/Sra #NOM_CLIENTE# laborando en el comercio #COMERCIO#? Tiempo: #TIEMPO_TR#')
insert into cr_pregunta_ver_dat values ('I' ,9,'¿El local es #LOCAL#?')
insert into cr_pregunta_ver_dat values ('I', 10, '¿Tiene Correo electrónico?')
insert into cr_pregunta_ver_dat values ('I', 11, '¿Con que frecuencia utiliza su correo electrónico?')
insert into cr_pregunta_ver_dat values ('I', 12, '¿Tienes Redes sociales?')
insert into cr_pregunta_ver_dat values ('I', 13, 'Tipo de celular')
insert into cr_pregunta_ver_dat values ('I', 14, '¿Cómo paga su teléfono?')

go

