//gridRowUpdating QueryView: GridCustomer
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_QRYLI5474_83 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            //gridRowUpdatingEventArgs.commons.serverParameters.CustomerSearch = true;
        };