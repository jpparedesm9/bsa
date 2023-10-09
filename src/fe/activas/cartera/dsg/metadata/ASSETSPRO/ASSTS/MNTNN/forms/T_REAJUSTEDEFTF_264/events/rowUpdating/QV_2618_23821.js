//gridRowUpdating QueryView: QV_2618_23821
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_2618_23821 = function (entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = true;
        
    };