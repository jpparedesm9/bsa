//Start signature to callBack event to QV_ITRIC1523_63
	task.gridRowUpdatingCallback.QV_ITRIC1523_63 = function(entities, gridRowUpdatingEventArgs) {		
		if (gridRowUpdatingEventArgs.rowData.RefinancingAmount !== undefined && gridRowUpdatingEventArgs.rowData.RefinancingAmount !== null){
			entities.OriginalHeader.AmountCalculated = round(gridRowUpdatingEventArgs.rowData.RefinancingAmount,2);
			entities.OriginalHeader.AmountRequested = entities.OriginalHeader.AmountCalculated;
		} else {
			entities.OriginalHeader.AmountCalculated = 0;
			entities.OriginalHeader.AmountRequested = 0;
			gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_RENNEOUNE_04178');
		}
    };
