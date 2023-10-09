//Entity: WarrantyLocation
    //WarrantyLocation.accountingOffice (ComboBox) View: T_localizationView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ACCOUNTINGOFEIE_892E85 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.WarrantyLocation = true;
    };