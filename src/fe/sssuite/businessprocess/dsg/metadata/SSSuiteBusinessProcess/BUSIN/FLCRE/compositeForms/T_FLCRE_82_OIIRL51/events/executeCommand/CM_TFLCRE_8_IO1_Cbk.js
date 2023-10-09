//Start signature to Callback event to CM_TFLCRE_8_IO1
task.executeCommandCallback.CM_TFLCRE_8_IO1 = function(entities, executeCommandCallbackEventArgs) {
    var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var parentVc = parentApi.vc;
    if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
        LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
        
        var ctrsShow = ['CM_TFLCRE_8__II'];
        BUSIN.API.show(viewState, ctrsShow);
        parentVc.model.InboxContainerPage.HiddenInCompleted = "EJE";
    }
};