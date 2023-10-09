// (Button) 
    task.executeCommand.VA_VWPAYMENLA2621_0000855 = function( entities, executeCommandEventArgs ) {
		var numErrors1 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_25', true);
		var numErrors2 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_28', true);
		var numErrors3 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_29', true);
		var numErrors4 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_30', true);
		var numErrors5 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_31', true);
		var numErrors6 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_32', true);
		var numErrors7 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_33', true);
		
		
		if(entities.GeneralParameterLoan.exchangeRate == 'N'){
			numErrors6 = 0;
		}		
		if(numErrors1==0 && numErrors2==0 && numErrors3==0 && numErrors4==0 && numErrors5==0 && numErrors6==0&& numErrors7==0){
			executeCommandEventArgs.commons.execServer = true;
			executeCommandEventArgs.commons.serverParameters.GeneralParameterLoan = true;
			executeCommandEventArgs.commons.serverParameters.PaymentPlanHeader = true;
		}else{
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ESICINSPG_05163',null,10000);
		}
    };