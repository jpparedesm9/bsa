//Entity: AmortizationTableItem
    //AmortizationTableItem.ExpirationDate (DateField) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_EPTI184 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;    
		var data = entities.AmortizationTableItem.data();
		var row = changedEventArgs.rowData;
		//la fecha de expiración debe ser mayor a la fecha de inicio de la operación
		var validateDateOperation = task.validateDates(entities.PaymentPlanHeader.initialDate,row.ExpirationDate,true)
		if(!validateDateOperation){
			row.set('ExpirationDate', changedEventArgs.oldValue);
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_ROMOPNDTE_93346');
		}
		var validateDates = true; 
		if (row.Dividend > 1){
			validateDates = task.validateDates(data[row.Dividend - 2].ExpirationDate, row.ExpirationDate,false)
		}
		if(validateDates){
			task.validateHolidayDate(entities, row.ExpirationDate,changedEventArgs );
			task.changeManualAmortizationTable(entities, changedEventArgs);

		}else{
			row.set('ExpirationDate', changedEventArgs.oldValue);
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_RROMSGATE_87972');
		}
        
    };