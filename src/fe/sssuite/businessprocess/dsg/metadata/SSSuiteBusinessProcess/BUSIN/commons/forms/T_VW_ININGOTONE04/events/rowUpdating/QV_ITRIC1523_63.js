//gridRowUpdating QueryView: GridRefinancingOperations
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_ITRIC1523_63 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = true;		
        gridRowUpdatingEventArgs.commons.serverParameters.RefinancingOperations = true;
    };