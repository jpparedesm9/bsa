//Entity: TransferRequest
//TransferRequest.isAll (CheckBox) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ISALLNMRJFGEEEH_511231 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    entities.TransferRequest.marketType = null;
    changedEventArgs.commons.api.grid.removeAllRows("CustomerTransferRequest");

    if (entities.TransferRequest.isGroup !== 'S') {
        if (entities.TransferRequest.isAll == 'S') {
            changedEventArgs.commons.api.viewState.disable('VA_MARKETTYPEMWHWP_950231');
        } else {
            changedEventArgs.commons.api.viewState.enable('VA_MARKETTYPEMWHWP_950231');
        }
    }
};