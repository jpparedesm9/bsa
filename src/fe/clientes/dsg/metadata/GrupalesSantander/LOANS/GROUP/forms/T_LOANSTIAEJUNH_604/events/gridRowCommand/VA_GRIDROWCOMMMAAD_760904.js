//Entity: ScannedDocumentsDetail
    //ScannedDocumentsDetail.undefined (Button) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAD_760904 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };