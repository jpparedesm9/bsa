//gridRowInserting QueryView: GridActivitiesList
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_CIVII5836_15 = function (entities, gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = false;
            
        };