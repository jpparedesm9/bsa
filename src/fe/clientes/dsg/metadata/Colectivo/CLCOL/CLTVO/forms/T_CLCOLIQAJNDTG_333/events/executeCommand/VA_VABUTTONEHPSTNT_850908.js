//Entity: CollectivePersonFile
    //CollectivePersonFile. (Button) View: LoadCollectivePerson
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONEHPSTNT_850908 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
        if(entities.CollectivePersonFile.fileName!=="")
            {
    executeCommandEventArgs.commons.api.vc.removeFile('VA_4965WEUNXYQPSHI_453908')
            }
    executeCommandEventArgs.commons.api.grid.refresh('QV_8718_49718');
    executeCommandEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');
    
    CLCOL.fileLoadingPercent(0,"VA_VASIMPLELABELLL_690908");
    executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_216908');
    executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_690908');
    executeCommandEventArgs.commons.api.viewState.enable("VA_VABUTTONSFBIETG_385908");
        $("#VA_VASIMPLELABELLL_989908").text(0);
        $("#VA_VASIMPLELABELLL_366908").text(0);
        $("#VA_VASIMPLELABELLL_901908").text(0);
        entities.CollectivePersonFile.successRecords = "0";
    };