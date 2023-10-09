//Entity: EconomicActivity
//EconomicActivity.subSector (ComboBox) View: EconomicActivityForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TEXTINPUTBOXMFJ_344376 = function( loadCatalogDataEventArgs ) {    
    loadCatalogDataEventArgs.commons.execServer = true;
    var model = loadCatalogDataEventArgs.commons.api.vc.model;
    gridRow = gridRow + 1;
    model.EconomicActivity._data[0].gridRow = gridRow;
    loadCatalogDataEventArgs.commons.serverParameters.EconomicActivity = true;
};