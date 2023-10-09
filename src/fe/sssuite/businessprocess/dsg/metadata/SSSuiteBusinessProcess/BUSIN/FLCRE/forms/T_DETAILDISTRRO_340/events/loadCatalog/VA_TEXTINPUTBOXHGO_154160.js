//Entity: DistributionEntity
//DistributionEntity.producto (ComboBox) View: undefined

//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.

task.loadCatalog.VA_TEXTINPUTBOXHGO_154160 = function(loadCatalogEventArgs ) {
    loadCatalogEventArgs.commons.execServer = false;
    // loadCatalogEventArgs.commons.serverParameters.DistributionEntity = true;
};