//Entity: PaymentPlan
    //PaymentPlan.interestPeriodGrace (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_EACE223 = function( entities, changedEventArgs ) {
        var api = changedEventArgs.commons.api;
        changedEventArgs.commons.execServer = false;
        task.enableDiableQuotaInterest(entities, changedEventArgs);
        
    };