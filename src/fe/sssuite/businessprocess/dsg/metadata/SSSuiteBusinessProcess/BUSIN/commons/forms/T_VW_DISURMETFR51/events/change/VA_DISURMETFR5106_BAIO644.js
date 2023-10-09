//Entity: LoanHeader
    //LoanHeader.BalanceOperation (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
        task.change.VA_DISURMETFR5106_BAIO644 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
		var parentApi = changedEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;

		//Valida si saldo es 0 para habilitar boton continuar
		if(entities.LoanHeader.BalanceOperation == 0){
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			//changedEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitDisbursement.commitDisbursement';
		}else{
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		}
    };