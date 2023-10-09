//Entity: HeaderQueryDocuments
//HeaderQueryDocuments.documentType (ComboBox) View: QueryDocumentsByFilter
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_DOCUMENTTYPEVHQ_629698 = function (loadCatalogDataEventArgs) {

    loadCatalogDataEventArgs.commons.execServer = true;

    //loadCatalogDataEventArgs.commons.serverParameters.HeaderQueryDocuments = true;
};