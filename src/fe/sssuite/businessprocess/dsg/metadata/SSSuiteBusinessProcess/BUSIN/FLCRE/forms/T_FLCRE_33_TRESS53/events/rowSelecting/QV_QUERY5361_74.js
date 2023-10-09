//gridRowSelecting QueryView: GridAddress
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_QUERY5361_74 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };