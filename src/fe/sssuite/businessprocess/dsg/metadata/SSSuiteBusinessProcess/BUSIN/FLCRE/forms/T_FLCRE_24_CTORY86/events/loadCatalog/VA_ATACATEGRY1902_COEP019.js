//Entity: Category
    //Category.Concept (ComboBox) View: DataCategory
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ATACATEGRY1902_COEP019 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.api.vc.serverParameters.Category = true;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
		serverParameters.PaymentPlanHeader = true;
        serverParameters.Category = true;
		loadCatalogDataEventArgs.commons.execServer = true;   
    };