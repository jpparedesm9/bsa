//gridRowSelecting QueryView: GridRefinancingOperationsModal
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_ITRIC1523_25 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };