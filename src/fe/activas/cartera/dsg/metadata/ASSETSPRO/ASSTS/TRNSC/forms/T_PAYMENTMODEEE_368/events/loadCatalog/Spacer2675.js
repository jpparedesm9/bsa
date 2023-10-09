//Entity: PaymentForm
    //PaymentForm.payFormId (ComboBox) View: PaymentModeForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.Spacer2675 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.PaymentForm = true;
    };