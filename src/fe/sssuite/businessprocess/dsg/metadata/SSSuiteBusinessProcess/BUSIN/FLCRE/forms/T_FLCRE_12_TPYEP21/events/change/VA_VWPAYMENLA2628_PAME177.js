//Entity: GeneralParameterLoan
    //GeneralParameterLoan.payment (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2628_PAME177 = function( entities, changedEventArgs ) {
       changedEventArgs.commons.execServer = false;
       task.setMessagePayment(entities, changedEventArgs);
        
    };