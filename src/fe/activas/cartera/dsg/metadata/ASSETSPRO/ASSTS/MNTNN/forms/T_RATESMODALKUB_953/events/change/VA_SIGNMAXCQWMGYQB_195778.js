//Entity: Rates
    //Rates.signMax (ComboBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SIGNMAXCQWMGYQB_195778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(3, entities.Rates, changeEventArgs);
        
    };