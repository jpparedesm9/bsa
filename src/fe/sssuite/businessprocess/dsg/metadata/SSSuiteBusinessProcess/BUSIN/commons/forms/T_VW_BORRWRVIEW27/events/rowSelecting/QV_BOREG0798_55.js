//gridRowSelecting QueryView: Borrowers
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
	task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { 
        //smo no debe lanzar
            gridRowSelectingEventArgs.commons.execServer = false;
	}