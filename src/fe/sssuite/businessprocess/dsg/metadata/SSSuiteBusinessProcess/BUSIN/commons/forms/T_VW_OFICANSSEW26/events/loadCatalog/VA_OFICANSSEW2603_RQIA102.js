//Entity: OfficerAnalysis
    //OfficerAnalysis.Parroquia (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFICANSSEW2603_RQIA102 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.OfficerAnalysis = true;
    };