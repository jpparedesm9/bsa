//gridRowSelecting QueryView: QV_3009_96085
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_3009_96085 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = true;
        //gridRowSelectingEventArgs.commons.serverParameters.Loan = true;
    };