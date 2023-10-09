//Entity: SyncFilter
    //SyncFilter.user (ComboBox) View: SyncManagementForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXCYY_583984 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.SyncFilter = true;
    };