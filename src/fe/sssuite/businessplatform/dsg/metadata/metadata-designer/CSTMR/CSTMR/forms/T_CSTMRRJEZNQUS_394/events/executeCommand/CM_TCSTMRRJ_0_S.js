// (Button) 
    task.executeCommand.CM_TCSTMRRJ_0_S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var result = {option:2};
        executeCommandEventArgs.commons.api.vc.closeModal(result);
        
    };