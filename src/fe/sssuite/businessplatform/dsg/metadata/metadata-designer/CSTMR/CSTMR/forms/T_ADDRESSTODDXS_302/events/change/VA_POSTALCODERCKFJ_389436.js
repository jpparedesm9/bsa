//Entity: PhysicalAddress
//PhysicalAddress.postalCode (TextInputBox) View: AddressPopupForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_POSTALCODERCKFJ_389436 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = true;
    changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
    changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
    entities.PhysicalAddress.sameAddressHome = false;
    if (entities.PhysicalAddress.postalCode == '') {
        changedEventArgs.commons.execServer = false;
    }
    entities.PhysicalAddress.latitude = 0;
    entities.PhysicalAddress.longitude = 0;
};