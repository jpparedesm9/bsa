// (Button) 
task.executeCommand.CM_TASSCRMF_I20 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    entities.PrefilledRequest.clientId = null;
    entities.PrefilledRequest.clientIdStr = null;
    entities.PrefilledRequest.groupRequest = 'N';
    entities.PrefilledRequest.renewalsRequest = 'N';
};