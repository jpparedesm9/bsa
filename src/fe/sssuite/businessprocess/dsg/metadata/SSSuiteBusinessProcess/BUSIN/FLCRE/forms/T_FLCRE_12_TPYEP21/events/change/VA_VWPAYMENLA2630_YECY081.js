//Entity: GeneralParameterLoan
    //GeneralParameterLoan.extraordinaryEffectPayment (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2630_YECY081 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.setMessageExtraordinaryEffectPayment(entities, changedEventArgs);
    };