//Start signature to callBack event to CM_TFLCRE_9_342
task.executeCommandCallback.CM_TFLCRE_9_342 = function(entities, executeCommandCallbackEventArgs) {
//here your code
     entities.Punishment = [];
     
		var ctrsToDisable = ['CM_TFLCRE_9_L85'];
        var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
        BUSIN.API.disable(viewState,ctrsToDisable);	 
		var ctrsToDisable2 = ['CM_TFLCRE_9_342'];
		BUSIN.API.disable(viewState,ctrsToDisable2);	 
};