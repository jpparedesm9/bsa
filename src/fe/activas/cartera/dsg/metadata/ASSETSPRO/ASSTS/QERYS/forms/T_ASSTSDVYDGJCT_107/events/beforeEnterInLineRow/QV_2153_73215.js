//gridBeforeEnterInLineRow QueryView: QV_2153_73215
//Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
task.gridBeforeEnterInLineRow.QV_2153_73215 = function (entities,gridBeforeEnterInLineRowEventArgs) {
    gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
    gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXWLC_118831');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_2153_73215', 'file');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_2153_73215', 'uploaded');
};