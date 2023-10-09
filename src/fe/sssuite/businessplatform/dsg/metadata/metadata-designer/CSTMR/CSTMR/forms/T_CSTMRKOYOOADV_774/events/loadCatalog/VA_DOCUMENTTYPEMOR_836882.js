//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: ModificationCURPRFCForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_DOCUMENTTYPEMOR_836882 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };