//Entity: QueryDocumentHistory
    //QueryDocumentHistory. (Button) View: QueryDocumentsHistory
    
    task.gridRowCommand.VA_GRIDROWCOMMMDNA_321376 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.downloadHistorical(entities, gridRowCommandEventArgs);
    };