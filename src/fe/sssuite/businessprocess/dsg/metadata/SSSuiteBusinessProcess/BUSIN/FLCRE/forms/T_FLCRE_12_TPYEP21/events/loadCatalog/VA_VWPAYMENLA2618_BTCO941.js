//Entity: PaymentPlanHeader
    //PaymentPlanHeader.debitAccount (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2618_BTCO941 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
        
    };