/*************************************************************************************/
--No Historia                : MEJ-95505
--Titulo de la Historia      : Mejora interfaz ODS - área contable
--Fecha                      : 19/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Eliminar campos os_cod_area_cont, os_des_area_cont en cob_conta_super..sb_ods_saldos_cont
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cbsup_table.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/RegulatoriosMX/BackEnd/spsql
/*************************************************************************************/
use cob_conta_super
go 

if exists(select 1 from sysobjects o, syscolumns c
          where o.id = c.id
          and   o.name = 'sb_ods_saldos_cont'
          and   c.name = 'os_cod_area_cont')
   alter table cob_conta_super..sb_ods_saldos_cont drop column os_cod_area_cont
go

if exists(select 1 from sysobjects o, syscolumns c
          where o.id = c.id
          and   o.name = 'sb_ods_saldos_cont'
          and   c.name = 'os_des_area_cont')
   alter table cob_conta_super..sb_ods_saldos_cont drop column os_des_area_cont
go

