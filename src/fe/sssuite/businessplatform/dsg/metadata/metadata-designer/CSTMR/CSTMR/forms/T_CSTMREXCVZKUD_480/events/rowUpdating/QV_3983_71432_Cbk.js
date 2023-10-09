//gridRowUpdating QueryView: QV_3983_71432
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdatingCallback.QV_3983_71432 = function (entities,gridRowUpdatingCallbackEventArgs) {
            gridRowUpdatingCallbackEventArgs.commons.execServer = false;
            gridRowUpdatingCallbackEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
           
        };
