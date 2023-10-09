//Entity: SpousePerson
    //SpousePerson.countryOfBirth (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COUNTRYOFBIRHTH_170739 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.SpousePerson = true;
    };