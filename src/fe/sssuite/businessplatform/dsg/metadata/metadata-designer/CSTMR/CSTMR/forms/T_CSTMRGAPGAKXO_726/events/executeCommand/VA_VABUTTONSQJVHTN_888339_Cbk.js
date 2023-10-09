//Start signature to Callback event to VA_VABUTTONSQJVHTN_888339
task.executeCommandCallback.VA_VABUTTONSQJVHTN_888339 = function(entities, executeCommandCallbackEventArgs) {
    
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            /*resultArgs: {
                mode: executeCommandEventArgs.commons.api.vc.mode,
                accountIndividual: entities.AltairAccount.oldAccountIndividual}*/
        });
    } else {
        if(entities.CodeVerification.failureCounter == 3){
            executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONLWVBSLQ_895339');
            executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONSQJVHTN_888339');
            entities.CodeVerification.failureCounter = 0;
            entities.CodeVerification.code = null;
        }
    }
};