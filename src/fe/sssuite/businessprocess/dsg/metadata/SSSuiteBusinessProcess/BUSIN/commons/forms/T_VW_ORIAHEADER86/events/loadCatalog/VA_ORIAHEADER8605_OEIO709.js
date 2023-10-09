//Entity: EntidadInfo
    //EntidadInfo.otroDestino (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_OEIO709 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    };