//Entity: MethodsRetention
    //MethodsRetention.bankServices (ComboBox) View: PaymentMaintenanceModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_BANKSERVICESDQR_160701 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = false;
        //loadCatalogEventArgs.commons.serverParameters.MethodsRetention = true;
    };