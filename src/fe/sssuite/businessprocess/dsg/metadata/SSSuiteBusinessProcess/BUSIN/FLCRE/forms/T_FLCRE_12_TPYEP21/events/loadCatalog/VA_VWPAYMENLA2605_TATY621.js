//Entity: PaymentPlan
    //PaymentPlan.quotaType (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2605_TATY621 = function(loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
        
    };