//Entity: PaymentForm
    //PaymentForm.currencyId (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_4212YIFTVBCOPPD_140216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        entities.PaymentForm.currencyIdAux = entities.PaymentForm.currencyId;
    };