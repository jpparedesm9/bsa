//gridRowDeleting QueryView: GridDisbursementDetail
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_TSRSE1342_26 = function(entities, gridRowDeletingEventArgs) {
		if(gridRowDeletingEventArgs.rowData.Currency == "" && gridRowDeletingEventArgs.rowData.DisbursementForm == "" && gridRowDeletingEventArgs.rowData.DisbursementValue == 0 && gridRowDeletingEventArgs.rowData.PriceQuote == 0){
			gridRowDeletingEventArgs.commons.execServer = false;
		}else{
			gridRowDeletingEventArgs.commons.execServer = true;
		}
    };