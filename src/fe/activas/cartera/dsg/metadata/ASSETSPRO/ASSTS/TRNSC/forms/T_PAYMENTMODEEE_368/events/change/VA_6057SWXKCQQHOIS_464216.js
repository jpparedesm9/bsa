//Entity: PaymentForm
    //PaymentForm.currencyIdAux (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_6057SWXKCQQHOIS_464216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        entities.PaymentForm.currencyFlagAux = '1';
        
    };