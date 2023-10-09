//Start signature to Callback event to CM_TCSTMRTV_C7T
task.executeCommandCallback.CM_TCSTMRTV_C7T = function(entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
        executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_8174_44016');
    } else {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
    }
    
};