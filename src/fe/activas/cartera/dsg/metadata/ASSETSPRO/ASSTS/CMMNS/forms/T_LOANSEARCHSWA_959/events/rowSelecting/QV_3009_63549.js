//gridRowSelecting QueryView: QV_3009_63549
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_3009_63549 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = true;
        //gridRowSelectingEventArgs.commons.serverParameters.Loan = true;
    };