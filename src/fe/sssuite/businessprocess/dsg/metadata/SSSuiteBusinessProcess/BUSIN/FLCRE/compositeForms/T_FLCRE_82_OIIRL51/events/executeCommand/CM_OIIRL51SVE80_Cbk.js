//Start signature to callBack event to CM_OIIRL51SVE80
   task.executeCommandCallback.CM_OIIRL51SVE80 = function(entities, executeCommandCallbackEventArgs) {
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
       
        var parameter = executeCommandCallbackEventArgs.commons.api.parentVc.customDialogParameters;
	    parameter.Task.porcentaje = entities.ApplicationInfoAux.percentageGuarantee;
       
        if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625');
			LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
			if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
				LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', (entities.Context.Flag1 == null? '--' : entities.Context.Flag1), 1);
			}
	        if(typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL){
				LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.termInd == null ? '--' : entities.OriginalHeader.termInd), 0);
				LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', (entities.Context.Flag1 == null ? '--' : entities.Context.Flag1), 1);
			}else{
				LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.Term == null ? '--' : entities.OriginalHeader.Term), 0);
	        }
			
			//Caso REQ#162288 Cambios Simple F1
            if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_PAYMENTFREQUECN_439R86',entities.OriginalHeader.PaymentFrequency);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);				
            } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_FREQUENCYLTUZDL_595R86',entities.OriginalHeader.frequency);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);			
            } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_7694PEJSETHIYUL_239R86',entities.OriginalHeader.frequencyRevolving);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);			
            } else {
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_FREQUENCYCNYXFV_220R86',entities.OriginalHeader.frequency);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);
            }			
			LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'GR_WTTTEPRCES08_02');
        }


		
       if(!executeCommandCallbackEventArgs.success)
		{
			
			if(typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL){
				LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
				LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.termInd == null ? '--' : entities.OriginalHeader.termInd), 0);
				entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_FREQUENCYCNYXFV_220R86',entities.OriginalHeader.frequency);				
				LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);
			}
			
		}
        executeCommandCallbackEventArgs.commons.execServer = false;
	};