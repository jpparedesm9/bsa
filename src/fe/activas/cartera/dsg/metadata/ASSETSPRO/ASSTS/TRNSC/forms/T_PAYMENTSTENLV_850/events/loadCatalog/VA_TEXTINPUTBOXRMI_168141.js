//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: PaymentsForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXRMI_168141 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = false;
    
        //loadCatalogDataEventArgs.commons.serverParameters.CondonationDetail = true;
    };