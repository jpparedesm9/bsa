/* variables locales de T_DISBURSEMESRT_822*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.disbursementreportsform;
    

    //"TaskId": "T_DISBURSEMESRT_822"


    //Entity: DisbursementReports
    //DisbursementReports. (Button) View: DisbursementReportsForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONHARFPAM_587245 = function(  entities, executeCommandEventArgs ) {
    
    executeCommandEventArgs.commons.execServer = true;
    
    
    
    
    
};

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

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: DisbursementReportsForm
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;    
    entities.DisbursementReports.code = onCloseModalEventArgs.result.resultArgs.code;
};

//Entity: DisbursementReports
//DisbursementReports.code (TextInputButton) View: DisbursementReportsForm
task.textInputButtonEvent.VA_CODEIFTEIURYYBF_915245 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = 'B\u00FAsqueda de Operaciones Grupales';
    nav.address = {
        moduleId: 'ASSTS'
        , subModuleId: 'CMMNS'
        , taskId: 'T_ASSTSDOHFZMES_451'
        , taskVersion: '1.0.0'
        , viewContainerId: 'VC_LOANSEARUG_773451'
    };
    nav.queryParameters = {
        mode: 1
    };
    nav.modalProperties = {
        size: 'lg'
        , callFromGrid: false
    };
};

//Entity: DisbursementReports
    //DisbursementReports.code (TextInputButton) View: DisbursementReportsForm
    
    task.textInputButtonEventGrid.VA_CODEIFTEIURYYBF_915245 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };



}));