// (Button) 
    task.executeCommand.CM_TPYEP21MTE89 = function(entities, executeCommandEventArgs) {
		executeCommandEventArgs.commons.api.viewState.lockScreen('VC_TPYEP21_FAETL_814', null);
		var serverParameters = executeCommandEventArgs.commons.serverParameters;
        //Se valida que el Monto Primer Desembolso y el Monto Propuesto sean iaguales solo para Refinanciamiento
		var validate = task.validateTotalCapitalBalance(entities.AmortizationTableItem.data());
		if(validate == -1){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSRRRIANT_59731',null,10000);
		}
		else if(validate == 1){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSAMTIOTE_78401',null,10000);
		}
		else if(validate == 0){
        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento && entities.OriginalHeader.Expromission===undefined){
            if(entities.PaymentPlanHeader.amount!=entities.PaymentPlanHeader.approvedAmount ){
                executeCommandEventArgs.commons.execServer = false;
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OPOMEEMBL_33336',null,10000);
            }
        }else{
            if(entities.PaymentPlanHeader.amount>entities.PaymentPlanHeader.approvedAmount ){
                executeCommandEventArgs.commons.execServer = false;
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_TOOEOARAO_58574',null,10000);
            }
        }

		}
		if(executeCommandEventArgs.commons.execServer === false){
			return;
		}
    };