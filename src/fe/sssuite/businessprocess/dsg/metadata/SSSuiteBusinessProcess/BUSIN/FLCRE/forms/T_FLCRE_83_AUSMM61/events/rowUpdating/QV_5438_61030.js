//gridRowUpdating QueryView: QV_5438_61030
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_5438_61030 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            //gridRowUpdatingEventArgs.commons.serverParameters.MemberGroup = true;
        };