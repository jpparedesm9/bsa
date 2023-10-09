//Entity: OfficerAnalysis
//OfficerAnalysis.City (ComboBox) View: [object Object]
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function (loadCatalogEventArgs) {
    loadCatalogEventArgs.commons.execServer = true;
    var serverParameters = loadCatalogEventArgs.commons.api.vc.serverParameters;
    serverParameters.OfficerAnalysis = true;

};