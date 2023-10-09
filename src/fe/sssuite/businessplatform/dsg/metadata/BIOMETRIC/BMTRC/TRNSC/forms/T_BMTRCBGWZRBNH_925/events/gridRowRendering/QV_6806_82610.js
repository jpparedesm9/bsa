//gridRowRendering QueryView: QV_6806_82610
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6806_82610 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;

    if (gridRowRenderingEventArgs.rowData.withoutFingerprint == false) {
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6806_82610', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNAN_197515');
    } else {
        gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_6806_82610', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNAN_197515');
    }
};