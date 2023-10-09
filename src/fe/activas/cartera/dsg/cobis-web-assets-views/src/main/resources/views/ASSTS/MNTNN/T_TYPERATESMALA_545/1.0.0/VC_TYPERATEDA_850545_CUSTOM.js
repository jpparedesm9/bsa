/* variables locales de T_TYPERATESMALA_545*/
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

    
        var task = designerEvents.api.typeratesmodal;
    

    //"TaskId": "T_TYPERATESMALA_545"

    // (Button) 
    task.executeCommand.CM_TTYPERAT_MET = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelButton = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
    };

// (Button) 
    task.executeCommand.CM_TTYPERAT_R0N = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to callBack event to CM_TTYPERAT_R0N
    task.executeCommandCallback.CM_TTYPERAT_R0N = function(entities, executeCommandEventArgs) {
        //here your code
        var aceptButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(aceptButton);
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TypeRatesModal
    task.initData.VC_TYPERATEDA_850545 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        if (entities.TypeRates.ratePit == null || entities.TypeRates.ratePit == '')
            entities.TypeRates.ratePit = 'N';
        
        if (entities.TypeRates.clase == null || entities.TypeRates.clase == '')
            entities.TypeRates.clase = 'F';
    };



}));