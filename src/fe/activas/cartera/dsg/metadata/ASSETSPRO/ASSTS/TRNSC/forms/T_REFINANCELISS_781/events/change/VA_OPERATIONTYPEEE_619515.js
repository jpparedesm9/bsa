//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.operationType (ComboBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OPERATIONTYPEEE_619515 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };