//Entity: WarrantyLocation
    //WarrantyLocation.parish (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0711_PARI601 = function(loadCatalogEventArgs ) {
        var serverParameters = loadCatalogEventArgs.commons.api.vc.serverParameters;
        serverParameters.WarrantyLocation = true;
        loadCatalogEventArgs.commons.execServer = true;
        
    };