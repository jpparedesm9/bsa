//Entity: EntidadInfo
    //EntidadInfo.tipoProducto (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_TIRC927 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
        loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
        loadCatalogDataEventArgs.commons.serverParameters.generalData = true;
    };