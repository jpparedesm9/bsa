//Entity: CollectiveRole
    //CollectiveRole.official (ComboBox) View: CollectiveAdvisorsRoles
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFFICIALYYQHLMI_968380 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
        if(activate){
            loadCatalogDataEventArgs.commons.execServer = true;
        }
        loadCatalogDataEventArgs.commons.serverParameters.CollectiveRole = true;
    };