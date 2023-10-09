//gridRowDeleting QueryView: QV_7269_22799
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_7269_22799 = function (entities, gridRowDeletingEventArgs) {
    gridRowDeletingEventArgs.commons.execServer = true;
            
    gridRowDeletingEventArgs.commons.serverParameters.References = true;
};