/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : N/A
--Fecha                      : 27/11/2017
--Descripci�n del Problema   : Agregar parametros a la pantalla de Prospectos
--Descripci�n de la Soluci�n : Agregar parametros a la pantalla de Prospectos
--Autor                      : MARIA JOSE TACO
--SQL                        : $/COB/Desarrollos/DEV_SaaSMX/Basicas/BackendBasicas/Admin/sql/ad_ins.sql
/**********************************************************************************************************************/

use cobis
go

--PARAMETRO RECUPERADO DE SSS DE FECHA DE EXPIRACION PARA PANTALLA DE MANTENIMIENTO DE PERSONAS
delete from cobis..cl_parametro 
where pa_producto = 'ADM' and pa_nemonico in ('MDE') 
go
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('MDE', 'MAYORIA DE EDAD', 'T',20 , 'ADM')

go

