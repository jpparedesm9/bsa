// (Button) 
    task.executeCommandCallback.CM_EJTDI03AVE03 = function(entities, executeCommandCallbackEventArgs) {

		//Ejecucion de servicio desde el inbox
		//executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitRejectionCreditTramite.commitRejectionCreditTramite';//no se utiliza el servicio
		executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.bussinessInformationStringOne = entities.OriginalHeader.IDRequested;
		executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.bussinessInformationStringTwo = entities.OriginalHeader.RejectionExcuse; 
		
		//Habilito el boton de acciones del contenedor inbox
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		
		executeCommandCallbackEventArgs.commons.execServer = false;  
      
    };