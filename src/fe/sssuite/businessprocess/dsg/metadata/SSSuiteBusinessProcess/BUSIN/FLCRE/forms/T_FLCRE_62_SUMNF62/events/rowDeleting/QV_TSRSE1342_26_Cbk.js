//Start signature to callBack event to QV_TSRSE1342_26
	task.gridRowDeletingCallback.QV_TSRSE1342_26 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
		if(gridRowDeletingEventArgs.success == true){
			entities.LoanHeader.BalanceOperation = entities.LoanHeader.BalanceOperation + gridRowDeletingEventArgs.rowData.AmountMOP;
		}
		var d=0;
   };