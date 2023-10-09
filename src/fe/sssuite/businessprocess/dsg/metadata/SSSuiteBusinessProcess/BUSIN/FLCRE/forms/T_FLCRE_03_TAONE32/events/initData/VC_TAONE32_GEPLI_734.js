//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_TAONE32_GEPLI_734 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        // initDataEventArgs.commons.serverParameters.entityName = true;
		var customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();  
        if(customDialogParameters != undefined ){
			entities.HeaderPunishment = customDialogParameters.HeaderPunishmentRow;
        }
    };