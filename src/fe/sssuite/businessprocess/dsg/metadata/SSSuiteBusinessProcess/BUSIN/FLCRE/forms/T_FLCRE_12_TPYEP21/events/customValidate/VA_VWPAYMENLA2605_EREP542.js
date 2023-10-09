//Entity: PaymentPlan
    //PaymentPlan.interestPeriod (TextInputBox) View: [object Object]
    
    task.customValidate.VA_VWPAYMENLA2605_EREP542 = function( entities, customValidateEventArgs ) {
        customValidateEventArgs.isValid = true 
		if(entities.PaymentPlan.interestPeriod == 0 ){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_SGPOIRESR_03363';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.interestPeriod > entities.PaymentPlan.capitalPeriod){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_GEOOITERS_08569';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.interestPeriod > entities.PaymentPlan.term){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_SERIDNTSO_70851';
			customValidateEventArgs.isValid = false;
		}   
    };