//gridRowInserting QueryView: QV_5241_65721
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_5241_65721 = function (entities,gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = true;
            gridRowInsertingEventArgs.commons.serverParameters.Terminal = true;
        };