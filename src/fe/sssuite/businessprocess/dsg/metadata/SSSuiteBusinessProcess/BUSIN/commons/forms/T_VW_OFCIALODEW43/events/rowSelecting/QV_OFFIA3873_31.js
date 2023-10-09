//gridRowSelecting QueryView: GridOfficialLoad
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_OFFIA3873_31 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };