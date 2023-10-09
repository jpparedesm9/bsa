//Entity: QueryDocumentGridDetail
    //QueryDocumentGridDetail. (Button) View: QueryDocumentsGridDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMDND_285831 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        //Open Modal
        ASSETS.Navigation.openHistorical(gridRowCommandEventArgs.rowData, gridRowCommandEventArgs, 'VA_GRIDROWCOMMMDND_285831');
    };