//Entity: EntidadInfo
//EntidadInfo.termMedicalAssistance (ComboBox) View: T_HeaderView
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TERMMEDICALAISS_991R86 = function (loadCatalogDataEventArgs) {
    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
};