//Entity: EntidadInfo
    //EntidadInfo.sector (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_SETO998 = function(loadCatalogEventArgs ) {
       loadCatalogEventArgs.commons.execServer = true;
       loadCatalogEventArgs.commons.serverParameters.OriginalHeader = true;
       loadCatalogEventArgs.commons.serverParameters.generalData = true;
    };