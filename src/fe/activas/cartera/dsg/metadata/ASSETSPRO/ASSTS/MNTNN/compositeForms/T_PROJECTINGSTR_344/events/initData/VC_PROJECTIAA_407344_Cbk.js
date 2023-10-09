//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: OtherCharges
    task.initDataCallback.VC_PROJECTIAA_407344 = function (entities, initDataEventArgs){
        if(!initDataEventArgs.success){
            initDataEventArgs.commons.api.vc.closeDialog();
			var subModuleId = "CMMNS",
      	        taskId = "T_LOANSEARCHSWA_959",
			    vcId = "VC_LOANSEARHC_144959",
			    parameters = '',
			    label="BÃºsqueda de PrÃ©stamos";
			ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, initDataEventArgs, parameters);        
		}
    };