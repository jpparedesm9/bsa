//Entity: OriginalHeader
    //OriginalHeader.PaymentFrequency (ComboBox) View: T_HeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PAYMENTFREQUECN_439R86 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = true;
    
        //changedEventArgs.commons.serverParameters.OriginalHeader = true;
    };