//Entity: PhysicalAddress
    //PhysicalAddress.provinceCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalogCallback.VA_TEXTINPUTBOXTCU_205436 = function( entities, loadCatalogCallbackEventArgs ) {
        loadCatalogCallbackEventArgs.commons.execServer = false;
        if(loadCatalogCallbackEventArgs.commons.api.vc.mode!=loadCatalogCallbackEventArgs.commons.constants.mode.Update){
            loadCatalogCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXQVZ_987436');
        }
    };