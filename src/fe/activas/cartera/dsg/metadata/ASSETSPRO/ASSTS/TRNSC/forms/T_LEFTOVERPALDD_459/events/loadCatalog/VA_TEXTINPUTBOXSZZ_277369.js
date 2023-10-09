//Entity: LeftOverPayment
    //LeftOverPayment.currencyType (ComboBox) View: LeftoverPaymentsModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXSZZ_277369 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.LeftOverPayment = true;
    };