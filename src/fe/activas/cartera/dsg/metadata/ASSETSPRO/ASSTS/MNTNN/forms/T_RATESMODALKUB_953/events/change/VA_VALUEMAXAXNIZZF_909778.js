//Entity: Rates
    //Rates.valueMax (TextInputBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VALUEMAXAXNIZZF_909778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(3, entities.Rates, changeEventArgs);
        
    };