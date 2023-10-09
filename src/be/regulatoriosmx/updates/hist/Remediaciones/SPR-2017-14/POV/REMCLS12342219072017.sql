/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S123422 Cuestionario Verificación de Datos - Flujo Individual
--Fecha                      : 18/07/2017
--Descripción del Problema   : Pantalla de Cuestionario en creditos individuales
--Descripción de la Solución : Agregar Modificaciones necesarias para integrar pantalla
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

-----------------------------------------------
--- MODIFICAR TABLA cr_pregunta_ver_dat
-----------------------------------------------
--Instalador                 : cr_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql

use cob_credito
go

IF OBJECT_ID ('dbo.cr_pregunta_ver_dat') IS NOT NULL
    DROP TABLE dbo.cr_pregunta_ver_dat
GO

CREATE TABLE dbo.cr_pregunta_ver_dat (
      pr_tipo           char(1) NOT NULL,
	  pr_codigo         INT NOT NULL,
      pr_descripcion    varchar(1000) NOT NULL
    )
GO

ALTER TABLE cr_pregunta_ver_dat ADD CONSTRAINT pk_pr_codigo
PRIMARY KEY (pr_tipo, pr_codigo)
GO

-----------------------------------------------
--- Ingresar preguntas TABLA cr_tipo_oficina
-----------------------------------------------
--Instalador                 : cr_datosini.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql


use cob_credito
go

delete cob_credito..cr_tipo_oficina
 where  to_oficina = 1
go

insert into cob_credito..cr_tipo_oficina
values (1,'CASA MATRIZ','N')
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
go
