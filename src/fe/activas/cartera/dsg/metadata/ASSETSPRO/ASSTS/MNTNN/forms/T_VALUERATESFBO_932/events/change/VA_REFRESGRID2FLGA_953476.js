//Entity: ServerParameter
    //ServerParameter.refresGrid2Flag (CheckBox) View: ValueRates
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFRESGRID2FLGA_953476 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.ServerParameter = true;
    };