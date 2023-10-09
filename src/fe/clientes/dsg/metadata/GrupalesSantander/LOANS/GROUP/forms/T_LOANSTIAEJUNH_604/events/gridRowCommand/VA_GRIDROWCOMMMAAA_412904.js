//Entity: ScannedDocumentsIndividualDetail
    //ScannedDocumentsIndividualDetail. (Button) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAA_412904 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };