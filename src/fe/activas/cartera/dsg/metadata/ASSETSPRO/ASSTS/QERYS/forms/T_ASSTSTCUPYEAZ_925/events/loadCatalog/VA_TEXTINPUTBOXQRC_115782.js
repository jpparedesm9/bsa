//Entity: CreditCandidates
    //CreditCandidates.officerAssignedId (ComboBox) View: CreditCandidates
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXQRC_115782 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.CreditCandidates = true;
    };