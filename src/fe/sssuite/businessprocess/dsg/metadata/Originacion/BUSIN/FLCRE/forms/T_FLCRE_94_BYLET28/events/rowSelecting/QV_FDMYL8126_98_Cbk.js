//Start signature to callBack event to QV_FDMYL8126_98
    task.gridRowSelectingCallback.QV_FDMYL8126_98 = function(entities, gridRowSelectingEventArgs) {
       gridRowSelectingEventArgs.commons.execServer = false;	
		rowIndexTerm=gridRowSelectingEventArgs.rowIndex;
		console.log("rowIndexTerm"+rowIndexTerm);		
        // gridRowSelectingEventArgs.commons.serverParameters.FixedTermOperation = true;
    };