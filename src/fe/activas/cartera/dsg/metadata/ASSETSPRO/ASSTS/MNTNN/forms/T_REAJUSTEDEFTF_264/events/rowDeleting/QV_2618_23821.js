//gridRowDeleting QueryView: QV_2618_23821
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_2618_23821 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        
    };