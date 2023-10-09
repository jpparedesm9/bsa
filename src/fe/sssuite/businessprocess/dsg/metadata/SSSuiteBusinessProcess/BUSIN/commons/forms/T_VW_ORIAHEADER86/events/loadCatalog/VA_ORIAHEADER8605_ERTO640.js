//Entity: EntidadInfo
    //EntidadInfo.lineaCredito (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_ERTO640 = function(loadCatalogDataEventArgs) {
       loadCatalogDataEventArgs.commons.execServer = false; //false en grupales
        // loadCatalogDataEventArgs.commons.execServer = true;
		loadCatalogDataEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };