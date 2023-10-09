// (Button) 
task.executeCommand.CM_TECONOMI_2A8 = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    var cancelButton = false;
    executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
};