/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S120038 Interface STD - Clientes
--Fecha                      : 06/07/2017
--Descripción del Problema   : Agregar campo estado santander
--Descripción de la Solución : Agregar campo estado santander
--Autor                      : Nelson Trujillo
--Instalador                 : 3_sta_alter_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

USE cobis
GO

print 'Creando campo ea_estado_std en cl_ente_aux'
go
if not exists (select 1 from syscolumns  
                where id = object_id('cl_ente_aux')
                  and name = 'ea_estado_std')
begin
   alter table cl_ente_aux
     add ea_estado_std varchar(10) null
end
go