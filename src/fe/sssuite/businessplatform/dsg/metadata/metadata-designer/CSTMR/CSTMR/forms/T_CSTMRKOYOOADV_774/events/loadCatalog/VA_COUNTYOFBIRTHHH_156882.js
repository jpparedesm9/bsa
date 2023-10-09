//Entity: NaturalPerson
    //NaturalPerson.countyOfBirth (ComboBox) View: ModificationCURPRFCForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COUNTYOFBIRTHHH_156882 = function( loadCatalogDataEventArgs ) { 
        loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
        loadCatalogDataEventArgs.commons.serverParameters.Person = true;
        loadCatalogDataEventArgs.commons.execServer = true;
    };