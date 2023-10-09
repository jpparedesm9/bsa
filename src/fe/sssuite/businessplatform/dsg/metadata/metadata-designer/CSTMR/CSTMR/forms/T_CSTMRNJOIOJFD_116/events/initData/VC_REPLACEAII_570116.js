//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: replaceAltairAccount
    task.initData.VC_REPLACEAII_570116 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.AltairAccount.personSecuential = initDataEventArgs.commons.api.parentVc.customDialogParameters.personSecuential;
        entities.AltairAccount.oldAccountIndividual = initDataEventArgs.commons.api.parentVc.customDialogParameters.oldAccount;
        entities.AltairAccount.newAccountIndividual = initDataEventArgs.commons.api.parentVc.customDialogParameters.newAccount;
    };