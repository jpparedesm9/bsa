//Start signature to Callback event to CM_TCHANGEV_742
task.executeCommandCallback.CM_TCHANGEV_742 = function(entities, executeCommandCallbackEventArgs) {
    
    
    if(executeCommandCallbackEventArgs.success){
    var api = executeCommandCallbackEventArgs.commons.api;
        if (api.parentVc != undefined){
            api.parentVc.setContainerView(entities.Warranty.externalCode);
        } 
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(true); 
    }
};