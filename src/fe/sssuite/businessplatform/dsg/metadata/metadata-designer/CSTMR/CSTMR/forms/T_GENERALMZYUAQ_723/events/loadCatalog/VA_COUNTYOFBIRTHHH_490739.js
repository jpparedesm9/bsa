//Entity: NaturalPerson
    //NaturalPerson.countyOfBirth (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_COUNTYOFBIRTHHH_490739 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.NaturalPerson = true;
    };