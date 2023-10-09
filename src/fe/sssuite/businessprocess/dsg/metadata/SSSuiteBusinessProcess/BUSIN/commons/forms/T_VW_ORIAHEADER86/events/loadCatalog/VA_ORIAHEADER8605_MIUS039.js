//Entity: EntidadInfo
    //EntidadInfo.destEconomicoBusqueda (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_MIUS039 = function (loadCatalogDataEventArgs) {
        /*var loadEconomicDestination = false;
        if (loadCatalogDataEventArgs.config != null) {
            loadEconomicDestination = true;
            treeSelected = false;
        }
        if (loadEconomicDestination) {
            loadCatalogDataEventArgs.commons.execServer = true;
            loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
        } else {
            loadCatalogDataEventArgs.commons.execServer = false;
        }*/
        //SMO No existe en grupales
        loadCatalogDataEventArgs.commons.execServer = false;
        
    };