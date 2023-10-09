//Entity: EntidadInfo
//EntidadInfo.otroDestino (ComboBox) View: [object Object]
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_ORIAHEADER8605_OEIO709 = function (loadCatalogEventArgs) {
    loadCatalogEventArgs.commons.execServer = true;
    loadCatalogEventArgs.commons.serverParameters.EntidadInfo = true;

};