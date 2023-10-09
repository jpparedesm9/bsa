//Entity: PaymentPlan
    //PaymentPlan.term (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2607_TERM808 = function( entities, changedEventArgs ) {
		if(wasInInitData){
			changedEventArgs.commons.execServer = false;
			wasInInitData = false;
		}
		
		if(quotaHasChange){
			changedEventArgs.commons.execServer = false;
			quotaHasChange = false;
		}
		else{
			entities.PaymentPlan.quota = 0;
			changedEventArgs.commons.execServer = true;
			changedEventArgs.commons.serverParameters.PaymentPlan = true;
			changedEventArgs.commons.serverParameters.PaymentPlanHeader = true;
		}
        
    };