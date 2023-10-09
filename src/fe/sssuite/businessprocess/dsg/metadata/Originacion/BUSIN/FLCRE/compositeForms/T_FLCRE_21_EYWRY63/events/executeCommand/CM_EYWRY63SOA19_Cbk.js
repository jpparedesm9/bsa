//Start signature to callBack event to CM_EYWRY63SOA19
    task.executeCommandCallback.CM_EYWRY63SOA19 = function(entities, executeCommandCallbackEventArgs) {
        BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		task.disableRowGrid(executeCommandCallbackEventArgs, 'OtherWarranty' , 'QV_URYTH5890_66');
		task.disableRowGrid(executeCommandCallbackEventArgs, 'PersonalGuarantor', 'QV_PESAU2317_81');
		if(executeCommandCallbackEventArgs.success){		 
		  //Set del campo HiddenInCompleted para poder continuar la tarea
		  executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
    };

task.disableRowGrid = function(eventArgs, entity , idGrid ){

		var ds = eventArgs.commons.api.vc.model[entity];
		var grid = eventArgs.commons.api.grid;
		var dsData = ds.data();
        for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
            if(dsRow.isHeritage === 'S'){
                grid.addRowStyle(idGrid, dsRow, 'Disable_CTR');
			    grid.hideGridRowCommand(idGrid, dsRow, 'delete');
            }else{
				grid.removeRowStyle(idGrid, dsRow, 'Disable_CTR');
				grid.showGridRowCommand(idGrid, dsRow, 'delete');
			}
        }
		eventArgs.commons.api.viewState.refreshData(idGrid);
	};