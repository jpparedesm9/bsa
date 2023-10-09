//Entity: WarrantyLocation
    //WarrantyLocation.province (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    //Campo Provincia
    task.loadCatalog.VA_ARANSCATIO0711_RVNE334 = function(loadCatalogDataEventArgs ) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.WarrantyLocation = true;
        loadCatalogDataEventArgs.commons.execServer = true;
    };