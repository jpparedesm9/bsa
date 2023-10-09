//gridAfterLeaveInLineRow QueryView: QV_2153_73215
//Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
task.gridAfterLeaveInLineRow.QV_2153_73215 = function (entities,gridAfterLeaveInLineRowEventArgs) {
    gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
    gridAfterLeaveInLineRowEventArgs.commons.api.grid.refresh('QV_2153_73215');      
};