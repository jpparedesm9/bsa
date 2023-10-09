//Entity: Payment
    //Payment.currencyType (ComboBox) View: PaymentsForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CURRENCYSPEYFQA_285141 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.Payment = true;
    };