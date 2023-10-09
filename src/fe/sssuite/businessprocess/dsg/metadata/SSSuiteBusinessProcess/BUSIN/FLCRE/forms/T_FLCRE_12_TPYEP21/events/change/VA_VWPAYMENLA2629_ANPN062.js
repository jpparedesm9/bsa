//Entity: GeneralParameterLoan
    //GeneralParameterLoan.acceptsAdditionalPayments (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2629_ANPN062 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.enableDisabledByAcceptsAdditionalPayments(entities, changedEventArgs);
        
    };