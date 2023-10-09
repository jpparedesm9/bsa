//Entity: CustomerSearch
    //CustomerSearch.CustomerId (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_TOMERSHVIW6014_CTRD054 = function(entities, executeCommandEventArgs) {
		
    	//Recupero Cliente
    	var customer = executeCommandEventArgs.commons.api.vc.model.CustomerSearch;
    	
    	//Recupero parametros desde la vc padre
		var customDialogParameters = executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters();
		if (customDialogParameters!=null) {
			entities.Operations =  customDialogParameters.operations;
		}
		
		//Envio a buscar las operaciones del cliente
		if(customer.CustomerId != null) {
			executeCommandEventArgs.commons.execServer = true;
		}else {
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OSEEOULIN_28612');
			executeCommandEventArgs.commons.execServer = false;
		}
    };