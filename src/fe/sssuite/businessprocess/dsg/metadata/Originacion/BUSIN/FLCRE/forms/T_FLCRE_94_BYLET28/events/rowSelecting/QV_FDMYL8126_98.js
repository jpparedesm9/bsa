//gridRowSelecting QueryView: FixedTermByClient_Grd
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_FDMYL8126_98 = function (entities, gridRowSelectingEventArgs) {
           rowIndexTerm=gridRowSelectingEventArgs.rowIndex;
		console.log("rowIndexTerm"+rowIndexTerm);
        gridRowSelectingEventArgs.commons.execServer = false;
        gridRowSelectingEventArgs.commons.serverParameters.FixedTermOperation = true;
            
        };