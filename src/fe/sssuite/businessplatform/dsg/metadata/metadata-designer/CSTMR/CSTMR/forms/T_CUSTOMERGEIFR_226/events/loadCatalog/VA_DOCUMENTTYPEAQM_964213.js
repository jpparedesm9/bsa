//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: CustomerGeneralInfForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_DOCUMENTTYPEAQM_964213 = function( loadCatalogDataEventArgs ) {
        
        loadCatalogDataEventArgs.commons.execServer = true;
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };