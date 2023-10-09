// (Button) 
    task.executeCommand.CM_TPAYMENT_TEC = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var isCancel = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(isCancel);
        
    };