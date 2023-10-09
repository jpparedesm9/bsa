//Entity: EconomicActivity
//EconomicActivity.subSector (ComboBox) View: EconomicActivityPopupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_SUBSECTORFKJIRP_876887 = function( loadCatalogDataEventArgs ) {
    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.EconomicActivity = true;
};