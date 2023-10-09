// (Button) 
    task.executeCommand.CM_TASSTSTC_82_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelObservation = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelObservation);
        
    };