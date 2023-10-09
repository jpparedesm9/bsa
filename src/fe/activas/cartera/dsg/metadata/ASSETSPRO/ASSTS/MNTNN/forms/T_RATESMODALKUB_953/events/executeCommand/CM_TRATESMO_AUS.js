// (Button) 
    task.executeCommand.CM_TRATESMO_AUS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelButton = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
        
    };