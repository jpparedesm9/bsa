//AuthorizationTransferDetailQuery Entity: 
    task.executeQuery.Q_AUTHORTD_2985 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
		var filtro = {
			idRequest: executeQueryEventArgs.commons.api.parentVc.customDialogParameters.idRequest
		}
        executeQueryEventArgs.commons.api.vc.parentVc = {};
        executeQueryEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    };