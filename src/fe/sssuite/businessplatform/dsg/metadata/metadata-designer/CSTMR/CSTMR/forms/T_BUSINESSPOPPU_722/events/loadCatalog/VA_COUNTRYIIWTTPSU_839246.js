//Entity: Business
    //Business.country (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_COUNTRYIIWTTPSU_839246 = function( loadCatalogDataEventArgs ) {
    
    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.Business = true;
};