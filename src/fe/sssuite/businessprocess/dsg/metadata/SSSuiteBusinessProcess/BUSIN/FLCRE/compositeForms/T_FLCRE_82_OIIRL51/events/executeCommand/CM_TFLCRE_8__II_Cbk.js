//Start signature to Callback event to CM_TFLCRE_8__II
task.executeCommandCallback.CM_TFLCRE_8__II = function(entities, executeCommandCallbackEventArgs) {
    var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
    var parentVc = parentApi.vc;
    if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
        if(parentVc.model.InboxContainerPage.HiddenInCompleted === "EJE"){
            parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
    } else {
        parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
    }
};