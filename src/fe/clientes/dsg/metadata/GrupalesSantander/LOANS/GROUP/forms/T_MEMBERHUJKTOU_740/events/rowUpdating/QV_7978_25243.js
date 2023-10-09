//gridRowUpdating QueryView: QV_7978_25243
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_7978_25243 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            //gridRowUpdatingEventArgs.commons.serverParameters.Member = true;
        };