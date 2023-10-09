//Entity: CategoryReadjustment
    //CategoryReadjustment.AmountToApply (ComboBox) View: DataCategory
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ATACATEGRY1904_AOOP178 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.CategoryReadjustment = true;
		loadCatalogDataEventArgs.commons.serverParameters.Category = true; 
    };