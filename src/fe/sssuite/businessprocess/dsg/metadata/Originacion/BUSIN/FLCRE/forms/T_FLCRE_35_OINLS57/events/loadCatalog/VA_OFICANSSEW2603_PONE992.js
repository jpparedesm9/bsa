//Entity: OfficerAnalysis
    //OfficerAnalysis.Province (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFICANSSEW2603_PONE992 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.OfficerAnalysis = true;
    };