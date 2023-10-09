//gridRowDeleting QueryView: GridDistributionLine
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_QERIS7170_82 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            
        };