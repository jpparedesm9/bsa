//Entity: QueryDocumentIndividualGridDetail
    //QueryDocumentIndividualGridDetail. (Button) View: QueryDocumentsGridDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMAND_747831 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };