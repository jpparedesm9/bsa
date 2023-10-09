//gridCommand (ImageButton) QueryView: GridAmortizationTable
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_QUYOI3312_16_019 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
		var data = entities.AmortizationTableItem.data();
		var newDividend = data.length + 1;
		var lastIndex
		if(entities.PaymentPlan.selectingQuotaIndex != undefined && entities.PaymentPlan.selectingQuotaIndex != null) {
		   lastIndex = entities.PaymentPlan.selectingQuotaIndex
		} else {
		   lastIndex = data.length - 1
		}
		var lastExpirationDate = data[lastIndex].ExpirationDate;
		var newDate = new Date(lastExpirationDate.getFullYear(), lastExpirationDate.getMonth() + 1, lastExpirationDate.getDate(), 0, 0, 0, 0);
			
		var amortizationTableItem ={Balance:0,
									Dividend: newDividend,
									ExpirationDate: newDate,
									Fee:0,
									Item1:0,
									Item2:0,
									Item3:0,
									Item4:0,
									Item5:0,
									Item6:0,
									Item7:0,
									Item8:0,
									Item9:0,
									Item10:0,
									Item11:0,
									Item12:0,
									Item13:0};		
		entities.AmortizationTableItem.insert(lastIndex + 1,amortizationTableItem);					
		task.changeManualAmortizationTable(entities, gridExecuteCommandEventArgs);
		newDividend = lastIndex + 2;
		var criteria = { field: "Dividend", operator:"eq" ,value: newDividend} ;
        var selectedRow =  gridExecuteCommandEventArgs.commons.api.grid.selectRow("QV_QUYOI3312_16",criteria);
		task.setScrollAmortizationTable(data.length, gridExecuteCommandEventArgs.commons.api);
    };