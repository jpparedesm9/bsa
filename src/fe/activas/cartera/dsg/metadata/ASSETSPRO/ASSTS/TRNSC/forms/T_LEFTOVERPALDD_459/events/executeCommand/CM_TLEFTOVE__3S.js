// (Button) 
    task.executeCommand.CM_TLEFTOVE__3S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(entities.LeftOverPayment);
    };