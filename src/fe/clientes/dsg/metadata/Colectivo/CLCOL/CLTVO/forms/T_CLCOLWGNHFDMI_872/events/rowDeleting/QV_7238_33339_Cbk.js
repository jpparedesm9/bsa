//Start signature to Callback event to QV_7238_33339
task.gridRowDeletingCallback.QV_7238_33339 = function(entities, gridRowDeletingCallbackEventArgs) {
    if(gridRowDeletingCallbackEventArgs.success){
        gridRowDeletingCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("CLCOL.MSG_CLCOL_REGISTRIO_58575", null, 6000, false);
    }
    gridRowDeletingCallbackEventArgs.commons.api.grid.refresh("QV_7238_33339");
};