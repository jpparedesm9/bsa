//Entity: ParameterPrint
    //ParameterPrint.companyName (ComboBox) View: parameterPrintTask
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catÃ¡logo.
    task.loadCatalog.VA_2324HJLVWAVJDSM_147E35 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.serverParameters.OriginalHeader = true;
        loadCatalogEventArgs.commons.execServer = true;
    };