//Entity: PhysicalAddress
    //PhysicalAddress.addressType (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXHGW_672436 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
        
        task.validateBusiness(entities, changedEventArgs);
        
    };