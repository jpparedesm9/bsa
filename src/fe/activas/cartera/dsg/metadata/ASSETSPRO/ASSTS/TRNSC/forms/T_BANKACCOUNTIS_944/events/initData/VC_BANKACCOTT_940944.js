//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BankAccountsListForm
    task.initData.VC_BANKACCOTT_940944 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var dialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        
        entities.Payment.customerID = dialogParameters.customerID;
        entities.Payment.paymentType = dialogParameters.paymentType;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };