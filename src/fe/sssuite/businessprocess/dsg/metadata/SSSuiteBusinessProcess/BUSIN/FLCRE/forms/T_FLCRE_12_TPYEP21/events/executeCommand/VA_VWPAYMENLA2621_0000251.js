// (Button) 
 //.saveSession (Button) View: VWPaymentPlan
    task.executeCommand.VA_VWPAYMENLA2621_0000251 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
		entities.generalData.BUSSINESSINFORMATIONSTRINGONE = null;
		entities.generalData.OWNERIDENTIFIER = entities.PaymentPlanHeader.idRequested;
		
        executeCommandEventArgs.commons.serverParameters.generalData = true;
		executeCommandEventArgs.commons.serverParameters.OriginalHeader = true;
		executeCommandEventArgs.commons.serverParameters.PaymentPlanHeader = true;
    };