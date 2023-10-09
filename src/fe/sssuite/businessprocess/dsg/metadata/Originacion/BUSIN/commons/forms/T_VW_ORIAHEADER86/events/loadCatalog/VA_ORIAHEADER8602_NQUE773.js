//Entity: OriginalHeader
    //OriginalHeader.PaymentFrequency (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8602_NQUE773 = function (loadCatalogEventArgs) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.OriginalHeader = true;

    };