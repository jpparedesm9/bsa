//Start signature to Callback event to VA_VABUTTONFUIXKXW_718576
task.executeCommandCallback.VA_VABUTTONFUIXKXW_718576 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
		executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_OIIRL51SVE80');
	} else{
		executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_OIIRL51SVE80');
	}
};