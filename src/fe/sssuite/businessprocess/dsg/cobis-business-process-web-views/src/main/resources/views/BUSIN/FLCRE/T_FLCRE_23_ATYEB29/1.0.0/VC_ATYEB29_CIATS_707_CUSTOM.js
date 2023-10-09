<!-- Designer Generator v 5.0.0.1517 - release SPR 2015-16 04/09/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.officialactivitycollateralballots;
	task.RequestStage = '';
    task.RequestName = '';
	task.authorizedCommission =false;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
	//Entity: CreditOtherData
    //.Aceptar (Button) View: CreditOtherDataView
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_RIOTRDTAVI4913_0000660 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

	task.executeCommandCallback.VA_RIOTRDTAVI4913_0000660 = function(entities, executeCommandCallbackEventArgs) {
        if(executeCommandCallbackEventArgs.success)
			task.authorizedCommission =true;
		else
		    task.authorizedCommission =false;
    };
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

    //Entity: CreditOtherData
    //CreditOtherData.ActivityDestinationCredit (ComboBox) View: CreditOtherDataView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
	task.loadCatalog.VA_RIOTRDTAVI4904_TATT517 = function(loadCatalogDataEventArgs) {
	    var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
	    serverParameters.DebtorGeneral = true;
	    serverParameters.OriginalHeader = true;
	    serverParameters.Context = true;
	    loadCatalogDataEventArgs.commons.execServer = true;
	};

    //Entity: CreditOtherData
    //CreditOtherData.ActivityDestinationCredit (ComboBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.change.VA_RIOTRDTAVI4904_TATT517 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
	    OTHERCREDITDATA.changeActivity(entities, changedEventArgs,task.RequestName);
	};

    //Entity: CreditOtherData
    //CreditOtherData.CreditPorpuse (ComboBox) View: CreditOtherDataView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
	task.loadCatalog.VA_RIOTRDTAVI4904_RPPU470 = function(loadCatalogDataEventArgs) {
	    var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
	    serverParameters.CreditOtherData = true;
	    serverParameters.OriginalHeader = true;
	    loadCatalogDataEventArgs.commons.execServer = true;
	    serverParameters.Context = true;
	    serverParameters.IndexSizeActivity = true;
	    serverParameters.OfficerAnalysis = true;
	};

    //Entity: CreditOtherData
    //CreditOtherData.CreditDestination (ComboBox) View: CreditOtherDataView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
	task.loadCatalog.VA_RIOTRDTAVI4904_RDTN715 = function(loadCatalogDataEventArgs) {
	    var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
	    serverParameters.CreditOtherData = true;
	    serverParameters.OriginalHeader = true;
	    serverParameters.Context = true;
	    loadCatalogDataEventArgs.commons.execServer = true;
	};

    //Entity:
    //.Boton (Button) View: ViewGuaranteesTicket
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_IEWGUARNTK6812_0000459 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
    };

    //Entity:
    //.Btn_Validate (Button) View: ApproveCreditRequest
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: OriginalHeader
    //OriginalHeader.CreditSector (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6805_EDCT992 = function(entities, changedEventArgs) {
			changedEventArgs.commons.execServer = false;
    };

    //Entity: OriginalHeader
    //OriginalHeader.Province (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6805_OINC062 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };
    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.RequestedTermInDays (TextInputBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_EUER032 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };
    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

	task.changeCallback.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
		var api = changedEventArgs.commons.api;
		if(changedEventArgs.success == false){
			api.viewState.disable('CM_ATYEB29SVE14');
		}else{
			api.viewState.enable('CM_ATYEB29SVE14');
		}
    };
    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CurrencyRequested (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_RRQE376 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.AmountRequested (TextInputBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_TREU555 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CustomerSector (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_UMRO301 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
		 if(changedEventArgs.newValue===entities.IndexSizeActivity.ParameterFixedIncome){
			task.disableIndexActivityPrincipal(entities, changedEventArgs.commons.api.viewState);
			changedEventArgs.commons.execServer = false;
			entities.IndexSizeActivity.sizeCompany = '';
			//changedEventArgs.commons.messageHandler.showMessagesInformation($('#VA_IEWGUARNTK6806_UMRO301').data('kendoExtComboBox').text());
		}else{
			task.enableIndexActivityPrincipal(entities, changedEventArgs.commons.api.viewState);
			if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != '' )&& (entities.IndexSizeActivity.PersonalNumber != null &&
			entities.IndexSizeActivity.PersonalNumber != '') && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != '')){
			changedEventArgs.commons.execServer = true;
			}else{
				changedEventArgs.commons.execServer = false;
			}
		}
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6809_EEAR819 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: Official
    //Official.Official (ComboBox) View: Oficial
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OFICIALOBG2103_OFIL240 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Patrimony (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.PersonalNumber (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
         if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != '' )&& (entities.IndexSizeActivity.PersonalNumber != null &&
			entities.IndexSizeActivity.PersonalNumber != '') && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != '')){
			changedEventArgs.commons.execServer = true;
			}else{
				changedEventArgs.commons.execServer = false;
			}
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Sales (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.AmountPurposed (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.Currency (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_IEWGUARNTK6806_LIES496 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;
		serverParameters.DebtorGeneral = true;
		loadCatalogDataEventArgs.commons.execServer = true;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.WarrantyType (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_IEWGUARNTK6806_WNTP122 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;
    };


        //Entity: Official
    //Official.Official (ComboBox) View: Oficial
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFICIALOBG2103_OFIL240 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto.
    task.textInputButtonEvent.VA_IEWGUARNTK6809_EEAR819 = function(textInputButtonEventArgs) {
	var numErrorsQueryCentral=executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_RIOTRDTAVI49_07',false);//Query Central
			textInputButtonEventArgs.commons.execServer = false;
    };

	//Entity: FeeRate
    //FeeRate.costCategory (ComboBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4913_CCGR378 = function(entities, changedEventArgs) {
        var idButton = ['VA_RIOTRDTAVI4913_0000660'];
		task.hideShowFunction(entities, changedEventArgs);
		task.limpiarCampos(entities);
		BUSIN.API.disable(changedEventArgs.commons.api.viewState,idButton);
		//task.disablePorcentageNormal(entities, changedEventArgs);
		changedEventArgs.commons.execServer = true;
    };

	task.changeCallback.VA_RIOTRDTAVI4913_CCGR378 = function(entities, changedEventArgs) {
		task.disablePorcentageNormal(entities, changedEventArgs);
    };

    //Entity: FeeRate
    //FeeRate.percentageNew (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4913_PRNT606 = function(entities, changedEventArgs) {
		task.validateFactors(entities, changedEventArgs);
		if(task.validateError){
			task.limpiarCampos(entities);
			task.authorizedCommission =false;
			BUSIN.INBOX.STATUS.nextStep(false,changedEventArgs.commons.api);
			changedEventArgs.commons.execServer = false;
	    }
		else
			changedEventArgs.commons.execServer = true;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button)
    task.executeCommand.CM_ATYEB29SVE14 = function(entities, executeCommandEventArgs) {
        var numErrorsQueryCentral=executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_RIOTRDTAVI49_07',false);//Query Central
		var numErrorsOtherData=executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_RIOTRDTAVI49_04',false);//Otros Datos del crédito
		var numErrorsSizeActivity=executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_RIOTRDTAVI49_09',false);//Tamaño de la actividad
		if(numErrorsQueryCentral>0 || numErrorsOtherData>0 ||numErrorsSizeActivity>0){
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSNCAYDTA_60795',null,6000);	// Mensaje 'Ingrese todos los datos'
			executeCommandEventArgs.commons.execServer = false;
		}
		if( task.isGuaranteesTicket() && task.isAnalisisOficial()) {
			//Fecha CIC - Sección de Deudores
			if(!FLCRE.UTILS.CUSTOMER.hasDateCIC(entities,executeCommandEventArgs,true)){
				executeCommandEventArgs.commons.execServer = false;
				return;
			}
			//Tipo de calificación - Calificación - Garantía = Destino? - Deudor = Propietario ?
			if(entities.OriginalHeader.ScoreType === FLCRE.CONSTANTS.ScoreType.BusinessManual){
				BUSIN.VALIDATE.EmptyFieldValue(entities.OriginalHeader.Score,'BUSIN.DLB_BUSIN_CALIFCAIN_39502',executeCommandEventArgs,true);
			}
			BUSIN.VALIDATE.EmptyFieldValue(entities.OriginalHeader.IsWarrantyDestination,'BUSIN.DLB_BUSIN_AATADSINO_05256',executeCommandEventArgs,true);
			if(executeCommandEventArgs.commons.execServer === false){
				return;
			}
		}
    };
	//Validacion de success del server para habilitacion de boton continuar
	task.executeCommandCallback.CM_ATYEB29SVE14 = function(entities, executeCommandCallbackEventArgs) {
		if (task.authorizedCommission){
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}
	};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
		 var count = 0;
			for (var i = 0; i < entities.DebtorGeneral.data().length; i++) {
				var row = entities.DebtorGeneral.data()[i];
				if(row.CustomerCode ==  gridRowInsertingEventArgs.rowData.CustomerCode){
					count++;
				}
			}
			if(count >= 2){
				gridRowInsertingEventArgs.cancel= true;
				gridRowInsertingEventArgs.commons.messageHandler.showMessagesInformation('Borrower already exist.');
				gridRowInsertingEventArgs.commons.execServer = false;
			}
		   gridRowInsertingEventArgs.commons.execServer = false;
    };

    //InsertingRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente.
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
         beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //UpdateRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
         gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //RowUpdating QueryView: GridVariableData
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_QUERV3248_81 = function(entities, gridRowUpdatingEventArgs) {
         gridRowUpdatingEventArgs.commons.execServer = false;
		  var resp = BUSIN.API.validateTypeData(gridRowUpdatingEventArgs.rowData.Type, gridRowUpdatingEventArgs.rowData.Value)
		 if(resp != ''){
			 gridRowUpdatingEventArgs.commons.messageHandler.showTranslateMessagesError(resp);
			 gridRowUpdatingEventArgs.cancel = true;
		 }
    };

    //DeleteRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    //Evento GridBeforeEnterInlineRow: Se ejecuta antes de la edición o inserción en línea de la grilla..
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        FLCRE.UTILS.CUSTOMER.openFindCustomer(entities,gridABeforeEnterInLineRowEventArgs,{},true);
    };
	task.closeModalEvent.findCustomer = function (args) {
		FLCRE.UTILS.CUSTOMER.addDebtorFromSearch(args,'C',true);
    };
    //GridCommand (Button) QueryView: Borrowers
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(gridExecuteCommandEventArgs,true);
    };

	task.gridInitColumnTemplate.QV_BOREG0798_55 = function(idColumn) { //QueryView: Borrowers
		 if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC();
		}
	};
	task.change.VA_BORRWRVIEW2783_DTCC540 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.setDateCIC(changedEventArgs);
	};

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: FormOfficialActivityCollateralBallots
	task.initData.VC_ATYEB29_CIATS_707 = function(entities, initDataEventArgs) {
	    BUSIN.SYSTEM.importScript('OtherCreditData.js');
		BUSIN.SYSTEM.importScript('CreditBureau.js');
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.HeaderGuaranteesTicket.CustomerName=client.clientName; //Recupero el NOmbre del Cliente
		entities.HeaderGuaranteesTicket.CustomerId=client.clientId;//Recupero el Id del Cliente
		entities.HeaderGuaranteesTicket.CustomerType = client.clientType;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		//entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.HeaderGuaranteesTicket.User = cobis.userContext.getValue(cobis.constant.USER_NAME);
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
            task.RequestStage = parentParameters.Task.urlParams.ETAPA;
        }
        if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
            task.RequestName = parentParameters.Task.urlParams.TRAMITE;
		}
		if( task.isGuaranteesTicket() && (task.isAnalisisLegal() || task.isConstanciaDeGravamen())) {
			var parentVc = initDataEventArgs.commons.api.parentApi().vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = 'YES';
		}

		initDataEventArgs.commons.execServer = true;
		//campo codigo actividad economica
		initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_RDTN715',true); //se visualiza Actividad destinar credito combo
		initDataEventArgs.commons.api.viewState.hide('VA_RIOTRDTAVI4904_EDSN666'); //se oculta Actividad destinar credito x busqueda

		entities.Context.RequestStage = task.RequestStage;
		entities.Context.RequestName = task.RequestName;
    };

    task.initDataCallback.VC_ATYEB29_CIATS_707 = function(entities, initDataEventArgs) {
		if(initDataEventArgs.success) {
			if( task.isGuaranteesTicket() && task.isAnalisisOficial()) {
				initDataEventArgs.commons.api.grid.showColumn ('QV_BOREG0798_55', 'DateCIC');
			}
		}
	};

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: FormOfficialActivityCollateralBallots
    task.render = function(entities, renderEventArgs) {
		renderEventArgs.commons.execServer = false;
		//Cambia el nombre de la etiqueta de Sector del cliente a Sector de la actividad principal
		renderEventArgs.commons.api.viewState.label('VA_IEWGUARNTK6806_UMRO301', 'BUSIN.DLB_BUSIN_TMERDUSRY_93208', true);
		if(entities.HeaderGuaranteesTicket.Sector === entities.IndexSizeActivity.ParameterFixedIncome){
			task.disableIndexActivityPrincipal(entities, renderEventArgs.commons.api.viewState);
		}
		var viewState = renderEventArgs.commons.api.viewState;
		var grid = renderEventArgs.commons.api.grid;
		//disable field CreditPorpuse
		BUSIN.API.disable(viewState,['VA_RIOTRDTAVI4904_RPPU470']); //*** porm el momento
		//hide field SourceOfFunding
		BUSIN.API.hide(viewState,['VA_RIOTRDTAVI4904_OUED020','VA_IEWGUARNTK6805_CRET464']);
		BUSIN.API.disable(viewState,['VA_RIOTRDTAVI4904_OUED020','VA_RIOTRDTAVI4913_NVLX125','VA_RIOTRDTAVI4913_ECUE519']);

		if(task.isGuaranteesTicket() && (task.isAnalisisOficial() || task.isVerificationDocuments())){
			 task.hideField(viewState);
			 viewState.show('VA_RIOTRDTAVI4907_EDNE010');//Nivel de endeudamiento
		}

		if(task.isGuaranteesTicket() && (task.isAnalisisOficial())){
			task.disableFieldAnalisisOficial(viewState);
			var ctr2 = ['VA_IEWGUARNTK6805_RUCE680','VA_IEWGUARNTK6805_GCUN398','VA_IEWGUARNTK6805_SOET426','VA_IEWGUARNTK6805_DSIN268',
						'VA_IEWGUARNTK6805_IBTO078','VA_IEWGUARNTK6806_CITE731','VA_IEWGUARNTK6806_REIT372']
			BUSIN.API.show(viewState , ctr2);
			viewState.readOnly('VA_IEWGUARNTK6805_RUCE680', false);
			viewState.readOnly('VA_IEWGUARNTK6805_GCUN398', false);
			viewState.readOnly('VA_IEWGUARNTK6805_IBTO078', true);
			viewState.disable('VA_IEWGUARNTK6805_IBTO078');
			viewState.readOnly('VA_IEWGUARNTK6805_DSIN268', false);
			viewState.enable('VA_IEWGUARNTK6805_DSIN268');
			if(entities.OriginalHeader.ScoreType === FLCRE.CONSTANTS.ScoreType.BusinessManual){
				viewState.show('VA_IEWGUARNTK6805_SCOR834');
				viewState.readOnly('VA_IEWGUARNTK6805_SCOR834', false);
				viewState.enable('VA_IEWGUARNTK6805_SCOR834');
			}
		}

		//Si la Pantalla es análsis legal
		if( task.isGuaranteesTicket() && (task.isAnalisisLegal() || task.isConstanciaDeGravamen())) {
			task.disableFieldAnalisisLegal(viewState);
			BUSIN.API.readOnlyAsync(renderEventArgs,['VA_IEWGUARNTK6806_WNTP122'],true,3000); //Tipo de Garantía
			var ctrs = ['VC_ATYEB29_OALAD_811','CM_ATYEB29SVE14','VA_OFICIALOBG2103_OFIL240'];
			BUSIN.API.hide(viewState,ctrs);
			grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
			grid.hideToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
			task.hideField(viewState);
			task.hideFieldAnalisisLegal(viewState);
		}
		// Se muestra en todas las etapas - Fecha Inicio
		var cst1 = ['VA_IEWGUARNTK6806_DAPS003']
	    BUSIN.API.show(renderEventArgs.commons.api.viewState,cst1);

			var viewState = renderEventArgs.commons.api.viewState, template;
            template = '<span><h4>#: value#</h4></span>' + '<span><b>Monto:</b> #: attributes[0] #</span> - '+
			'<span><b>Disponible:</b> #: attributes[1] #</span> - '+
			'<span><b>Moneda:</b> #: attributes[2] #</span>';
            viewState.template('VA_IEWGUARNTK6806_LIES496', template);

	    viewState.show('GR_RIOTRDTAVI49_13');
		viewState.enable('GR_RIOTRDTAVI49_13');
		task.validateFactors(entities, renderEventArgs);
		task.hideShowFunction(entities, renderEventArgs);
		task.disablePorcentageNormalInitial(entities, renderEventArgs);
		if( task.isAnalisisOficial()) {
			CREDITBUREAU.QUERYCENTRAL.validateLevelIndebtedness(entities, renderEventArgs, 'VA_RIOTRDTAVI4907_EDNE010' );
		}
    };

	//**********************************************************
    //  Eventos para Grupos
    //**********************************************************
    //Other Data (TabbedLayout)  View: CreditOtherDataView
    //Evento ChangeGroup: Evento change para pestañas, collapsible y accordion.
    task.changeGroup.GR_RIOTRDTAVI49_03 = function(entities, changedGroupEventArgs) {
        changedGroupEventArgs.commons.execServer = false;
        if((changedGroupEventArgs.commons.item.id === 'GR_RIOTRDTAVI49_04') && (changedGroupEventArgs.commons.item.isOpen === true)){
			console.log('Open by ' + changedGroupEventArgs.commons.item.id);
			var valueActivityDestinationCredit = changedGroupEventArgs.commons.api.viewState.selectedText('VA_RIOTRDTAVI4904_RDTN715', entities.CreditOtherData.CreditDestination);
			entities.CreditOtherData.CreditDestinationValue = valueActivityDestinationCredit;
        }
    };

	task.isGuaranteesTicket = function() { return task.RequestName === FLCRE.CONSTANTS.RequestName.GuaranteesTicket;};
    task.isAnalisisLegal = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisLegal;};
	task.isAnalisisOficial = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisOficial;};
	task.isConstanciaDeGravamen = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.ConstanciaDeGravamen;};
	task.isVerificationDocuments = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.VerificationDocuments;};
	//Funcion para deshabilitar todos los campos
	task.disableFieldAnalisisLegal = function(viewState) {
		var grps = ['VA_IEWGUARNTK6806_LIES496','VA_IEWGUARNTK6805_USRL092','VA_IEWGUARNTK6805_OINC062','VA_IEWGUARNTK6806_WNTS030',
			'VA_IEWGUARNTK6806_RRQE376', 'VA_IEWGUARNTK6806_WNTP122','VA_IEWGUARNTK6806_ATRO527','VA_IEWGUARNTK6806_TREU555','VA_IEWGUARNTK6806_EUER032','VA_IEWGUARNTK6806_EUER032',
			'VA_IEWGUARNTK6806_UMRO301','VA_IEWGUARNTK6810_OUEE698','VA_IEWGUARNTK6810_ALNI891','VA_IEWGUARNTK6806_POTE119','VA_IEWGUARNTK6810_DLCO699','VA_IEWGUARNTK6810_INTE642'
			,'VA_IEWGUARNTK6807_TORR665'];
		BUSIN.API.disable(viewState,grps);
	};

	//Funcion para ocultar los campos
	task.hideField = function(viewState){
		var grps = [//'VA_IEWGUARNTK6804_OMAM834',// - nombre del cliente
		//'VA_IEWGUARNTK6807_TORR665',// - direccion
		'VA_OFICIALOBG2103_OFIL240',// - oficial - combo
		'GR_IEWGUARNTK68_08',// - Datos del ordenante
		'GR_IEWGUARNTK68_09',//- Datos del beneficiario
		'VA_IEWGUARNTK6805_EDCT992', // - Sector del crédito solo para original
		'GR_RIOTRDTAVI49_11',//- Pestaña Distribución de líneas
		'VA_IEWGUARNTK6806_REWP949',// - permite renovar
		'GR_IEWGUARNTK68_12',
		'GR_RIOTRDTAVI49_12',
		'VA_IEWGUARNTK6810_OUEE698',// - Objetivo de la garantía
		'VA_IEWGUARNTK6810_DLCO699', //- Instruccion adicional 1
		'VA_IEWGUARNTK6810_ALNI891', //- Instruccion adicional 2
		'VA_IEWGUARNTK6810_INTE642' //- Instruccion adicional 3
		];
		BUSIN.API.hide(viewState,grps);
		var grpsEnable = [//'VA_IEWGUARNTK6806_LIES496',//Linea de Crédito - Distrib   --ORI_ R46499
		//'VA_IEWGUARNTK6806_RRQE376',//Moneda Solicitada   --ORI_ R46499
		'VA_IEWGUARNTK6807_TORR665',//Dirección
		'VA_IEWGUARNTK6805_OINC062',//Provincia
		'GR_RIOTRDTAVI49_12'
		];
		BUSIN.API.disable(viewState,grpsEnable);
	};

	task.hideFieldAnalisisLegal = function(viewState){
		var grps = ['GR_IEWGUARNTK68_10','GR_IEWGUARNTK68_08','GR_IEWGUARNTK68_09','VA_IEWGUARNTK6806_REWP949'];
		BUSIN.API.hide(viewState,grps);
	}

	task.disableFieldAnalisisOficial = function(viewState){
		var grps = ['VA_IEWGUARNTK6806_UMRO301'];
		BUSIN.API.disable(viewState,grps);
	}

	task.disableIndexActivityPrincipal = function (entities, viewState){
			entities.IndexSizeActivity.Patrimony='';
			entities.IndexSizeActivity.PersonalNumber='';
			entities.IndexSizeActivity.Sales='';
			entities.IndexSizeActivity.IndexSizeActivity='';
			entities.IndexSizeActivity.AnnualSales='';
			entities.IndexSizeActivity.ProductiveAssets='';
			var ctrs = ['VA_RIOTRDTAVI4909_ATRN190', 'VA_RIOTRDTAVI4909_SALE147', 'VA_RIOTRDTAVI4909_PESL753','VA_RIOTRDTAVI4909_NEIY699','VA_RIOTRDTAVI4909_NULE410','VA_RIOTRDTAVI4909_RCIE187']
			BUSIN.API.disable(viewState,ctrs);
	}
	task.enableIndexActivityPrincipal = function (entities, viewState){
			entities.IndexSizeActivity.Patrimony='';
			entities.IndexSizeActivity.PersonalNumber='';
			entities.IndexSizeActivity.Sales='';
			entities.IndexSizeActivity.IndexSizeActivity='';
			entities.IndexSizeActivity.AnnualSales='';
			entities.IndexSizeActivity.ProductiveAssets='';
			var ctrs = ['VA_RIOTRDTAVI4909_ATRN190', 'VA_RIOTRDTAVI4909_SALE147', 'VA_RIOTRDTAVI4909_PESL753','VA_RIOTRDTAVI4909_NEIY699','VA_RIOTRDTAVI4909_NULE410','VA_RIOTRDTAVI4909_RCIE187']
			BUSIN.API.enable(viewState,ctrs);
	}
	task.hideShowFunction = function(entities, renderEventArgs) {
         if(entities.FeeRate.costCategory === 'E'){
			var idToShow = ['VA_RIOTRDTAVI4913_FCTO304','VA_RIOTRDTAVI4913_0000088','VA_RIOTRDTAVI4913_0000200','VA_RIOTRDTAVI4913_FORO253','VA_RIOTRDTAVI4913_0000800']
		    BUSIN.API.show(renderEventArgs.commons.api.viewState,idToShow);
			var idToHide = ['VA_RIOTRDTAVI4913_0000088','VA_RIOTRDTAVI4913_RCEE421','VA_RIOTRDTAVI4913_0000840','VA_RIOTRDTAVI4913_0000200']
		    BUSIN.API.hide(renderEventArgs.commons.api.viewState,idToHide);
		 }else{
			var idToShow = ['VA_RIOTRDTAVI4913_0000088','VA_RIOTRDTAVI4913_0000840','VA_RIOTRDTAVI4913_0000200', 'VA_RIOTRDTAVI4913_0000800','VA_RIOTRDTAVI4913_RCEE421']
		    BUSIN.API.show(renderEventArgs.commons.api.viewState,idToShow);
			var idToHide = ['VA_RIOTRDTAVI4913_FCTO304','VA_RIOTRDTAVI4913_0000088', 'VA_RIOTRDTAVI4913_0000200','VA_RIOTRDTAVI4913_FORO253']
		    BUSIN.API.hide(renderEventArgs.commons.api.viewState,idToHide);
		 }
    };

	task.validateFactors = function(entities, changedEventArgs) {
		var idButton = ['VA_RIOTRDTAVI4913_0000660'];
		if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.FeeRate.percentageNew)){
			if(entities.FeeRate.costCategory === 'E'){
				if(entities.FeeRate.percentageNew < entities.FeeRate.factorFrom || entities.FeeRate.percentageNew > entities.FeeRate.factorTo){
					changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_EELRSRANI_87817');
					task.validateError = true;
					BUSIN.API.disable(changedEventArgs.commons.api.viewState,idButton);
				}else{
					task.validateError = false;
					BUSIN.API.enable(changedEventArgs.commons.api.viewState,idButton);
				}
			}else{
				if(entities.FeeRate.percentageNew > entities.FeeRate.percentage || entities.FeeRate.percentageNew < 0){
					changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_TJNPMRAJD_08129');
					task.validateError = true;
					BUSIN.API.disable(changedEventArgs.commons.api.viewState,idButton);
				}else{
					task.validateError = false;
					BUSIN.API.enable(changedEventArgs.commons.api.viewState,idButton);
				}
			}
		}else {
			task.validateError = false;
		}
    };
	task.limpiarCampos = function(entities){
		entities.FeeRate.percentageNew='';
		entities.FeeRate.commission='';
		entities.FeeRate.currency='';
		entities.FeeRate.minimum='';
	}

	task.disablePorcentageNormal = function(entities, eventArgs){
		var ids = ['VA_RIOTRDTAVI4913_PRNT606'];
		if(entities.FeeRate.costCategory === 'N'){
			var old = entities.FeeRate.percentageNew;
			entities.FeeRate.percentageNew=entities.FeeRate.percentage;
			eventArgs.commons.api.vc.change2('VA_RIOTRDTAVI4913_PRNT606', entities.FeeRate.percentageNew, old); // Función API para forzar ejecución del Change
			BUSIN.API.disable(eventArgs.commons.api.viewState,ids);
		}else{
			entities.FeeRate.percentageNew=null;
			BUSIN.API.enable(eventArgs.commons.api.viewState,ids);
		}
	}
	task.disablePorcentageNormalInitial = function(entities, eventArgs){
		var ids = ['VA_RIOTRDTAVI4913_PRNT606'];
		if(entities.FeeRate.costCategory === 'N'){
			BUSIN.API.disable(eventArgs.commons.api.viewState,ids);
		}else{
			BUSIN.API.enable(eventArgs.commons.api.viewState,ids);
		}
	}

}());