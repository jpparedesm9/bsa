//Entity: ServerParameter
    //ServerParameter.refresGridFlag (CheckBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFRESGRIDFLGAG_672778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.ServerParameter = true;
    };