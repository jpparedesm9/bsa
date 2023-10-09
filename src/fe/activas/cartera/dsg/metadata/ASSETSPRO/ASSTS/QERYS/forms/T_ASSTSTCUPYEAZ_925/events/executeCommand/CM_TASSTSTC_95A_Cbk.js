//Start signature to Callback event to CM_TASSTSTC_95A
task.executeCommandCallback.CM_TASSTSTC_95A = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9492_89518');
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.MSG_ASSTS_LATRANSLO_19347');
    }
};