//Entity: AltairAccount
    //AltairAccount.newAccountIndividual (ComboBox) View: ReplaceAltairAccount
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_NEWACCOUNTINVUL_794715 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.AltairAccount = true;
    };