//Start signature to Callback event to CM_TASSTSOS_EAN
task.executeCommandCallback.CM_TASSTSOS_EAN = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_3655_99787');
};