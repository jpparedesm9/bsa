//Entity: DisbursementReports
    //DisbursementReports. (Button) View: DisbursementReportsForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONHARFPAM_587245 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    if(entities.DisbursementReports.settlementSheet == false && entities.DisbursementReports.groupStatement == false && entities.DisbursementReports.consolidatedAccount == false && entities.DisbursementReports.disbursementOrder == false && entities.DisbursementReports.groupAmortizationTable == false){
        executeCommandEventArgs.commons.messageHandler.showMessagesError('Debe seleccionar por lo menos un reporte',null,5000);
    }
    
    if(entities.DisbursementReports.settlementSheet == true){
        var params = [['report.module','cartera'],['report.name','hojaLiquidacion' ],['numBanco', entities.DisbursementReports.code]];
        ASSETS.Utils.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_LIQUI');
    }
    if(entities.DisbursementReports.groupStatement == true){
        var params = [['report.module','cartera'],['report.name', 'estadoCuentaGrupal' ],['numBanco', entities.DisbursementReports.code]];
        ASSETS.Utils.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_CNTAGRUPAL');
    }
    if(entities.DisbursementReports.consolidatedAccount == true){
        var params = [['report.module','cartera'],['report.name', 'estadoCuentaConsolidado' ],['numBanco', entities.DisbursementReports.code]];
        ASSETS.Utils.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_CNTCONSOLI');
    }
    if(entities.DisbursementReports.disbursementOrder == true){
        var params = [['report.module','cartera'],['report.name', 'ordenDesembolso'],['numBanco', entities.DisbursementReports.code]];
        ASSETS.Utils.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_ORDNDESEM');
    }
    if(entities.DisbursementReports.groupAmortizationTable == true){
        var params = [['report.module','cartera'],['report.name', 'tablaAmortizacion' ],['numBanco', entities.DisbursementReports.code]];
        ASSETS.Utils.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_TBLAMORTIZA');
    }
        
    };