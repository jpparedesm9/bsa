//Entity: WarrantyDescription
    //WarrantyDescription.periodicity (ComboBox) View: WarrantyDescription
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_PERIODICITYETNZ_810235 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.WarrantyDescription = true;
    };