/* variables locales de T_ASSTSLBVYTVMM_226*/
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

    
        var task = designerEvents.api.detailfund;
    

    //"TaskId": "T_ASSTSLBVYTVMM_226"

    // (Button) 
    task.executeCommand.VA_VABUTTONDADPYML_171140 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters. = true;
    };

//Start signature to Callback event to CM_TCHANGEV_742
task.executeCommandCallback.VA_VABUTTONDADPYML_171140 = function(entities, executeCommandCallbackEventArgs) {
    
    executeCommandCallbackEventArgs.commons.execServer = false;
    if(executeCommandCallbackEventArgs.success){
    var api = executeCommandCallbackEventArgs.commons.api;
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(true); 
    }
};

// (Button) 
    task.executeCommand.VA_VABUTTONZINTBLA_711140 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    executeCommandEventArgs.commons.api.vc.closeModal(true); 
        
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DetailFund
    task.initData.VC_DETAILFUND_362226 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        var viewState = initDataEventArgs.commons.api.viewState;
        var Fund = entities.Fund;
        if (Fund.fundId!= undefined && Fund.fundId!=0){
            viewState.disable('Spacer1378', true);
            viewState.disable('VA_9399ORKREIOLNBV_331140', true);
        }else{
            Fund.statusCode = 'V';
            viewState.disable('VA_STATUSCODEVOWGL_831140', true);
            
        }
            
    };



}));