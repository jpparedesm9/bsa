//Entity: GeneralParameterLoan
    //GeneralParameterLoan.exchangeRate (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2631_HNGE222 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.enableDisabledByExchangeRate(entities, changedEventArgs);
    };