//Entity: MethodsRetention
    //MethodsRetention.paymentMethods (ComboBox) View: PaymentMaintenanceModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_PAYMENTMETHODSD_816701 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.MethodsRetention = true;
    };