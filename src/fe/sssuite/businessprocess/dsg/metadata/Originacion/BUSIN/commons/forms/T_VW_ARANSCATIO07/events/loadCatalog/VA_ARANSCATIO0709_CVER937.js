//Entity: WarrantyGeneral
    //WarrantyGeneral.coverage (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0709_CVER937 = function(loadCatalogEventArgs ) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.WarrantyGeneral = true;
        loadCatalogDataEventArgs.commons.execServer = true;
    };