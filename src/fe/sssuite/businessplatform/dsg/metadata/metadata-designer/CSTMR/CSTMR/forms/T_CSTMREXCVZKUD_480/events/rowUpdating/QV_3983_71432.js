//gridRowUpdating QueryView: QV_3983_71432
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_3983_71432 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            //gridRowUpdatingEventArgs.commons.serverParameters.WarningRisk = true;
        };