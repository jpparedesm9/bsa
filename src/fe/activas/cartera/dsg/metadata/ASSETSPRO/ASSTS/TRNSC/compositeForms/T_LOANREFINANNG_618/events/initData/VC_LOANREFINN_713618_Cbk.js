//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanRefinancing
    task.initDataCallback.VC_LOANREFINN_713618 = function (entities, initDataEventArgs){
        if(entities.RefinanceLoans.data().length === 0 ){
			initDataEventArgs.commons.api.vc.closeDialog();
			var subModuleId = "CMMNS",
      	        taskId = "T_LOANSEARCHSWA_959",
			    vcId = "VC_LOANSEARHC_144959",
			    parameters = '',
			    label="Búsqueda de Préstamos";
			ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, initDataEventArgs, parameters);        
		}
    };