//gridRowUpdating QueryView: QV_5753_91072
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdatingCallback.QV_5753_91072 = function (entities,gridRowUpdatingCallbackEventArgs) {
            gridRowUpdatingCallbackEventArgs.commons.execServer = false;
            
        };