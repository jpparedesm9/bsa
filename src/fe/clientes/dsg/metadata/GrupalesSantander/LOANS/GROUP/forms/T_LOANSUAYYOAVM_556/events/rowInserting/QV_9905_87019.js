//gridRowInserting QueryView: QV_9905_87019
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_9905_87019 = function (entities,gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = true;
            //gridRowInsertingEventArgs.commons.serverParameters.ExclusionListResult = true;
        };