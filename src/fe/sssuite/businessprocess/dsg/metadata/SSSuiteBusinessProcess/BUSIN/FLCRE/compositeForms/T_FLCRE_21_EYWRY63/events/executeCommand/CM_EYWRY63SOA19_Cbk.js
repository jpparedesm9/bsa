//Callback Asociar
    task.executeCommandCallback.CM_EYWRY63SOA19 = function(entities, executeCommandEventArgs) {
   	    BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
		task.disableRowGrid(executeCommandEventArgs, 'OtherWarranty' , 'QV_URYTH5890_66');
		task.disableRowGrid(executeCommandEventArgs, 'PersonalGuarantor', 'QV_PESAU2317_81');
		if(executeCommandEventArgs.success){		 
		  //Set del campo HiddenInCompleted para poder continuar la tarea
		  executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
	 };