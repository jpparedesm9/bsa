//Entity: WarrantyLocation
    //WarrantyLocation.city (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    //Campo Ciudad
    task.loadCatalog.VA_ARANSCATIO0711_CITY886 = function(loadCatalogDataEventArgs ) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.WarrantyLocation = true;
        loadCatalogDataEventArgs.commons.execServer = true;
    };