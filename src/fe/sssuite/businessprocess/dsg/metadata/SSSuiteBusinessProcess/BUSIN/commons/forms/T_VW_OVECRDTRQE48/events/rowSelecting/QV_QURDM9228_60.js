//gridRowSelecting QueryView: GridDisbursementForms
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_QURDM9228_60 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };