//Start signature to Callback event to CM_TCSTMRKR_SMT
task.executeCommandCallback.CM_TCSTMRKR_SMT = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        var controls = ['VA_3427XJKLLNQAQYE_228945','VA_VABUTTONMCMUPUS_172945','CM_TCSTMRKR_SMT'];
        LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        entities.ReferenceInfor.refStatus = APPLIED;
        executeCommandCallbackEventArgs.commons.messageHandler.showMessagesInformation('CSTMR.LBL_CSTMR_LATRANSZA_43084', false, null, 6000);
    }
    
};