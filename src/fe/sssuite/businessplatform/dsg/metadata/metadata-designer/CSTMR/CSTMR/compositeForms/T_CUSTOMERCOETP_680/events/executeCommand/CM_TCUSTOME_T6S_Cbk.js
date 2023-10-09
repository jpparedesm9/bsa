//Start signature to Callback event to CM_TCUSTOME_T6S
task.executeCommandCallback.CM_TCUSTOME_T6S = function(entities, executeCommandCallbackEventArgs) {
	executeCommandCallbackEventArgs.commons.execServer = false;    
	var nameReport = entities.Context.nameReport;
	var tittle = "";	
	if (entities.Context.generateReport) {
	    if (entities.Context.printReport) {
	        var args = [['report.module', 'customer'], ['report.name', nameReport], ['idCustomer', entities.Person.personSecuential]];
	        if (nameReport === 'BuroCreditoHistorico') {
	            tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTETI_28269');
	        } else if (nameReport === 'BuroCreditoInternoExterno') {
	            tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTEEI_96019');
	        }
	        LATFO.UTILS.generarReporte(nameReport, args, tittle);
	    } else {
	        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesInfo('CSTMR.MSG_CSTMR_ELREPOREE_57555');
	    }
	}
};