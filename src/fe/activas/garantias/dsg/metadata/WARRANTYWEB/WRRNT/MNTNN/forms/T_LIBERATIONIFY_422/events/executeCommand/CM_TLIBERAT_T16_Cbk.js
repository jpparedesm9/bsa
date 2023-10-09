//Start signature to Callback event to CM_TLIBERAT_T16
task.executeCommandCallback.CM_TLIBERAT_T16 = function(entities, executeCommandCallbackEventArgs) {

    var args = executeCommandCallbackEventArgs;
    if(executeCommandCallbackEventArgs.success){
    var api = executeCommandCallbackEventArgs.commons.api;
    if (api.parentVc != undefined){
            api.parentVc.setContainerView(entities.Warranty.externalCode);
    }
    executeCommandCallbackEventArgs.commons.api.vc.closeModal(true);
    }
};