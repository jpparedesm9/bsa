//Start signature to callBack event to CM_TECONOMI_RSP
task.executeCommandCallback.CM_TECONOMI_RSP = function(entities, executeCommandCallbackEventArgs) {
    var aceptButton = true;
    executeCommandCallbackEventArgs.commons.api.navigation.closeModal(aceptButton);
};