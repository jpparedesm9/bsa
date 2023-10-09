//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyType (ComboBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_CURRENCYTYPETLZ_990515 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        entities.RefinanceLoanFilter.currencyTypeAux = entities.RefinanceLoanFilter.currencyType;
    };