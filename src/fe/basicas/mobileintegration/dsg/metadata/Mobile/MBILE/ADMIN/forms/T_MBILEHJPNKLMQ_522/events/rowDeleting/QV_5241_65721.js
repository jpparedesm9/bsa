//gridRowDeleting QueryView: QV_5241_65721
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_5241_65721 = function (entities,gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            gridRowDeletingEventArgs.commons.serverParameters.Terminal = true;
        };