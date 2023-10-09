/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S119702 Reporte de Bur�.
--Descripci�n del Problema   : Elimnacion de parametros
--Responsable                : Walther Toledo
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/RegulatoriosMX/BackEnd/sql/
--Nombre Archivo             : cb_parametria.sql
/*----------------------------------------------------------------------------------------------------------------*/
use cob_conta
go

delete cb_listado_reportes_reg where lr_reporte in ('INTFBU','INTFFC') and lr_estado = 'V'

go

