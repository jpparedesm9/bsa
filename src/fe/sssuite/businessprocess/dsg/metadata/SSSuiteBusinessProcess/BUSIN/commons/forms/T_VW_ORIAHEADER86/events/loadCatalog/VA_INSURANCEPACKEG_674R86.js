//Entity: EntidadInfo
    //EntidadInfo.insurancePackage (ComboBox) View: T_HeaderView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_INSURANCEPACKEG_674R86 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    };