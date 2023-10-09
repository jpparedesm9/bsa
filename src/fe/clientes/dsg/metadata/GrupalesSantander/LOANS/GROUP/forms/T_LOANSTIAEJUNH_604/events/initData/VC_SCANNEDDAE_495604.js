//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ScannedDocumentsDetail
    task.initData.VC_SCANNEDDAE_495604 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var members = initDataEventArgs.commons.api.vc.rowData.members;
		var customerId = members.split("-");
        var taskViews = initDataEventArgs.commons.api.vc.parentVc.parentVc.model.TaskViews;
        var taskView  = taskViews == null || taskViews.length < 2 ? null : (taskViews[2] == null ? null : taskViews[2].componentDetailUrl);
        var params = taskView == null? null : taskView.split("?");
        var valueCode =  params == null || params < 1 ? null: params[1].split("=");
        var typeRequest = valueCode == null ? "": valueCode[1];
        
		var filtro = {
			customerId: customerId[0],
			groupId: initDataEventArgs.commons.api.parentVc.model.Group.code,
			processInstance: initDataEventArgs.commons.api.parentVc.model.Credit.applicationNumber,
            typeRequest: typeRequest
		}
		initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_SCANNEDD_6397', filtro);
        initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_SCANNEEC_4137', filtro);
    };