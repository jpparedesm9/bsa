//gridBeforeEnterInLineRow QueryView: GridRefinancingOperations
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
    task.gridBeforeEnterInLineRow.QV_ITRIC1523_63 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','OperationBank');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','CurrencyOperation');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','Balance');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','LocalCurrencyBalance');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','OriginalAmount');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','LocalCurrencyAmount');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','CreditType');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','DateGranting');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_ITRIC1523_63','Moratory');
    };