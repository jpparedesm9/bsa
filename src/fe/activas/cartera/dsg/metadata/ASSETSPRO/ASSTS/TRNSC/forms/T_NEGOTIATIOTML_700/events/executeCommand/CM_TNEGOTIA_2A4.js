// (Button) 
    task.executeCommand.CM_TNEGOTIA_2A4 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
        executeCommandEventArgs.commons.api.navigation.closeModal(entities.Negotiation);
        
    };