//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyTypeAux (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CURRENCYTYPEUXU_869515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };