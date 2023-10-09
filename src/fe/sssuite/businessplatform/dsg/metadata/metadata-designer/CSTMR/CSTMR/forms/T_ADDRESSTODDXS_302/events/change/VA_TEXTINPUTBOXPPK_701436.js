//Entity: PhysicalAddress
    //PhysicalAddress.parishCode (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXPPK_701436 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
        changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
        entities.PhysicalAddress.sameAddressHome = false;
        if(entities.PhysicalAddress.postalCode=='' && entities.PhysicalAddress.parishCode!='' ){
            //obtener el código postal
            changedEventArgs.commons.execServer = true;
        }else{
            changedEventArgs.commons.execServer = false;        
        }
    };