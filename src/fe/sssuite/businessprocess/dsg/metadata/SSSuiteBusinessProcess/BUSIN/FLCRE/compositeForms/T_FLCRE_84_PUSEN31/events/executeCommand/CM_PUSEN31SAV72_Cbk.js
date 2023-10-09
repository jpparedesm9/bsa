// (Button) Save
    task.executeCommandCallback.CM_PUSEN31SAV72 = function(entities, executeCommandCallbackEventArgs) {
        BUSIN.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
		BUSIN.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'GR_WTTTEPRCES08_02');
		if(task.EtapaTramite!=FLCRE.CONSTANTS.Stage.Massive
		){
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}else{//en pantalla modal, se cierra
			if(executeCommandCallbackEventArgs.success){
				var result = { };
			executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);
			}		
		}
    };