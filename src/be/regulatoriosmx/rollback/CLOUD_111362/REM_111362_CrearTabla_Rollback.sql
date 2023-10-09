/***********************************************************************/
--No Bug: 111362 
--Título del Bug: eliminar campos en tabla sb_riesgo_hrc
--Fecha:2019-01-15
--Descripción del Problema:
--eliminar nuevos campos del reporte
--Descripción de la Solución: eliminar campos
--Autor:MTA
/***********************************************************************/
--ROLLBACK
use cob_conta_super
go

--rh_num_hijas
if  exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_riesgo_hrc'
          and   obj.id = col.id
          and   col.name = 'rh_num_hijas')
begin
alter table sb_riesgo_hrc
   DROP COLUMN rh_num_hijas 
end
go
--rh_integrantes_grupo
if  exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_riesgo_hrc'
          and   obj.id = col.id
          and   col.name = 'rh_integrantes_grupo')
begin
alter table sb_riesgo_hrc
   DROP COLUMN rh_integrantes_grupo 
end
go

--rh_ciclo_individual
if  exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_riesgo_hrc'
          and   obj.id = col.id
          and   col.name = 'rh_ciclo_individual')
begin
alter table sb_riesgo_hrc
   DROP COLUMN rh_ciclo_individual  
end
go
--rh_ciclo_grupal
if  exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_riesgo_hrc'
          and   obj.id = col.id
          and   col.name = 'rh_ciclo_grupal')
begin
alter table sb_riesgo_hrc
   DROP COLUMN rh_ciclo_grupal 
end
go


