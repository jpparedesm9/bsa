//Entity: PaymentPlan
    //PaymentPlan.fixedpPaymentDate (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_ATTE607 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.setFechaPagoFija(entities.PaymentPlan, changedEventArgs.commons.api.viewState);
        
    };