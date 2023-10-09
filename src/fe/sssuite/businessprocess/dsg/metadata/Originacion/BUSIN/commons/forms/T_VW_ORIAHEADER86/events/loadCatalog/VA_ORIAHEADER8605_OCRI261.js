//Entity: EntidadInfo
    //EntidadInfo.destinoFinanciero (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_OCRI261 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;        
		loadCatalogEventArgs.commons.serverParameters.OriginalHeader = true;
		loadCatalogEventArgs.commons.serverParameters.EntidadInfo = true;
        
    };