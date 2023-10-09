//Entity: PhysicalAddress
    //PhysicalAddress.addressType (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXHGW_672436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
    };