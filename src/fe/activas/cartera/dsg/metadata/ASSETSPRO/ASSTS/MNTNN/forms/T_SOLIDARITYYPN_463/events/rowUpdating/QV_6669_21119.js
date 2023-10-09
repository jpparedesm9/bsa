//gridRowUpdating QueryView: QV_6669_21119
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_6669_21119 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            //gridRowUpdatingEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
        };