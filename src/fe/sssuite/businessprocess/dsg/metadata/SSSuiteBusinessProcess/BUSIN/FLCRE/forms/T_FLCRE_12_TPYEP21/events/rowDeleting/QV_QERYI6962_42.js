//gridRowDeleting QueryView: GridCategoryItemsNew
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_QERYI6962_42 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            gridRowDeletingEventArgs.commons.serverParameters.CategoryNew = true;
        };