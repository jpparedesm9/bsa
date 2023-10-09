//gridRowDeleting QueryView: GridOtherWarranty
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_URYTH5890_66 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
        
    };