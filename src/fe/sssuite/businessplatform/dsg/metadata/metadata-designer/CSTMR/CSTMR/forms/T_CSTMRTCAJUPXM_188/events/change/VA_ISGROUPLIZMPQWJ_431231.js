//Entity: TransferRequest
//TransferRequest.isGroup (RadioButtonList) View: TransferRequestForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ISGROUPLIZMPQWJ_431231 = function (entities, changedEventArgs) {

    changedEventArgs.commons.execServer = false;
    if (entities.TransferRequest.isGroup === 'S') {
        changedEventArgs.commons.api.grid.showColumn('QV_9850_34524', 'creditAmount');
        changedEventArgs.commons.api.grid.showColumn('QV_9850_34524', 'weeksDelay');
        changedEventArgs.commons.api.viewState.disable('VA_MARKETTYPEMWHWP_950231');
        changedEventArgs.commons.api.viewState.disable('VA_ISALLNMRJFGEEEH_511231');
        entities.TransferRequest.marketType = null;
        entities.TransferRequest.isAll = 'N';
    } else {
        changedEventArgs.commons.api.grid.hideColumn('QV_9850_34524', 'creditAmount');
        changedEventArgs.commons.api.grid.hideColumn('QV_9850_34524', 'weeksDelay');
        changedEventArgs.commons.api.viewState.enable('VA_MARKETTYPEMWHWP_950231');
        changedEventArgs.commons.api.viewState.enable('VA_ISALLNMRJFGEEEH_511231');
    }
    //changedEventArgs.commons.api.grid.removeAllRows('CustomerTransferRequest');
    if (changedEventArgs.oldValue != null) {
        var filtro = {
            ejecucion: 0
        }
        changedEventArgs.commons.api.vc.parentVc = {}
        changedEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
        changedEventArgs.commons.api.grid.refresh("QV_9850_34524");
    }
};