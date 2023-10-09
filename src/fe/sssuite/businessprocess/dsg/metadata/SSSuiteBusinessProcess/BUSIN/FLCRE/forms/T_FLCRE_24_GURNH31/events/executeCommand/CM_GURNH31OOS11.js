// Choose (Button)
    task.executeCommand.CM_GURNH31OOS11 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        var selectedRows = executeCommandEventArgs.commons.api.grid.getSelectedRows('QV_QURAR0892_86');
		if( BUSIN.VALIDATE.IsNull(selectedRows) || selectedRows.length===0 ){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_ELCNEUNAR_05370',null,5000);
			return;
		}else if (executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().maxRelation && selectedRows[0].relation ){
			if(selectedRows[0].relation<executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().maxRelation){	
				executeCommandEventArgs.commons.execServer = false;
				executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_LERELTSHI_68262',null,5000);
				return;
			}
		}	 
    };