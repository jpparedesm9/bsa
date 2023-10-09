//Entity: TransferRequest
//TransferRequest.marketType (ComboBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_MARKETTYPEMWHWP_950231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");
};