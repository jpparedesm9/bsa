//Entity: EntidadInfo
    //EntidadInfo.destinoFinanciero (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_OCRI261 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;        
		loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
		loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    };