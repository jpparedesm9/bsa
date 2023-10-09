//Entity: ServerParameter
    //ServerParameter.refresGridFlag (CheckBox) View: ValueRates
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFRESGRIDFLGAA_521476 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.ServerParameter = true;
    };