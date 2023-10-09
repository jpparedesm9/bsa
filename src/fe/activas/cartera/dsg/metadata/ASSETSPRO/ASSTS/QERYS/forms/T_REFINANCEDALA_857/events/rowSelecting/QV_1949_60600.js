//gridRowSelecting QueryView: QV_1949_60600
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1949_60600 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };