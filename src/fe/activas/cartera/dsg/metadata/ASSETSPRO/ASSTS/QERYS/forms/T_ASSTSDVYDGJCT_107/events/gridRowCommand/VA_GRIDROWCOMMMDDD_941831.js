//Entity: QueryDocumentGridDetail
    //QueryDocumentGridDetail. (Button) View: QueryDocumentsGridDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMDDD_941831 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };