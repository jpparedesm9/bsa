//Entity: WarrantyLocation
//WarrantyLocation.documentCity (ComboBox) View: T_localizationView
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_DOCUMENTCITYYOL_507E85 = function (loadCatalogDataEventArgs) {

    loadCatalogDataEventArgs.commons.execServer = false;

    //loadCatalogDataEventArgs.commons.serverParameters.WarrantyLocation = true;
};