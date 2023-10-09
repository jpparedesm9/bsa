//Start signature to Callback event to CM_TPROSPEC_MR6
task.executeCommandCallback.CM_TPROSPEC_MR6 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_MT4', true);
    } else {
        executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MT4', true);
    }
};
