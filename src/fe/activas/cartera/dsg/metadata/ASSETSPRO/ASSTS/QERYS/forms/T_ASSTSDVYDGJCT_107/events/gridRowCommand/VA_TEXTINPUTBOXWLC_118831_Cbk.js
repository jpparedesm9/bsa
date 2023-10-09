//Start signature to Callback event to VA_TEXTINPUTBOXWLC_118831
task.gridRowCommandCallback.VA_TEXTINPUTBOXWLC_118831 = function(entities, gridRowCommandCallbackEventArgs) {
    gridRowCommandCallbackEventArgs.commons.execServer = false;
    if(gridRowCommandCallbackEventArgs.success){
        gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_2153_73215', 'file');
        gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
    }
};