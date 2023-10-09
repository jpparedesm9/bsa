// (Button) 
    task.executeCommandCallback.CM_TTESTWKH_NN5 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false; 
        var api = executeCommandEventArgs.commons.api
        var response = { };
        api.vc.closeModal(response);
        
    };