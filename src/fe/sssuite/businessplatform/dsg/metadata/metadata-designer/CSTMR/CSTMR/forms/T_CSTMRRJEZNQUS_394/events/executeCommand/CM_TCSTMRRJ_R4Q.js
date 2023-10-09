// (Button) 
    task.executeCommand.CM_TCSTMRRJ_R4Q = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var result = {option:1};
        executeCommandEventArgs.commons.api.vc.closeModal(result);
    };