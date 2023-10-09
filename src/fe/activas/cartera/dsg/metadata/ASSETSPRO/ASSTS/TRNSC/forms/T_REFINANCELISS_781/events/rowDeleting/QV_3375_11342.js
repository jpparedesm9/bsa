//gridRowDeleting QueryView: QV_3375_11342
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_3375_11342 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
        if (!entities.RefinanceLoanFilter.refreshData) {
            entities.RefinanceLoanFilter.refreshData = true;
        } else {
            entities.RefinanceLoanFilter.refreshData = false;
        }
    };