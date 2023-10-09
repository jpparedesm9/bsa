//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.addicionalPayMethod (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ADDICIONALPAYOH_649515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };