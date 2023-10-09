//Entity: Rates
    //Rates.signDefault (ComboBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SIGNMINPDDMQZST_831778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(1, entities.Rates, changeEventArgs);
        
    };