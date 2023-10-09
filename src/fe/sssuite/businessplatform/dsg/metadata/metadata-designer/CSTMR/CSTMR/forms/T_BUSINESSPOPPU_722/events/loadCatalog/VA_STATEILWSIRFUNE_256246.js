//Entity: Business
    //Business.state (ComboBox) View: BusinessPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_STATEILWSIRFUNE_256246 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.Business = true;
};