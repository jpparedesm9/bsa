//Start signature to Callback event to VA_TEXTINPUTBOXSYD_837273
task.gridRowCommandCallback.VA_TEXTINPUTBOXSYD_837273 = function(entities, gridRowCommandCallbackEventArgs) {
    gridRowCommandCallbackEventArgs.commons.execServer = false;
    if (gridRowCommandCallbackEventArgs.success){
        gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_5385_46042', 'file');
        gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
    }
};