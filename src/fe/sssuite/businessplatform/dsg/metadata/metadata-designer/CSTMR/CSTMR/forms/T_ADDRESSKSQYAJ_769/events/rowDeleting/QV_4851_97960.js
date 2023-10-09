//gridRowDeleting QueryView: QV_4851_97960
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_4851_97960 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            gridRowDeletingEventArgs.commons.serverParameters.PhysicalAddress = true;
        };