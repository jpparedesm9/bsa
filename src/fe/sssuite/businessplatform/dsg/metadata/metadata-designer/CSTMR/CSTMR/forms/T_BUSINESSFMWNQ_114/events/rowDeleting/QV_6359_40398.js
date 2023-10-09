//gridRowDeleting QueryView: QV_6359_40398
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_6359_40398 = function (entities, gridRowDeletingEventArgs) {
    gridRowDeletingEventArgs.commons.execServer = true;
    
    gridRowDeletingEventArgs.commons.serverParameters.Business = true;
};