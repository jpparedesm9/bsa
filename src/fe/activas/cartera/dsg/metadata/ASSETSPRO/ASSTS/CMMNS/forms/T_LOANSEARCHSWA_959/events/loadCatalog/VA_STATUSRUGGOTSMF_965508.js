//Entity: LoanSearchFilter
    //LoanSearchFilter.status (ComboBox) View: LoanSearchForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_STATUSRUGGOTSMF_965508 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
    loadCatalogEventArgs.commons.api.vc.model.LoanSearchFilter.category = queryString.category;
    loadCatalogEventArgs.commons.serverParameters.LoanSearchFilter = true;
    };