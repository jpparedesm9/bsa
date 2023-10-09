//Entity: PhysicalAddress
    //PhysicalAddress.cityCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXQVZ_987436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
        if(mustRefreshCity){
                loadCatalogDataEventArgs.commons.execServer = true;
            mustRefreshCity=false;
        }else{
                loadCatalogDataEventArgs.commons.execServer = false;        
        }
    };