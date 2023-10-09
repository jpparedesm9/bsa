// (Button) 
    task.executeCommand.CM_TPRIORIT_I8N = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelPriority = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelPriority);
    };