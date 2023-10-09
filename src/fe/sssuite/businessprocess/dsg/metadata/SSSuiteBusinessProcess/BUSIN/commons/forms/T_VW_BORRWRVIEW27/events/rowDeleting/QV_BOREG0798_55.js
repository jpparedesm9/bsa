//gridRowDeleting QueryView: Borrowers
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_BOREG0798_55 = function (entities,gridRowDeletingEventArgs) {    
			if(entities.OriginalHeader.IDRequested === undefined || entities.OriginalHeader.IDRequested === 0 ){
				gridRowDeletingEventArgs.commons.execServer = true;
			}else{
				gridRowDeletingEventArgs.commons.serverParameters.OriginalHeader = true;
				gridRowDeletingEventArgs.commons.serverParameters.DebtorGeneral = true;
			}            
        };