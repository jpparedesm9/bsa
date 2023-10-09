//Entity: PaymentPlan
    //PaymentPlan.quotaType (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_TATY621 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.changePaymentFrecuency(entities, changedEventArgs);	
        
    };