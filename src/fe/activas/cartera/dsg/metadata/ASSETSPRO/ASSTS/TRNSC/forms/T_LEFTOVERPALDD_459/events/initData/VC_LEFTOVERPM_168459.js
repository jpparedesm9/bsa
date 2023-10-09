//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LeftoverPaymentsModal
    task.initData.VC_LEFTOVERPM_168459 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        var dialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        
        entities.LeftOverPayment.paymentType = dialogParameters.leftOverPayment.paymentType;
        entities.LeftOverPayment.value = dialogParameters.leftOverPayment.value;
        entities.LeftOverPayment.currencyType = dialogParameters.leftOverPayment.currencyType;
        entities.LeftOverPayment.reference = dialogParameters.leftOverPayment.reference;
        entities.LeftOverPayment.note = dialogParameters.leftOverPayment.note;
        
        customerCode = dialogParameters.customerCode;
        
    };