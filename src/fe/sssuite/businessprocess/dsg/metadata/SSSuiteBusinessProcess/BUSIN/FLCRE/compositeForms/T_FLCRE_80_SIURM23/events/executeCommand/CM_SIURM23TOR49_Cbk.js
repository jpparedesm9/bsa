//Start signature to callBack event to CM_SIURM23TOR49
    task.executeCommandCallback.CM_SIURM23TOR49 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var parentApi = executeCommandEventArgs.commons.api.parentApi();

		//Habilitar boton continuar si se ejecuta la Liquidacion correctamente
		 if(parentApi != undefined && executeCommandEventArgs.success){
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		 }else{
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		 }
    };