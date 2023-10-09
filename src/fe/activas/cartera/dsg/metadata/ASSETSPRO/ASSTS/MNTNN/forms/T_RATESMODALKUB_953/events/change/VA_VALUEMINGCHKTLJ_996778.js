//Entity: Rates
    //Rates.valueMin (TextInputBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VALUEMINGCHKTLJ_996778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(2, entities.Rates, changeEventArgs);
        
    };