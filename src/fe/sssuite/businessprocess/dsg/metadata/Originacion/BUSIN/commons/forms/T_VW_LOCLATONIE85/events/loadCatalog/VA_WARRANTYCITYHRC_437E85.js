//Entity: WarrantyLocation
//WarrantyLocation.warrantyCity (ComboBox) View: T_localizationView
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_WARRANTYCITYHRC_437E85 = function (loadCatalogDataEventArgs) {

    loadCatalogDataEventArgs.commons.execServer = false;

    //loadCatalogDataEventArgs.commons.serverParameters.WarrantyLocation = true;
};