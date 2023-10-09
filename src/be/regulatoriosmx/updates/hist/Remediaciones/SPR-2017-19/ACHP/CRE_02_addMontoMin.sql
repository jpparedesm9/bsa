 --Cambios iniciales subido en Changeset 218824 successfully checked in.
/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : A�adir campo en cr_tramite
--Descripci�n del Problema   : se requiere guardar el monto minimo
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripci�n abajo
--Nombre Archivo             : Descripci�n abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_table.sql


USE cob_credito
GO

PRINT 'NUEVO CAMPO - tr_monto_min'
if not exists (select 1 from sysobjects tab, syscolumns col
                           where tab.id = col.id and tab.type = 'U'
                           and tab.name = 'cr_tramite' and col.name = 'tr_monto_min')
begin
      alter table cr_tramite add tr_monto_min money null
end
GO
