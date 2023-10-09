//Start signature to Callback event to VA_VABUTTONLWVBSLQ_895339
task.executeCommandCallback.VA_VABUTTONLWVBSLQ_895339 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONSQJVHTN_888339');
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONLWVBSLQ_895339');
    }
};