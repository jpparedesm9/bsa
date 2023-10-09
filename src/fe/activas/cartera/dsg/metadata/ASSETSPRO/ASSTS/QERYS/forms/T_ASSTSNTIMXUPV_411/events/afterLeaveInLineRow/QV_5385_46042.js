//gridAfterLeaveInLineRow QueryView: QV_5385_46042
//Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
task.gridAfterLeaveInLineRow.QV_5385_46042 = function (entities,gridAfterLeaveInLineRowEventArgs) {
    gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
    gridAfterLeaveInLineRowEventArgs.commons.api.grid.refresh('QV_5385_46042');
};