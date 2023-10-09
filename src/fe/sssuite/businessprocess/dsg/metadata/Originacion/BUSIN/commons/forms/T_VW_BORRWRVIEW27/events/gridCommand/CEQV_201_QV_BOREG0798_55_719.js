//gridCommand (Button) QueryView: Borrowers
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;		
		if(FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(gridExecuteCommandEventArgs,true)){
			gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625');
		}
    };