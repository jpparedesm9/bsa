//gridRowSelecting QueryView: QV_6427_29743
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_6427_29743 = function(entities, gridRowSelectingEventArgs) {
		rowIndexAccount=gridRowSelectingEventArgs.rowIndex;
		console.log("rowIndexAccount"+rowIndexAccount);
        gridRowSelectingEventArgs.commons.execServer = false;
        gridRowSelectingEventArgs.commons.serverParameters.AccountInformation = true;
    };