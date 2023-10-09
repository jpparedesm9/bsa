// (Button) 
    task.executeCommandCallback.CM_TCSTMRKO_C00 = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
		if (executeCommandCallbackEventArgs.success) {
			LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.NaturalPerson.documentNumber, 1);
			LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_MODIFICRNF_489882');
			executeCommandCallbackEventArgs.commons.api.viewState.show('G_MODIFICRNF_489882');
		}        
    };