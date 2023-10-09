/* variables locales de T_NEGOTIATIOTML_700*/
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

    
        var task = designerEvents.api.negotiationpaymentsmodal;
    

    //"TaskId": "T_NEGOTIATIOTML_700"

    // (Button) 
    task.executeCommand.CM_TNEGOTIA_2A4 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        executeCommandEventArgs.commons.api.navigation.closeModal(entities.Negotiation);
        
    };

// (Button) 
    task.executeCommand.CM_TNEGOTIA_6T_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        var cancelButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
        
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: NegotiationPaymentsModal
    task.initData.VC_NEGOTIATOO_775700 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        var dialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        
        entities.Negotiation.paymentType = dialogParameters.negotiation.paymentType;
        entities.Negotiation.interestType = dialogParameters.negotiation.interestType;
        entities.Negotiation.fullFee = dialogParameters.negotiation.fullFee;
        entities.Negotiation.additionalPayments = dialogParameters.negotiation.additionalPayments;
        
    };



}));