//gridRowInserting QueryView: Borrowers
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
    task.gridRowInserting.QV_BOREG0798_55 = function (entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
        
    };