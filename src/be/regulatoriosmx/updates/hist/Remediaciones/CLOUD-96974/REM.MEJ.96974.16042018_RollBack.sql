/*************************************************************************************/
--No Historia                : MEJ-96974
--Titulo de la Historia      : CORREGIR DATA INCONSISTENTE GRUPO 15,153, 3 (RollBack)
--Fecha                      : 13/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : CORREGIR DATA INCONSISTENTE GRUPO 15,153,3 (RollBack)
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
declare @w_grupo     int

print'Informacion Actual Grupos ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo in (15,153,3)

select *
from cobis..cl_cliente_grupo
where cg_grupo in (15,153,3)

select *
from cob_credito..cr_tramite_grupal
where tg_grupo in (15,153,3)

print'Restaurando Informacion Grupos ' + cast(@w_grupo as varchar)
insert into cob_cartera..ca_det_ciclo
select * from cob_cartera..ca_det_ciclo_96974

insert into cobis..cl_cliente_grupo
select * from cobis..cl_cliente_grupo_96974

insert into cob_credito..cr_tramite_grupal
select * from cob_credito..cr_tramite_grupal_96974

print'Informacion Actualizada Grupos ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo in (15,153,3)

select *
from cobis..cl_cliente_grupo
where cg_grupo in (15,153,3)

select *
from cob_credito..cr_tramite_grupal
where tg_grupo in (15,153,3)
go

/*************************************************************************************/
--No Historia                : MEJ-96974
--Titulo de la Historia      : CORREGIR DATA INCONSISTENTE GRUPO 15
--Fecha                      : 13/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : CORREGIR DATA INCONSISTENTE GRUPO 15
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
print'Eliminacion Estructuras Respaldo Informacion'
drop table cob_cartera..ca_det_ciclo_96974
drop table cobis..cl_cliente_grupo_96974
drop table cob_credito..cr_tramite_grupal_96974
go

