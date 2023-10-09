//Start signature to Callback event to CM_TBMTRCXB_T69
task.executeCommandCallback.CM_TBMTRCXB_T69 = function(entities, executeCommandCallbackEventArgs) {
	if(executeCommandCallbackEventArgs.success)
	{
		executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted ="YES"
	}else{
		executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted ="NO"
	}
};