//Entity: OriginalHeader
    //OriginalHeader.PaymentFrequency (ComboBox) View: T_HeaderView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_PAYMENTFREQUECN_439R86 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
    };