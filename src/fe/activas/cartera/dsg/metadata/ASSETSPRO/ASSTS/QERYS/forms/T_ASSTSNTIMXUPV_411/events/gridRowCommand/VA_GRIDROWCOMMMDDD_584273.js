//Entity: QueryDocumentCredit
    //QueryDocumentCredit. (Button) View: QueryDocuments
    
    task.gridRowCommand.VA_GRIDROWCOMMMDDD_584273 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        //Open Modal
        ASSETS.Navigation.openHistorical(gridRowCommandEventArgs.rowData, gridRowCommandEventArgs, 'VA_GRIDROWCOMMMDDD_584273');
        
    };