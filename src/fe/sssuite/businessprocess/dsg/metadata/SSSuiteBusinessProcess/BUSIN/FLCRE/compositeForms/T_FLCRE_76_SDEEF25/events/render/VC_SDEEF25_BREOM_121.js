//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: taskDisbursementForm
    task.render = function(entities, renderEventArgs) {
		
		var viewState = renderEventArgs.commons.api.viewState;
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		
		//BANDERA QUE INDICA SI LAS 'FORMAS DE DESEMBOLSO' MARCADAS CON UN 'CODIGO' SE PUEDEN ELIMINAR O NO
		if(entities.LoanHeader.LockDelete===true) {
			var rows = entities.DisbursementDetail.data();
			for (var i = 0; i < rows.length; i++) {
                if(rows[i].DisbursementForm === entities.LoanHeader.LockCode) {
					renderEventArgs.commons.api.grid.hideGridRowCommand('QV_TSRSE1342_26', rows[i], 'delete');
				}
            }
		}
		
		if (parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == 'Q') {
    		task.hideModeQuery(renderEventArgs);
    	}
		
	};