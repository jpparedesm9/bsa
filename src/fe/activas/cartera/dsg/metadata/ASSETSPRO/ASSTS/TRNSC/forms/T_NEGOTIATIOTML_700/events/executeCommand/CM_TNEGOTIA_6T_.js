// (Button) 
    task.executeCommand.CM_TNEGOTIA_6T_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        var cancelButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
        
    };