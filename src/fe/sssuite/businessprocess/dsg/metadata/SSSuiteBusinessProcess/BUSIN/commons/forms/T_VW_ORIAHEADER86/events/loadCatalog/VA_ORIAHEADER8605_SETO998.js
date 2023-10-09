//Entity: EntidadInfo
    //EntidadInfo.sector (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_SETO998 = function(loadCatalogDataEventArgs) {// JRU//campos
																						// a
																						// definir
       loadCatalogDataEventArgs.commons.execServer = false;
       loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
       loadCatalogDataEventArgs.commons.serverParameters.generalData = true;
    };