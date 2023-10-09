//Start signature to callBack event to CM_OIIRL51SVE80
task.executeCommandCallback.CM_OIIRL51SVE80 = function (entities, executeCommandEventArgs) {
    var parentApi = executeCommandEventArgs.commons.api.parentApi();
    //executeCommandEventArgs.success=true;//modificacion temporal
    if (parentApi != undefined && executeCommandEventArgs.success) {
        var parentVc = parentApi.vc;
        parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625');
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (entities.OriginalHeader.IDRequested == null || entities.OriginalHeader.IDRequested == '0' ? '--' : entities.OriginalHeader.IDRequested));
        LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandEventArgs, 'GR_WTTTEPRCES08_02');
    }
    executeCommandEventArgs.commons.execServer = false;
};