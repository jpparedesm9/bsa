//Entity: AmortizationTableItem
    //AmortizationTableItem. (ImageButton) View: [object Object]
    
    task.gridRowCommand.VA_VWPAYMENLA2611_0000301 = function( entities, gridRowCommandEventArgs ) {
		cobis.showMessageWindow.loading(true);
		gridRowCommandEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, gridRowCommandEventArgs);
		gridRowCommandEventArgs.commons.api.grid.removeRow('AmortizationTableItem',gridRowCommandEventArgs.rowIndex);
		cobis.showMessageWindow.loading(false);
        
    };