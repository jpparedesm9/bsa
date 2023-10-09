//Entity: WarrantyLocation
    //WarrantyLocation.parish (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    //Campo Parroquia
    task.loadCatalog.VA_ARANSCATIO0711_PARI601 = function(loadCatalogDataEventArgs ) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.WarrantyLocation = true;
        loadCatalogDataEventArgs.commons.execServer = true;        
    };