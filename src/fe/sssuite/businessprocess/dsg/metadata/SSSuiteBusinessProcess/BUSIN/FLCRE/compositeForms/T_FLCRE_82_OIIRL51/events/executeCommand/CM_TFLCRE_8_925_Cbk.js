//Start signature to Callback event to CM_TFLCRE_8_925
task.executeCommandCallback.CM_TFLCRE_8_925 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var parentVc = parentApi.vc;
    
    if(executeCommandCallbackEventArgs.success){
        parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    }
};