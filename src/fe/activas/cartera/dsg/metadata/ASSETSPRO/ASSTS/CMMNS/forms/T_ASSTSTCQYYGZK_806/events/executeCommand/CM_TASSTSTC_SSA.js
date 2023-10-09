// (Button) 
    task.executeCommand.CM_TASSTSTC_SSA = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        var observation = entities.ConciliationManualSearchFilter.observation; 
           
        executeCommandEventArgs.commons.api.navigation.closeModal(observation);
    };