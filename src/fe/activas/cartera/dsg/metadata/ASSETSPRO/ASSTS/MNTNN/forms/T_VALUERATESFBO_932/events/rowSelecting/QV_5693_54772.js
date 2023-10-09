//gridRowSelecting QueryView: QV_5693_54772
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5693_54772 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = true;
        //gridRowSelectingEventArgs.commons.serverParameters.Rates = true;
    };