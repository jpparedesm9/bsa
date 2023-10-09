//Start signature to callBack event to CM_TPYEP21MTE89
    task.executeCommandCallback.CM_TPYEP21MTE89 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		//isCalculated = true;
		var viewState = executeCommandCallbackEventArgs.commons.api.viewState,        
        api = executeCommandCallbackEventArgs.commons.api,
        enableContinuebutton =false;
		wasInExecuteCommandCallback = true;
		
		viewState.lockScreen('VC_TPYEP21_FAETL_814', null);
		//task.disableRowGrid(executeCommandCallbackEventArgs, 'Category' , 'QV_UYCTE6570_70'); //funcion para deshabilitar los registros heredados
		/*if(grupos != null){
			BUSIN.API.enable(viewState,grupos);
		}*/
        //Se valida que El Monto no puede ser menor a la suma del Saldo de las Operaciones pero solo para Refinanciamiento

		
        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento && entities.OriginalHeader.Expromission===undefined){
            if(entities.PaymentPlanHeader.amount >=entities.PaymentPlanHeader.sumAmount && entities.PaymentPlanHeader.approvedAmount>=entities.PaymentPlanHeader.sumAmount){
                if(executeCommandCallbackEventArgs.success){
                    task.validateExistsOperation(true, entities, executeCommandCallbackEventArgs);
                    if(entities.OriginalHeader.StatusRequested != 'A'){
                        BUSIN.API.enableCTR(executeCommandCallbackEventArgs.commons.api,['GR_VWPAYMENLA26_10']);
                        BUSIN.API.enable(viewState,['GR_VWPAYMENLA26_13'
						//,'VA_VWPAYMENLA2613_PAME294'
						//,'VA_VWPAYMENLA2613_REPE081'
						//,'VA_VWPAYMENLA2613_PERM620'
						]);
                    }
					task.setScrollAmortizationTable(entities.AmortizationTableItem.data().length, executeCommandCallbackEventArgs.commons.api);
                    task.formatAmortizationTable(entities, executeCommandCallbackEventArgs.commons.api);
					//Calcular el Total del Saldo de Capital
					setTimeout(function() {
						task.setTotalLabel(api.viewState);
						task.calculateTotalCapitalBalance(entities.AmortizationTableItem.data());
					});	
					api.viewState.enable('GR_VWPAYMENLA26_07');
					api.viewState.enable('GR_VWPAYMENLA26_08');
					api.viewState.enable('GR_VWPAYMENLA26_05');
					api.viewState.enable('GR_VWPAYMENLA26_13');
                    enableContinuebutton = task.formatPaymentCapacityTable(entities, executeCommandCallbackEventArgs);
                } else {
                    enableContinuebutton = false;
                }
                if (task.Etapa === FLCRE.CONSTANTS.Stage.Recalculation){
                    task.disablePaymentPlanActivity(viewState);
                }
                //Logica para habilitar el boton continuar del wf
                if(enableContinuebutton){
                    BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,api);
                    executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitPaymentPlan.commitPaymentPlan';
                }else{
                    BUSIN.INBOX.STATUS.nextStep(false,api);
                }
            }
        }else{
            if(executeCommandCallbackEventArgs.success){
                task.validateExistsOperation(true, entities, executeCommandCallbackEventArgs);
                if(entities.OriginalHeader.StatusRequested != 'A'){
                    BUSIN.API.enableCTR(executeCommandCallbackEventArgs.commons.api,['GR_VWPAYMENLA26_10']);
                }
				task.setScrollAmortizationTable(entities.AmortizationTableItem.data().length, executeCommandCallbackEventArgs.commons.api);				
                task.formatAmortizationTable(entities, executeCommandCallbackEventArgs.commons.api);
				//Calcular el Total del Saldo de Capital
				setTimeout(function() {
					task.setTotalLabel(api.viewState);
					task.calculateTotalCapitalBalance(entities.AmortizationTableItem.data());
				});				
                enableContinuebutton = task.formatPaymentCapacityTable(entities, executeCommandCallbackEventArgs);
				api.viewState.enable('GR_VWPAYMENLA26_07');
				api.viewState.enable('GR_VWPAYMENLA26_08');
				api.viewState.enable('GR_VWPAYMENLA26_05');
				api.viewState.enable('GR_VWPAYMENLA26_13');
            } else {
                enableContinuebutton = false;
            }

            if (task.Etapa === FLCRE.CONSTANTS.Stage.Recalculation){
                task.disablePaymentPlanActivity(viewState);
				BUSIN.API.GRID.disableEnableToolbar(executeCommandCallbackEventArgs,'Category','QV_UYCTE6570_70',false,'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para edición en modo CONSULTA
            }

            //Logica para habilitar el boton continuar del wf
            if(enableContinuebutton){
                BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,api);
                executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitPaymentPlan.commitPaymentPlan';
            }else{
                BUSIN.INBOX.STATUS.nextStep(false,api);
            }
          
        }
		// Credito con Convenio - Aplica todos los Flujos.
		if(entities.OriginalHeader.Agreement === 'S'){
			viewState.disable('VA_VWPAYMENLA2613_HNGE724');
			viewState.disable('GR_VWPAYMENLA26_14');
		}
		if(entities.PaymentPlan.tableType=='MANUAL'){
			task.disableToolbarAmortizationTable(executeCommandCallbackEventArgs,'AmortizationTableItem','QV_QUYOI3312_16',true);
		}else{
			task.disableToolbarAmortizationTable(executeCommandCallbackEventArgs,'AmortizationTableItem','QV_QUYOI3312_16',false);
		}
		task.loadTaskHeader(entities, executeCommandCallbackEventArgs);		
		task.enableDisabledByAcceptsAdditionalPayments(entities, executeCommandCallbackEventArgs);
		task.enableDisabledByExchangeRate(entities, executeCommandCallbackEventArgs);
		task.enableDisabledByPaymentType(entities, executeCommandCallbackEventArgs);
		task.enableDiableQuotaInterest(entities, executeCommandCallbackEventArgs);
		wasInExecuteCommandCallback = false;
		
		if(entities.PaymentPlan.quota!=0){
			quotaHasChange = true;
		}

        //Se configura los rubros editables
		task.setEditableCategory(executeCommandCallbackEventArgs);

		//Se mapea en cero para CPN que no tiene bien calculado el valor en ca_operacion_tmp (opt_cuota)
		entities.PaymentPlan.quota = 0;
		viewState.unlockScreen('VC_TPYEP21_FAETL_814');
        
        // Se actualiza la fecha del primer desembolso
        entities.PaymentPlanHeader.firstExpirationFeeDate = entities.AmortizationTableItem.data()[0].ExpirationDate


		      BUSIN.API.GRID.disableEnableToolbar(executeCommandCallbackEventArgs,'Category','QV_UYCTE6570_70',false,'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para ediciÃ³n en modo CONSULTA
		task.disablePaymentCondition(executeCommandCallbackEventArgs); 
		executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_DISPERSIONDATTT_417A26')
        
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_PAYMENTDAYSQXGZ_884A26'); //Req.194284 Dia de Pago

    };