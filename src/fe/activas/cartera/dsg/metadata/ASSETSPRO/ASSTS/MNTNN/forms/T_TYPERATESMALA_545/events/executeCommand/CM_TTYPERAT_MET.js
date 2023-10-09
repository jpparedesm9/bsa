// (Button) 
    task.executeCommand.CM_TTYPERAT_MET = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelButton = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
    };