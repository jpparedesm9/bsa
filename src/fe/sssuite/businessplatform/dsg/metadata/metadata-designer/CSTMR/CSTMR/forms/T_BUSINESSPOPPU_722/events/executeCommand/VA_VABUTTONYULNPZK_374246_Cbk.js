//Start signature to Callback event to VA_VABUTTONYULNPZK_374246
task.executeCommandCallback.VA_VABUTTONYULNPZK_374246 = function(entities, executeCommandCallbackEventArgs) {
    //here your code
    if(executeCommandCallbackEventArgs.success){
        
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                data: entities.Business
            }});
        
        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Insert){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576','', 2000,false);
        
        }else if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
        }
    }
};