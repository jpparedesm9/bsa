//Entity: PhysicalAddress
    //PhysicalAddress.countryCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXOJR_474436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
    };