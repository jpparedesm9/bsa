//Entity: EconomicActivity
//EconomicActivity.economicActivity (ComboBox) View: EconomicActivityPopupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_ECONOMICACTIYTT_504887 = function( loadCatalogDataEventArgs ) {
    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.EconomicActivity = true;
};