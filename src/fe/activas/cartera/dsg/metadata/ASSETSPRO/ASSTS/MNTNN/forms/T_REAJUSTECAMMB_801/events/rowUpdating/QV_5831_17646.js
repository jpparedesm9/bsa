//gridRowUpdating QueryView: QV_5831_17646
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_5831_17646 = function (entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = true;
        //gridRowUpdatingEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
    };