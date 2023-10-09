//Entity: PhysicalAddress
    //PhysicalAddress.parishCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXPPK_701436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
        if(mustRefreshParish){
            loadCatalogDataEventArgs.commons.execServer = true;
            mustRefreshParish=false;
        }else{
            loadCatalogDataEventArgs.commons.execServer = false;
        }
    };