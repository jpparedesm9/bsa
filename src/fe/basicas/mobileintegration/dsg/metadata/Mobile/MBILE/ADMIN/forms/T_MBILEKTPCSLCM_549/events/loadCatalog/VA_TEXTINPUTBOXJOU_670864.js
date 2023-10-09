//Entity: Mobile
    //Mobile.official (ComboBox) View: MobilePopUpForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXJOU_670864 = function( loadCatalogDataEventArgs ) {

        loadCatalogDataEventArgs.commons.execServer = true;
        
        loadCatalogDataEventArgs.commons.serverParameters.Mobile = true;
    };