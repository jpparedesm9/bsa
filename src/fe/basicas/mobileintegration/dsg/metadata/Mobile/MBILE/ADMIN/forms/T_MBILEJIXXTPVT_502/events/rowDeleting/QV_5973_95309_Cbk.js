//gridRowDeleting QueryView: QV_5973_95309
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeletingCallback.QV_5973_95309 = function (entities,gridRowDeletingCallbackEventArgs) {
            gridRowDeletingCallbackEventArgs.commons.execServer = false;
            
        };