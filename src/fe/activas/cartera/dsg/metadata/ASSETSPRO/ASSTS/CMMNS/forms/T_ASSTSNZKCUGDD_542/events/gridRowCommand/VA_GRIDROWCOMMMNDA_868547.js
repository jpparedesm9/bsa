//Entity: ConciliationManualSearch
    //ConciliationManualSearch. (Button) View: ConciliationManualSearchForm
    
    task.gridRowCommand.VA_GRIDROWCOMMMNDA_868547 = function(  entities, gridRowCommandEventArgs ) {

        gridRowCommandEventArgs.commons.execServer = false;
        
        var api = gridRowCommandEventArgs.commons.api;
        
        var previousValue = gridRowCommandEventArgs.rowData.isSelected;
        
        if (previousValue == false) {
            gridRowCommandEventArgs.rowData.isSelected = true;
        } else {
            gridRowCommandEventArgs.rowData.isSelected = false;
        }
        
        api.grid.updateRow("ConciliationManualSearch", gridRowCommandEventArgs.rowIndex, gridRowCommandEventArgs.rowData);
    
    };