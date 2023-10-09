//Entity: GeneralParameterLoan
    //GeneralParameterLoan.interestPayment (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2628_ETME049 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;		
		task.setMessageInterestPayment(entities, changedEventArgs);
        
    };