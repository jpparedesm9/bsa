//Entity: PhysicalAddress
    //PhysicalAddress.cityCode (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXQVZ_987436 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
        changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
        entities.PhysicalAddress.sameAddressHome = false;
        mustRefreshParish=true;
        if(entities.PhysicalAddress.cityCode!=''){
            changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXPPK_701436');
        }
        if(!postalCodeChanged){
            entities.PhysicalAddress.parishCode='';
                  entities.PhysicalAddress.postalCode='';

        }else{
            postalCodeChanged=false;
        }
    };