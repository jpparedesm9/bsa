//Entity: Payment
    //Payment.paymentType (ComboBox) View: PaymentsForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXCFY_310141 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;        
        //changeEventArgs.commons.serverParameters.Payment = true;
    };