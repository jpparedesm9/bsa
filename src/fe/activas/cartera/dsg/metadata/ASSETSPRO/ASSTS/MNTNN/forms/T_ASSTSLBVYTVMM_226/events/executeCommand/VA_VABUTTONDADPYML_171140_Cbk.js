//Start signature to Callback event to CM_TCHANGEV_742
task.executeCommandCallback.VA_VABUTTONDADPYML_171140 = function(entities, executeCommandCallbackEventArgs) {
    
    executeCommandCallbackEventArgs.commons.execServer = false;
    if(executeCommandCallbackEventArgs.success){
    var api = executeCommandCallbackEventArgs.commons.api;
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(true); 
    }
};