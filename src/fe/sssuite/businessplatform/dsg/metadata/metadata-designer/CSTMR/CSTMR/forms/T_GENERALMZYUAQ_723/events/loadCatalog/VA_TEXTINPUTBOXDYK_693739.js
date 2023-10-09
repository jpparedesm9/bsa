//Entity: SpousePerson
    //SpousePerson.documentType (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXDYK_693739 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.SpousePerson = true;
    };