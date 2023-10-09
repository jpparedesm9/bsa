//Entity: TransferRequest
//TransferRequest.officialOriginId (ComboBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_OFFICIALORIGIII_648231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");
};