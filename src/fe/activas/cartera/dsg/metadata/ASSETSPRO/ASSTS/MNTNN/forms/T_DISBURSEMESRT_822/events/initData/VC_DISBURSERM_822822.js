//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DisbursementReportsForm
task.initData.VC_DISBURSERM_822822 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    
    entities.DisbursementReports.settlementSheet = false;
    entities.DisbursementReports.groupStatement = false;
    entities.DisbursementReports.consolidatedAccount = false;
    entities.DisbursementReports.disbursementOrder = false;
    entities.DisbursementReports.groupAmortizationTable = false;
};