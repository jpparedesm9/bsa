//gridRowDeleting QueryView: QV_1129_31576
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeletingCallback.QV_1129_31576 = function (entities,gridRowDeletingCallbackEventArgs) {
            gridRowDeletingCallbackEventArgs.commons.execServer = false;
            
        };