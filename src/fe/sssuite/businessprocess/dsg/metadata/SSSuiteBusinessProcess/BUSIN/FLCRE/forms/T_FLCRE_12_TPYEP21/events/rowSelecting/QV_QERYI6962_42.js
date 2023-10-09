//gridRowSelecting QueryView: GridCategoryItemsNew
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_QERYI6962_42 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            gridRowSelectingEventArgs.commons.serverParameters.CategoryNew = true;
        };