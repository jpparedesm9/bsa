//gridBeforeEnterInLineRow QueryView: QV_5385_46042
//Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
task.gridBeforeEnterInLineRow.QV_5385_46042 = function (entities,gridBeforeEnterInLineRowEventArgs) {
    gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
    gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXSYD_837273');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_5385_46042', 'file');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_5385_46042', 'uploaded');
};