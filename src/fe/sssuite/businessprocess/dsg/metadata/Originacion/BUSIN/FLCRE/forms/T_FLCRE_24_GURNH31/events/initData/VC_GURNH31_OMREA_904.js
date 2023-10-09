//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_GURNH31_OMREA_904 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
		 var customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
		 entities.WarrantieComext.currencyComext = customDialogParameters.operationComext;
        
    };