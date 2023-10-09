//Entity: Amount
//Amount.safePackage (ComboBox) View: AmountForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TEXTINPUTBOXYVS_120190 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.Amount = true;
};