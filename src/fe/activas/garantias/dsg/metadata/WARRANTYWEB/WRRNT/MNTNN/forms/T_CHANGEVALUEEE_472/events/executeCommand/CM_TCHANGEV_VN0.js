// (Button) 
    task.executeCommand.CM_TCHANGEV_VN0 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal(true); 
    };