//Start signature to Callback event to VA_VABUTTONEFSSZUP_619342
task.executeCommandCallback.VA_VABUTTONEFSSZUP_619342 = function(entities, executeCommandCallbackEventArgs) {
    
    if(executeCommandCallbackEventArgs.success){
        var str = entities.CreditCandidates.description;
        entities.CreditCandidates.auxText = str.substring(0, 30);;
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
        resultArgs: {
            index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
            mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
            data: entities.CreditCandidates
        }});

        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.LBL_ASSTS_TRANSACEC_23845','', 2000,false);
        }
        
    }
    
    
};