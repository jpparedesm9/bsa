//Entity: QueryDocumentCredit
    //QueryDocumentCredit. (Button) View: QueryDocuments
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAD_737273 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };