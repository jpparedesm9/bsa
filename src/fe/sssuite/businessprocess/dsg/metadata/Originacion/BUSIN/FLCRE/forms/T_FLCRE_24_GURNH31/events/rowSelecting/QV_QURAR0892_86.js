//gridRowSelecting QueryView: GridGuarantee
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_QURAR0892_86 = function (entities, gridRowSelectingEventArgs) {
        var rowData = gridRowSelectingEventArgs.rowData;
	    guareanteeDialogParameters = rowData;
		entities.WarrantieComext.warrantieType = rowData.GuaranteeType;
		entities.WarrantieComext.currencyWarrantie = rowData.Currency;
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };