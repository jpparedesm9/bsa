//gridCommand (Button) QueryView: GridDisbursementDetail
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_TSRSE1342_26_253 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
		var api = gridExecuteCommandEventArgs.commons.api, dsData, dsRow;

		/*Validando si se ha agregado un registro vacio al grid y eliminarlo*/
		var ds = gridExecuteCommandEventArgs.commons.api.vc.model['DisbursementDetail'];
		
		var dsData = ds.data();
		for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
			if(dsRow.Currency == "" && dsRow.DisbursementForm == "" && dsRow.DisbursementValue == 0 && dsRow.PriceQuote == 0){	
				api.grid.removeRow('DisbursementDetail', i);            
            };
		};		
		if(entities.LoanHeader.BalanceOperation == 0){
			gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_YAOTIBURE_04675');
		}else{
			api.grid.addRow('DisbursementDetail',{DisbursementForm: '', Currency: '', DisbursementValue: 0, ValueMl: 0, PriceQuote: 0,DisbursementFormId:''});

			dsData = api.vc.model['DisbursementDetail'].data();
			dsRow = dsData[dsData.length-1];

			var uigrid = $('#' + 'QV_TSRSE1342_26').data('kendoGrid');
			uigrid.expandRow($("[data-uid=\'" + dsRow.uid + "\']"));
		}
		gridExecuteCommandEventArgs.commons.execServer = false;
    };