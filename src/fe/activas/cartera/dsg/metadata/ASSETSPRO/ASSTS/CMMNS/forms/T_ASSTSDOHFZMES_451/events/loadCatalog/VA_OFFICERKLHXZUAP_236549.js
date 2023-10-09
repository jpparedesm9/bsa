//Entity: LoanSearchFilter
    //LoanSearchFilter.officer (ComboBox) View: LoanSearchGroupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFFICERKLHXZUAP_236549 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.LoanSearchFilter = true;
    };