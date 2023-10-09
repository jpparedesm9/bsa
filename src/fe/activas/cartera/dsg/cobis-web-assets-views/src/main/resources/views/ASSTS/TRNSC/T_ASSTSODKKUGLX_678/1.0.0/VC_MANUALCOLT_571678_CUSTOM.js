/* variables locales de T_ASSTSODKKUGLX_678*/
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

    
        var task = designerEvents.api.manualconciliation;
    

    //"TaskId": "T_ASSTSODKKUGLX_678"


    // (Button) 
    task.executeCommand.CM_TASSTSOD_AT8 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.serverParameters.ConciliationSearch = true;
    };

//Start signature to Callback event to CM_TASSTSOD_AT8
task.executeCommandCallback.CM_TASSTSOD_AT8 = function (entities, executeCommandCallbackEventArgs) {

    if (executeCommandCallbackEventArgs.success) {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("ASSTS.MSG_ASSTS_SEDEBERZE_11976", '', 2000, false);
        entities.ConciliationSearch.conciliate = true;
        var result = {conciliationSearch: entities.ConciliationSearch };
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);

    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ManualConciliation
task.initData.VC_MANUALCOLT_571678 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;

    var commons = initDataEventArgs.commons;
    var api = initDataEventArgs.commons.api;
    var parameters = api.navigation.getCustomDialogParameters();
    var conciliationDate = cobis.containerScope.preferences.processDate;

    entities.ConciliationSearch = parameters.conciliationSearch;
    if (conciliationDate != null && conciliationDate != undefined) {
        var parts = conciliationDate.split("/");
        var d1 = new Date(Number(parts[2]), Number(parts[0]) - 1, Number(parts[1]));
        entities.ConciliationSearch.conciliationDate = d1;
    }
    entities.ConciliationSearch.conciliationUser= cobis.userContext.getValue(cobis.constant.USER_NAME);

    switch (entities.ConciliationSearch.type) {
    case 'I':
        if (entities.ConciliationSearch.notConciliationReason == 'NR') {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_REVERSAPA_99657');
            entities.ConciliationSearch.operation = 'R';
        } else {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_APLICAROA_80830');
            entities.ConciliationSearch.operation = 'P';
        }

        break;
    case 'G':
        if (entities.ConciliationSearch.notConciliationReason == 'NR') {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_ANULARGTA_91633');
            entities.ConciliationSearch.operation = 'R';
        } else {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_REGISTRAA_30892');
            entities.ConciliationSearch.operation = 'P';
        }

        break;
    case 'P':
        if (entities.ConciliationSearch.notConciliationReason == 'NR') {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_REVERSAPA_99657');
            entities.ConciliationSearch.operation = 'R';
        } else {
            initDataEventArgs.commons.api.viewState.label("CM_TASSTSOD_AT8", 'ASSTS.LBL_ASSTS_APLICAROA_80830');
            entities.ConciliationSearch.operation = 'P';
        }

        break;
    default:
        break;
    }

};



}));