//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyType (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CURRENCYTYPETLZ_990515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };