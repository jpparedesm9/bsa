//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TaskExpDisbursementForm
    task.initDataCallback.VC_SUMNF62_FXUSN_876 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.execServer = false;
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		//Valida si saldo es 0 para habilitar boton continuar
		if(entities.LoanHeader.BalanceOperation == 0){			
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		 }else{
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		 }
	};