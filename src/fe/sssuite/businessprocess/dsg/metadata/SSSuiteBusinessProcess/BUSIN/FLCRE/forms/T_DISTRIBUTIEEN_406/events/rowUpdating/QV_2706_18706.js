//gridRowUpdating QueryView: QV_2706_18706
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_2706_18706 = function (entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
        
    };