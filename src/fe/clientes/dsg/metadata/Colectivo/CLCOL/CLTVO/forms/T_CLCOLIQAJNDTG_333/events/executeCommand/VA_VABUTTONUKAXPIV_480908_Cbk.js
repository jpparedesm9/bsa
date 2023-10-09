//Start signature to Callback event to VA_VABUTTONUKAXPIV_480908
task.executeCommandCallback.VA_VABUTTONUKAXPIV_480908 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        var percentage = ((gridPosition + 1 ) * 100) / gridLength;
        CLCOL.fileLoadingPercent(percentage,"VA_VASIMPLELABELLL_690908");
        if (gridPosition == gridLength - 1) {
            executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');
            executeCommandCallbackEventArgs.commons.api.viewState.disable("VA_VABUTTONSFBIETG_385908");
            disableFileUploadButton();
            gridPosition = 0;
            
            $("#VA_VASIMPLELABELLL_989908").text(gridLength);
            $("#VA_VASIMPLELABELLL_366908").text(entities.CollectivePersonFile.successRecords);
            $("#VA_VASIMPLELABELLL_901908").text(gridLength - entities.CollectivePersonFile.successRecords);

            return;
        }
        gridPosition++;
        executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONUKAXPIV_480908', 'VA_VABUTTONUKAXPIV_480908', null, false, false, 'G_LOADCOLIPC_406908', false);
    }
};
