//Entity: PaymentPlan
    //PaymentPlan.term (TextInputBox) View: [object Object]
    
    task.customValidate.VA_VWPAYMENLA2607_TERM808 = function( entities, customValidateEventArgs ) {
		customValidateEventArgs.isValid = true 
		
		if(entities.PaymentPlan.term == 0 ){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_MSGROPOMA_02416';
			customValidateEventArgs.isValid = false;
		}  
    };