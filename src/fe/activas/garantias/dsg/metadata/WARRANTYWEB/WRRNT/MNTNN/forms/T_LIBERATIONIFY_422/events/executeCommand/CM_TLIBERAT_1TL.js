// (Button) 
    task.executeCommand.CM_TLIBERAT_1TL = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal(true);
    };