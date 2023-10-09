//Entity: Rates
    //Rates.signMin (ComboBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SIGNMINKUSGFZGN_277778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(2, entities.Rates, changeEventArgs);
        
    };