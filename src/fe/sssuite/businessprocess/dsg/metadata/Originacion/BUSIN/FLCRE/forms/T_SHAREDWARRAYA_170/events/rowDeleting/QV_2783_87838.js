//gridRowDeleting QueryView: QV_2783_87838
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_2783_87838 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            
        };