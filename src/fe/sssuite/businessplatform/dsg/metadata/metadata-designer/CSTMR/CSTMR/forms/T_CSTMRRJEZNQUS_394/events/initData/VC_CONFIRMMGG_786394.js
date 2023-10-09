//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ConfirmMessage
    task.initData.VC_CONFIRMMGG_786394 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        let customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        let mMessage = customDialogParameters.mMessage;
        entities.Message.mMessage = mMessage;
        
    };