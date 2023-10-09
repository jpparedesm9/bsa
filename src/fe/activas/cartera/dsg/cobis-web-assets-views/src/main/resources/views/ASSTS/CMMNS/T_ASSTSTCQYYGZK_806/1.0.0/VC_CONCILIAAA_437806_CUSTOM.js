/* variables locales de T_ASSTSTCQYYGZK_806*/
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

    
        var task = designerEvents.api.conciliationmanualobservationmodal;
    

    //"TaskId": "T_ASSTSTCQYYGZK_806"


    // (Button) 
    task.executeCommand.CM_TASSTSTC_82_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelObservation = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelObservation);
        
    };

// (Button) 
    task.executeCommand.CM_TASSTSTC_SSA = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        var observation = entities.ConciliationManualSearchFilter.observation; 
           
        executeCommandEventArgs.commons.api.navigation.closeModal(observation);
    };



}));