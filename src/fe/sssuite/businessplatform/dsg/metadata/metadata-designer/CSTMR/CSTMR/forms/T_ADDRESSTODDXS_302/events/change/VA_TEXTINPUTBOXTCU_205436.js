//Entity: PhysicalAddress
    //PhysicalAddress.provinceCode (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXTCU_205436 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
        changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
        entities.PhysicalAddress.sameAddressHome = false;
        mustRefreshCity=true;
        if(entities.PhysicalAddress.provinceCode!=''){
            changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXQVZ_987436'); 
        }
        if(!postalCodeChanged){
            entities.PhysicalAddress.postalCode='';
            entities.PhysicalAddress.cityCode='';
        }
    };