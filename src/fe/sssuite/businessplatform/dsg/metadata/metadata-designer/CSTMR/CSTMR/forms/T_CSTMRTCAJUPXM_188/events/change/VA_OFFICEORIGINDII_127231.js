//Entity: TransferRequest
//TransferRequest.officeOriginId (ComboBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_OFFICEORIGINDII_127231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");
};