// (Button) 
    task.executeCommand.CM_TPAYMENT_08P = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        	var cancelButton = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
    };