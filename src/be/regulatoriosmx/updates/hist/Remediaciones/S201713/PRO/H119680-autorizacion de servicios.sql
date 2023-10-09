/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S119680 Impresión de documentos - Documentos (3) - Flujo Grupal
--Fecha                      : 06/07/2017
--Descripción del Problema   :
--Descripción de la Solución : Autorizac servicios
--Autor                      : Pedro Romero
--Instalador                 : cl_services_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/


    use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'LoanGroup.GroupLoanQuerys.LoanGroupQuery')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.loangroup.service.IGroupLoanQuerys', csc_method_name = 'loanGroupQuery', csc_description = '', csc_trn = 21821 WHERE csc_service_id = 'LoanGroup.GroupLoanQuerys.LoanGroupQuery'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('LoanGroup.GroupLoanQuerys.LoanGroupQuery', 'cobiscorp.ecobis.loangroup.service.IGroupLoanQuerys', 'loanGroupQuery', '', 21821)
      GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.loangroup.service.IGroupLoanQuerys', csc_method_name = 'loanGroupMembersAmounts', csc_description = '', csc_trn = 21821 WHERE csc_service_id = 'LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts', 'cobiscorp.ecobis.loangroup.service.IGroupLoanQuerys', 'loanGroupMembersAmounts', '', 21821)
      GO
    