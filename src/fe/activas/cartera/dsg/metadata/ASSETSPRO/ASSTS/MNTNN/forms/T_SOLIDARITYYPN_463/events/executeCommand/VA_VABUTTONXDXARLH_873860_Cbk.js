//Start signature to Callback event to VA_VABUTTONXDXARLH_873860
task.executeCommandCallback.VA_VABUTTONXDXARLH_873860 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSTS.LBL_ASSTS_LOSDATOCN_90286', '', 2000, false);
    }
};