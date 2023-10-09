//gridRowDeleting QueryView: QV_5973_95309
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_5973_95309 = function (entities,gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            //gridRowDeletingEventArgs.commons.serverParameters.Mobile = true;
        };