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