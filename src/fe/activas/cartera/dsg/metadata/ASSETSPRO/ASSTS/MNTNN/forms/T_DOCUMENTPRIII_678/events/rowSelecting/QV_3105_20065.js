//gridRowSelecting QueryView: QV_3105_20065
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_3105_20065 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };