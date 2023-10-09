//Entity: Payment
    //Payment.paymentType (ComboBox) View: PaymentsForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXCFY_310141 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;        
        loadCatalogEventArgs.commons.serverParameters.Loan = true;
    };