//Entity: CategoryReadjustment
    //CategoryReadjustment.Concept (ComboBox) View: DataCategory
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ATACATEGRY1904_COEP407 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.Category = true;
		loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
    };