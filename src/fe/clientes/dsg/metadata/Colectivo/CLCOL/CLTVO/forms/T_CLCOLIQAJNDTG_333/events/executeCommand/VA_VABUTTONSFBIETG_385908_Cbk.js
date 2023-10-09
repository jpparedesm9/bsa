//Start signature to Callback event to VA_VABUTTONSFBIETG_385908
task.executeCommandCallback.VA_VABUTTONSFBIETG_385908 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    executeCommandCallbackEventArgs.commons.execServer = false;
    if(entities.CollectivePersonRecord.data().length>0)
	{
	executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONUKAXPIV_480908');	
	}
	else
	{
		executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');	
	}
};