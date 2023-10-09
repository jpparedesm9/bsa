//gridRowDeleting QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_9303_67123 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            //gridRowDeletingEventArgs.commons.serverParameters.VirtualAddress = true;
        };