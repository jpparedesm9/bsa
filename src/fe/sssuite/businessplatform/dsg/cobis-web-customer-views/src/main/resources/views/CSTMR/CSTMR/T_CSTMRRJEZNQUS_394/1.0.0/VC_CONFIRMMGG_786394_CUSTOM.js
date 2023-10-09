/* variables locales de T_CSTMRRJEZNQUS_394*/
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

    
        var task = designerEvents.api.confirmmessage;
    

    //"TaskId": "T_CSTMRRJEZNQUS_394"


    // (Button) 
    task.executeCommand.CM_TCSTMRRJ_0_S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var result = {option:2};
        executeCommandEventArgs.commons.api.vc.closeModal(result);
        
    };

// (Button) 
    task.executeCommand.CM_TCSTMRRJ_R4Q = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var result = {option:1};
        executeCommandEventArgs.commons.api.vc.closeModal(result);
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ConfirmMessage
    task.initData.VC_CONFIRMMGG_786394 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        let customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        let mMessage = customDialogParameters.mMessage;
        entities.Message.mMessage = mMessage;
        
    };



}));