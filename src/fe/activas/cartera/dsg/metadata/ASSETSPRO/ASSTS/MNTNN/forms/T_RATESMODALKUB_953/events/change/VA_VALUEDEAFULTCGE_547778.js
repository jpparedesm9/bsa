//Entity: Rates
    //Rates.valueDeafult (TextInputBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VALUEDEAFULTCGE_547778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(1, entities.Rates, changeEventArgs);
        
    };