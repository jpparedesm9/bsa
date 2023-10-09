//Entity: PaymentPlan
    //PaymentPlan.capitalPeriod (TextInputBox) View: [object Object]
    
    task.customValidate.VA_VWPAYMENLA2605_PILO354 = function( entities, customValidateEventArgs ) {
        customValidateEventArgs.isValid = true 
		if(entities.PaymentPlan.capitalPeriod == 0 ){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_PODITALMR_32371';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.capitalPeriod < entities.PaymentPlan.interestPeriod){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_SGPECPIAL_40032';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.capitalPeriod > entities.PaymentPlan.term){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_GRREDAPLZ_88107';
			customValidateEventArgs.isValid = false;
		}   
    };