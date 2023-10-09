//gridRowUpdating QueryView: GridExecutiveBonus
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_QRYXU8599_55 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            
        };