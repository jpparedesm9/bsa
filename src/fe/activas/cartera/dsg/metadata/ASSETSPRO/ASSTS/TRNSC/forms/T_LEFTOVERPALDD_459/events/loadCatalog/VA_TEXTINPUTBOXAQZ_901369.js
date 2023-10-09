//Entity: LeftOverPayment
    //LeftOverPayment.paymentType (ComboBox) View: LeftoverPaymentsModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXAQZ_901369 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.LeftOverPayment = true;
    };