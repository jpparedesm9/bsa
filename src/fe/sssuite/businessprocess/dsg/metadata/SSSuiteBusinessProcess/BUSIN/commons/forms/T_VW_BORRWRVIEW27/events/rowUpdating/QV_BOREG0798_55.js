//gridRowUpdating QueryView: Borrowers
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_BOREG0798_55 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            //no existe en grupales
            /*if (FLCRE.VARIABLES.Debtor.Role =='D' && gridRowUpdatingEventArgs.rowData.Role == 'C'){
				gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError('BUSIN.MSG_BUSIN_ESNECESLE_92181');
				gridRowUpdatingEventArgs.cancel = true;
            }else{
            	task.validateDebtor(entities, gridRowUpdatingEventArgs);	
            }*/
            
        };