//Entity: Group
//Group.officer (ComboBox) View: GroupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TEXTINPUTBOXNBX_864725 = function( loadCatalogDataEventArgs ) {
    loadCatalogDataEventArgs.commons.execServer = true;    
    loadCatalogDataEventArgs.commons.serverParameters.Group = true;
};