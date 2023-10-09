<!-- Designer Generator v 5.0.0.1510 - release SPR 2015-10 29/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.quotavsavailablebalancemodifylc;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************

	//Entity: CreditOtherData
    //CreditOtherData.CreditDestination (TextInputButton) View: CreditOtherDataView
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto.
    task.textInputButtonEvent.VA_RIOTRDTAVI4904_EDSN666 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.openFindLoan(textInputButtonEventArgs,[],null);
    };

	task.closeModalEvent.VC_CCOVI89_AECIT_172 = function(closeModalEventArgs) {
		var api = closeModalEventArgs.commons.api;
		var result = closeModalEventArgs.result['actividadEconomicaSeleccionada'];
		api.vc.model['CreditOtherData'].CreditDestinationValue = result.economicActivity;
		api.vc.model['CreditOtherData'].CreditDestination = result.codeEconomicActivity;
	};
    //.Btn_Validate (Button) View: CreditOtherDataView
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
        var toValidate = entities.ValidationQuotaVsAvailableBalance;
        var toEvaluate = entities.PaymentCapacityHeader;
		if(BUSIN.VALIDATE.IsNullOrEmpty(toValidate.Rate) || BUSIN.VALIDATE.IsNullOrEmpty(toValidate.Term) ||
		   BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuota) || BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuotaLine) )
        {
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_CCKEMTFEL_83493');
            executeCommandEventArgs.commons.execServer = false;
			return;
        }
		//REALIZA LA VALIDACION DE 'CUOTA MAXIMA' Y 'CUOTA MAXIMA LINEA'
        if(!BUSIN.VALIDATE.IsNull(toEvaluate) && FINANCIALANALYSIS.hasValidItems(entities)){
			if(FINANCIALANALYSIS.isItemsFull(entities,executeCommandEventArgs,true)){
				executeCommandEventArgs.commons.execServer = true;
			}else{
				return;
			}
        }
    };

	task.executeCommandCallback.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
		BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
        if(executeCommandEventArgs.success){
            executeCommandEventArgs.commons.api.viewState.enable('CM_AALAC85SAV65');
        }else{
            executeCommandEventArgs.commons.api.viewState.disable('CM_AALAC85SAV65');
        }
		FINANCIALANALYSIS.formatPaymentCapacityTable(entities, executeCommandEventArgs, 'CM_AALAC85SAV65');
    };

    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.[Control Sin Nombre] (TextLink) View: ApplicationHeaderView
    task.executeCommand.VA_APITONEAEE5510_0000944 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var nav = executeCommandEventArgs.commons.api.navigation;
		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CUOMREARH_28245');
        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_14_NEEDA85',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_NEEDA85_LHEIL_830'
        };
        nav.customDialogParameters = {
            lineHeader: entities['LineHeader']
        };
        nav.popoverProperties = {
            width: 500,
            height: 'auto',
            position: "left bottom"
        };
        nav.openPopover(executeCommandEventArgs.commons.controlId);
    };

    //IndexSizeActivity.Patrimony (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //IndexSizeActivity.PersonalNumber (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //IndexSizeActivity.Sales (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };


	//DistributionLine.AmountPurposed (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };
	//DistributionLine.Currency (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };
    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
       changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };

    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
		BUSIN.VALIDATE.IsGreaterThanZero(entities.ValidationQuotaVsAvailableBalance.MaximumQuota, changedEventArgs, false, true);
    };

    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
    };

    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };
	//**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //BtnSave (Button)
    task.executeCommand.CM_AALAC85SAV65 = function(entities, executeCommandEventArgs) {
		var toValidate = entities.ValidationQuotaVsAvailableBalance;
        var toEvaluate = entities.PaymentCapacityHeader;

        if(!BUSIN.VALIDATE.IsNull(toEvaluate) && (toEvaluate.Type==='FCP')){ // FCP = flujo de caja proyectado
            if(BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuota) || BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuotaLine) ){
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_CCKEMTFEL_83493');
                executeCommandEventArgs.commons.execServer = false;
            }
        }else if(BUSIN.VALIDATE.IsNullOrEmpty(toValidate.Rate) || BUSIN.VALIDATE.IsNullOrEmpty(toValidate.Term) ||
                 BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuota) ||BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuotaLine) )
        {
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_CCKEMTFEL_83493');
            executeCommandEventArgs.commons.execServer = false;
        }
    };
	task.executeCommandCallback.CM_AALAC85SAV65 = function(entities, executeCommandCallbackEventArgs) {
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //UpdateRow QueryView: GridDistributionLine
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //DeleteRow QueryView: GridDistributionLine
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };
	//CmdNewEvent (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_300 = function(entities, gridExecuteCommandEventArgs) {
         gridExecuteCommandEventArgs.commons.execServer = false;
    };
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormQuotaVsAvailableBalanceModifyLC
    task.initData.VC_AALAC85_OVBAF_912 = function(entities, initDataEventArgs) {
		BUSIN.SYSTEM.importScript('FinancialAnalysis.js');
		BUSIN.SYSTEM.importScript('CreditBureau.js');
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		//MCA
		//entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringTwo;
		entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringOne;
		entities.OriginalHeader.UserL=userL;
        entities.OriginalHeader.TypeRequest = "P";
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		initDataEventArgs.commons.execServer = true;

		initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true);
    };

    task.initDataCallback.VC_AALAC85_OVBAF_912 = function(entities, initDataCallbackEventArgs) {
        initDataCallbackEventArgs.commons.execServer = false;
	 	var viewState = initDataCallbackEventArgs.commons.api.viewState;
		/*Habilitacion de pestaña Validacion Cuota Vs. Saldo Disponible*/
		initDataCallbackEventArgs.commons.api.viewState.show('GR_RIOTRDTAVI49_12');
		initDataCallbackEventArgs.commons.api.viewState.focus('GR_RIOTRDTAVI49_12');

		/*Bloqueo de campos*/
		//Otros Indice Tamaño Actividad
		task.disableFieldOtrosIndiceTamanoActividad(viewState);

		//Oculto la pestaña Otros datos Credito
		viewState.hide('GR_RIOTRDTAVI49_04');
		viewState.disable('GR_RIOTRDTAVI49_04');

		//Botones Deudores
		initDataCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		initDataCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');//'create');

		//Boton Distribucion de linea
		initDataCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');//'CEQV_201_QV_TSRSE1342_26_253');
		//Botones en Distribucion de Linea
		var ds = initDataCallbackEventArgs.commons.api.vc.model['DistributionLine'];
		var dsData = ds.data();
		for (var i = 0; i < dsData.length; i ++) {
			var dsRow = dsData[i];
			initDataCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_QERIS7170_82', dsRow, 'edit');
			initDataCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_QERIS7170_82', dsRow, 'delete');
		}

		/*Validacion de Rotary para pestaña de Cuota Vs. Saldo Disponible*/
		if(entities.LineHeader.Rotary == "S"){
			initDataCallbackEventArgs.commons.api.viewState.disable('VA_RIOTRDTAVI4912_TERM010');
		}
        if(!initDataCallbackEventArgs.success){
            viewState.disable('VA_RIOTRDTAVI4912_0000847');
        }
    };
	    //ViewContainer: FormQuotaVsAvailableBalanceModifyLC
    task.render = function(entities, renderEventArgs) {
		renderEventArgs.commons.execServer = false;
		var api = renderEventArgs.commons.api;
		var viewState = renderEventArgs.commons.api.viewState;
		task.disableAllField(viewState);// Deshabilito campos de la cabecera
		task.hideField(viewState);
		CREDITBUREAU.QUERYCENTRAL.validateLevelIndebtedness(entities, renderEventArgs, 'VA_RIOTRDTAVI4907_EDNE010' ); //Nivel de Endeudamiento
		//MCA
		if(entities.OriginalHeader.TypeRequest === 'P'){
			api.viewState.disable('VA_APITONEAEE5505_EPRO465'); //Deshabilita Moneda
		}
		BUSIN.API.readOnlyAsync(renderEventArgs,['VA_RIOTRDTAVI4904_RDTN715'],true,2000);
		FINANCIALANALYSIS.formatPaymentCapacityTable(entities, renderEventArgs, 'CM_AALAC85SAV65');
		//Deshabilita - Tasa y Cuota Maxima Linea
		BUSIN.API.disable(viewState,['VA_RIOTRDTAVI4912_RATE281','VA_RIOTRDTAVI4912_IULI202']);
    };

	//**********************************************************
    //  Eventos para Grupos
    //**********************************************************
    //Other Data (TabbedLayout)  View: CreditOtherDataView
    //Evento ChangeGroup: Evento change para pestañas, collapsible y accordion.
    task.changeGroup.GR_RIOTRDTAVI49_03 = function(entities, changedGroupEventArgs) {
        changedGroupEventArgs.commons.execServer = false;
        if((changedGroupEventArgs.commons.item.id === 'GR_RIOTRDTAVI49_04') && (changedGroupEventArgs.commons.item.isOpen === true)){
			console.log("Open by " + changedGroupEventArgs.commons.item.id);
			var valueActivityDestinationCredit = changedGroupEventArgs.commons.api.viewState.selectedText('VA_RIOTRDTAVI4904_RDTN715', entities.CreditOtherData.CreditDestination);
			entities.CreditOtherData.CreditDestinationValue = valueActivityDestinationCredit;
        }
    };

	task.disableAllField=function(viewState){
		var grps = ['VA_APITONEAEE5505_RTAY481','VA_APITONEAEE5505_PROE367','VA_APITONEAEE5505_USED740','VA_APITONEAEE5505_NDTE867','VA_APITONEAEE5505_TERM140',
				'VA_APITONEAEE5505_XPIA086','VA_APITONEAEE5505_OFIC220','VA_APITONEAEE5505_SCTR004','VA_APITONEAEE5505_ADSN125','VA_APITONEAEE5506_ITCE223',
				'VA_APITONEAEE5506_IALT470','VA_APITONEAEE5506_OQUE114','VA_APITONEAEE5506_TERM631','VA_APITONEAEE5506_FICE377']
	    BUSIN.API.disable(viewState,grps);
	};
	//Otros Indice Tamaño Actividad
	task.disableFieldOtrosIndiceTamanoActividad=function(viewState){
		var grps = ['VA_RIOTRDTAVI4909_ATRN190','VA_RIOTRDTAVI4909_SALE147','VA_RIOTRDTAVI4909_PESL753','VA_RIOTRDTAVI4909_NULE410','VA_RIOTRDTAVI4909_RCIE187']
	    BUSIN.API.disable(viewState,grps);
	};

	task.hideField=function(viewState){
		var grps = ['VA_RIOTRDTAVI4904_RDTN715','GR_RIOTRDTAVI49_10','GR_RIOTRDTAVI49_13'] //campo codigo actividad economica,_,porcentaje de comision
	    BUSIN.API.hide(viewState,grps);
	};

}());