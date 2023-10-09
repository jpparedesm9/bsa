//gridRowDeleting QueryView: QV_6114_93961
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_6114_93961 = function (entities, gridRowDeletingEventArgs) {
        if (banBorrado==true ){
            if (gridRowDeletingEventArgs.rowData.secuentialPersonLeft ==0 ||        gridRowDeletingEventArgs.rowData.secuentialPersonRight == 0 ){
				gridRowDeletingEventArgs.commons.execServer = false;
				gridRowDeletingEventArgs.commons.messageHandler.showMessagesError('Error, datos inconsistentes',true);
			}
			else{
				gridRowDeletingEventArgs.commons.execServer = true;
				gridRowDeletingEventArgs.commons.serverParameters.RelationPerson = true;
				gridRowDeletingEventArgs.commons.serverParameters.RelationContext = true;
			}
            //banBorrado=false;            
        }
        else{
            gridRowDeletingEventArgs.commons.execServer = false;
        }
        };