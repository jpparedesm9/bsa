//Start signature to Callback event to CM_TASSTSOS_SJO
task.executeCommandCallback.CM_TASSTSOS_SJO = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_3655_99787');
};