//Start signature to Callback event to VA_VABUTTONMCMUPUS_172945
task.executeCommandCallback.VA_VABUTTONMCMUPUS_172945 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        var controls = ['CM_TCSTMRKR_SMT'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, false);
        controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        executeCommandCallbackEventArgs.commons.messageHandler.showMessagesInformation('CSTMR.MSG_CSTMR_TRANSACNA_95871',5000);
    }else{
        var controls = ['CM_TCSTMRKR_SMT'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        
        controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, false);
    }
};