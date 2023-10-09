// (Button) 
    task.executeCommand.CM_TTESTWKH_T57 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;        
        var api = executeCommandEventArgs.commons.api
        var response = { };
        api.vc.closeModal(response); 
    };