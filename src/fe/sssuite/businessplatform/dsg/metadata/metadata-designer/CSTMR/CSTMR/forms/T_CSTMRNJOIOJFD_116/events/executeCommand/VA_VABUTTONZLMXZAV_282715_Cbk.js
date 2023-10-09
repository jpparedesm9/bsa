//Start signature to Callback event to VA_VABUTTONZLMXZAV_282715
task.executeCommandCallback.VA_VABUTTONZLMXZAV_282715 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
                resultArgs: {
                    mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                    accountIndividual: entities.AltairAccount.newAccountIndividual
                }});
        
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
    }
};