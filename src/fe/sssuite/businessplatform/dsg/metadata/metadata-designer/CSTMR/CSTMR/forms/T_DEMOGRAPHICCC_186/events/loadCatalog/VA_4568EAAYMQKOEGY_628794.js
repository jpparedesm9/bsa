//Entity: DemographicData
    //DemographicData.residenceCountry (ComboBox) View: DemographicForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_4568EAAYMQKOEGY_628794 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.DemographicData = true;
    };