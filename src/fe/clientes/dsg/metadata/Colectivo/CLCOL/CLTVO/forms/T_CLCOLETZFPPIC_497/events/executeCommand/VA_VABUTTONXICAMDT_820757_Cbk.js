//Start signature to Callback event to VA_VABUTTONXICAMDT_820757
task.executeCommandCallback.VA_VABUTTONXICAMDT_820757 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    if (executeCommandCallbackEventArgs.success) {
        var percentage =  ((gridPosition + 1) * 100) / gridLength;
        CLCOL.fileLoadingPercent(percentage,"VA_VASIMPLELABELLL_164757");
        if (gridPosition == gridLength - 1) {
            executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONXICAMDT_820757');
            gridPosition = 0;
            return;
        }
        gridPosition++;
        executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONXICAMDT_820757', 'VA_VABUTTONXICAMDT_820757', null, false, false, 'G_LOADEXTLSS_819757', false);

    }
};