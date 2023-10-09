//gridRowUpdating QueryView: QV_5241_65721
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_5241_65721 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            gridRowUpdatingEventArgs.commons.serverParameters.Terminal = true;
        };