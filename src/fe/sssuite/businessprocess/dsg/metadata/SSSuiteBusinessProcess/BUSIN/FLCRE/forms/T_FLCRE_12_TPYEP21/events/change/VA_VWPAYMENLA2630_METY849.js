//Entity: GeneralParameterLoan
    //GeneralParameterLoan.paymentType (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2630_METY849 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.enableDisabledByPaymentType(entities, changedEventArgs);
        
    };