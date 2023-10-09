//Entity: CollectiveRole
    //CollectiveRole.collective (ComboBox) View: CollectiveAdvisorsRoles
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COLLECTIVESPPQW_866380 = function( loadCatalogDataEventArgs ) {

        loadCatalogDataEventArgs.commons.execServer = true;
    
        loadCatalogDataEventArgs.commons.serverParameters.CollectiveRole = true;
    };