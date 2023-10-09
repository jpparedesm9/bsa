//Entity: CreditCandidates
    //CreditCandidates.officerReassignedId (ComboBox) View: CreditCandidates
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXQAF_920782 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.CreditCandidates = true;
    };