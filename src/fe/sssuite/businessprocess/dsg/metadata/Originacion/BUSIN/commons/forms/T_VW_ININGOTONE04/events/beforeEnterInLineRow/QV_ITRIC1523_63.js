//gridBeforeEnterInLineRow QueryView: GridRefinancingOperations
//Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
task.gridBeforeEnterInLineRow.QV_ITRIC1523_63 = function (entities, gridBeforeEnterInLineRowEventArgs) {
    gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'OperationBank');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'CurrencyOperation');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'Balance');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'LocalCurrencyBalance');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'OriginalAmount');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'LocalCurrencyAmount');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'CreditType');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'DateGranting');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63', 'Moratory');

};