//Entity: NaturalPerson
    //NaturalPerson.nationalityCode (ComboBox) View: CustomerGeneralInfForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_NATIONALITYCEDE_860213 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };