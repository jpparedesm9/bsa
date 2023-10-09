//Entity: AmortizationTableItem
    //AmortizationTableItem.Item8 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_TEM8856 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
    };