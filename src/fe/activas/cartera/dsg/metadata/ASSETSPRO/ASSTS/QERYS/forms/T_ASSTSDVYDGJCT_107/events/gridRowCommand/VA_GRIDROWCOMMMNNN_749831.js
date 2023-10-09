//Entity: QueryDocumentIndividualGridDetail
    //QueryDocumentIndividualGridDetail. (Button) View: QueryDocumentsGridDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMNNN_749831 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        //Open Modal
        ASSETS.Navigation.openHistorical(gridRowCommandEventArgs.rowData, gridRowCommandEventArgs, 'VA_GRIDROWCOMMMNNN_749831');
    };