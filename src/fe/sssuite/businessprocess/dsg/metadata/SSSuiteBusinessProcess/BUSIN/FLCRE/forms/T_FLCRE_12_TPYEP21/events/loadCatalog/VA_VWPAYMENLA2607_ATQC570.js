//Entity: PaymentPlan
    //PaymentPlan.termType (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2607_ATQC570 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
    };