//gridRowDeleting QueryView: QV_5831_17646
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_5831_17646 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        //gridRowDeletingEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
    };