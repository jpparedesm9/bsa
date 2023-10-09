//gridRowRendering QueryView: QV_7316_54056
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7316_54056 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;

    if (clienteId == 0) {
        entities.CallCenterQuestion._data = null;
    }
    else {
        if (entities.CallCenterQuestion._data.length > 0) {
            gridRowRenderingEventArgs.commons.api.viewState.show('VA_VABUTTONPDDCALJ_814912');
        }
    }

};