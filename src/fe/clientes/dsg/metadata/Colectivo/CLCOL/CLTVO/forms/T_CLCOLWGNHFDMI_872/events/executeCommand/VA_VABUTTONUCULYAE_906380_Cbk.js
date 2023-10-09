//Start signature to Callback event to VA_VABUTTONUCULYAE_906380
task.executeCommandCallback.VA_VABUTTONUCULYAE_906380 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("CLCOL.MSG_CLCOL_REGISTRSE_24783", null, 6000, false);
    }
    executeCommandCallbackEventArgs.commons.api.grid.refresh("QV_7238_33339");
};