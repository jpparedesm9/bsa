//gridRowSelecting QueryView: QV_2890_45043
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_2890_45043 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = true;
            //gridRowSelectingEventArgs.commons.serverParameters.RefinanceLoans = true;
        };