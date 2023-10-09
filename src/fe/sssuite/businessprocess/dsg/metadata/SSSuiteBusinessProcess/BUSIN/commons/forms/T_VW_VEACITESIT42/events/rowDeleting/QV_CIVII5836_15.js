//gridRowDeleting QueryView: GridActivitiesList
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_CIVII5836_15 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            
        };