/***********************************************************************/
--No Bug: 111362
--T�tulo del Bug: crear campos en tabla sb_riesgo_hrc
--Fecha:2019-01-15
--Descripci�n del Problema:
--crear nuevos campos del reporte
--Descripci�n de la Soluci�n: crear campos
--Autor:MTA
/***********************************************************************/

use cob_conta_super
go

--rh_integrantes_grupo
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_riesgo_hrc'
          and   obj.id = col.id
          and   col.name = 'rh_integrantes_grupo')
begin
alter table sb_riesgo_hrc
   add rh_integrantes_grupo   varchar(10)  null
end
go
--rh_ciclo_individual
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_riesgo_hrc'
          and   obj.id = col.id
          and   col.name = 'rh_ciclo_individual')
begin
alter table sb_riesgo_hrc
   add rh_ciclo_individual  varchar(10)  null
end
go
--rh_ciclo_grupal
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_riesgo_hrc'
          and   obj.id = col.id
          and   col.name = 'rh_ciclo_grupal')
begin
alter table sb_riesgo_hrc
   add rh_ciclo_grupal  varchar(10)  null
end
go


