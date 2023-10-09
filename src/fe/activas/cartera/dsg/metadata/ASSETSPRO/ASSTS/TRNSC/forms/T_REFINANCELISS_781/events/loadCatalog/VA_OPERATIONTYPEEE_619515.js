//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.operationType (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OPERATIONTYPEEE_619515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };