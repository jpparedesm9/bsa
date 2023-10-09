//Entity: NaturalPerson
    //NaturalPerson.documentType (ComboBox) View: ModificationCURPRFCForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalogCallback.VA_DOCUMENTTYPEMOR_836882 = function(entities, loadCatalogCallbackDataEventArgs ) {
        loadCatalogCallbackDataEventArgs.commons.execServer = false;
    };