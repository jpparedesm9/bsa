//gridRowInserting QueryView: QV_7978_25243
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_7978_25243 = function (entities, gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = false;
            //gridRowInsertingEventArgs.commons.serverParameters.Member = true;
        };