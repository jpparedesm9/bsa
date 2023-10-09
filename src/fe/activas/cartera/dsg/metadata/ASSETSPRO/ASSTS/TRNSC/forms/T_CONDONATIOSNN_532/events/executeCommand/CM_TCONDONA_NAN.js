// (Button) 
    task.executeCommand.CM_TCONDONA_NAN = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        var cancelButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
        
    };