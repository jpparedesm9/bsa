<!-- Designer Generator v 5.0.0.1502 - release SPR 2015-02 06/02/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.approvecreditrequest;
	var listCustomer = [];
	task.EtapaTramite = '';
	task.Etapa = '';
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
	//DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };
    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };
    //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView
    task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;

		// Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OfficerAnalysis = true;
    };

	//DistributionLine.CreditType (ComboBox) View: ApxxproveCreditRequest
    task.loadCatalog.VA_OVECRDTRQE4830_RITT981 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

	task.loadCatalog.VA_VIWLNEHADE4804_ADSN982 = function(loadCatalogDataEventArgs) { //ACHP
		// Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.LineHeader = true;
    };

	task.loadCatalog.VA_IEWGUARNTK6806_LIES496 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		// Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.DebtorGeneral = true;
    };


    //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.rebateRequest (ComboBox) View: ApproveCreditRequest
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OVECRDTRQE4842_EBEQ592 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
                serverParameters.ApprovalCriteriaQuestion = true;
		loadCatalogDataEventArgs.commons.execServer = true;
    };


	 //**********************************************************
    //  Eventos CHANGE
    //**********************************************************


	//OriginalHeader.AttAmount (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };
    //Exceptions.Aproved (CheckBox) View: ApproveCreditRequest
    task.change.VA_OVECRDTRQE4826_EULT340 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

     //OfficerAnalysis.Sector (ComboBox) View: OfficerAnalysisView
    task.change.VA_OFICANSSEW2603_SCOR371 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
	}
    task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

	//LineHeader.CurrencyProposed (ComboBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_EPRO969 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.AmountProposed (TextInputBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_PROE708 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    task.change.VA_VIWLNEHADE4804_SCTR177 = function(entities, changedEventArgs) { //LineHeader.Sector (ComboBox) View: DistributionLineHeaderView
        changedEventArgs.commons.execServer = false;
    };

	//DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.loadCatalog.VA_OVECRDTRQE4830_RITT981 = function(loadCatalogDataEventArgs) {
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.CreditOtherDataView = true;
        loadCatalogDataEventArgs.commons.execServer = true;
    };

	//DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.change.VA_OVECRDTRQE4830_RITT981 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = true;
    };

	//DistributionLine.Currency (ComboBox) View: CreditOtherDataView
    task.change.VA_OVECRDTRQE4830_CUCY033 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;

    };

	//DistributionLine.Amount (TextBox) View: CreditOtherDataView
	task.change.VA_OVECRDTRQE4830_AONO775 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;

    };



	//check question 1
		//Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.otherDebtCICQuestion (RadioButtonList) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4837_RIEN735 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		entities.ApprovalCriteriaQuestion.applyRebateCROP = '';
		task.setChangeQuestionYesNoOneQ(entities.ApprovalCriteriaQuestion, changedEventArgs.commons.api.viewState);
    };

	//check question 1.1
    //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.sharedEntityQuestion (RadioButtonList) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4837_AEET493 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		entities.ApprovalCriteriaQuestion.applyRebateCROP = '';
		task.setChangeQuestionYesNoTwoQ(entities.ApprovalCriteriaQuestion, changedEventArgs.commons.api.viewState);
    };

	//check question 1.2
    //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion (RadioButtonList) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4837_AETE007 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
		entities.ApprovalCriteriaQuestion.applyRebateCROP = '';
		if(entities.ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion=='S'){ //Se mantiene la calificacion del cliente
			if((entities.ApprovalCriteriaQuestion.previousRateFIE === '' || entities.ApprovalCriteriaQuestion.previousRateFIE === null || entities.ApprovalCriteriaQuestion.previousRateFIE === undefined)
				&&(entities.ApprovalCriteriaQuestion.currentRateFIE === '' || entities.ApprovalCriteriaQuestion.currentRateFIE === null || entities.ApprovalCriteriaQuestion.currentRateFIE === undefined))
			{
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}
			entities.ApprovalCriteriaQuestion.currentRateFIE = entities.ApprovalCriteriaQuestion.previousRateFIE; //Se asigna la calificacion antigua
			task.setQuestionMaximumDiscoun(entities.ApprovalCriteriaQuestion);
			if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'XX'){
					entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}else if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'X'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}else if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'C'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}
			entities.ApprovalCriteriaQuestion.customerCPOPQuestion = '';
		}else{
			changedEventArgs.commons.execServer = true;
		}
    };

	//check question 2
    //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.customerCPOPQuestion (RadioButtonList) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4837_OCPN834 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		task.setChangeQuestionFourV2(entities, changedEventArgs.commons.api.viewState);
    };

	//check pregunta 2.1
	 //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.recordsMatchingQuestion (RadioButtonList) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4837_RORT295 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		task.setChangeQuestionFive(entities, changedEventArgs);
    };

	//check pregunta 2.1.1
    //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.customerNoCPOPQuestion (RadioButtonList) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4837_OQSO471 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		task.setChangeQuestionYesNoSixQ(entities, changedEventArgs);
    };



	//Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.applyRebateCROP (RadioButtonList) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4839_PBTR708 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		task.setValidateTariffRate(entities.ApprovalCriteriaQuestion,changedEventArgs.commons.api.viewState);
    };

	 //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.tariffRate (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4839_TRAE789 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		task.setValidateProposedRate(entities.ApprovalCriteriaQuestion);
    };

    //Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.rebateCustomerType (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OVECRDTRQE4839_REYE670 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		var api = changedEventArgs.commons.api;

		//Se cuenta el total de deudores para habilitar las siguientes preguntas
		var debtors = entities.DebtorGeneral.data().length;

		if(debtors == 1){//Es un solo solicitante Aplica condiciones preferentes
			if(entities.ApprovalCriteriaQuestion.customerCPOPQuestion == 'N'){
				//Es opcional bajar hasta un punto
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
			}else if(entities.ApprovalCriteriaQuestion.customerCPOPQuestion == 'S'){
				task.preferenceConditions(entities, changedEventArgs);
			}
		}else{
			if(entities.ApprovalCriteriaQuestion.rebateCustomerType > entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType){
				changedEventArgs.commons.messageHandler.showMessagesError('La Rebaja de Tasa no puede ser mayor a la M\u00e1xima Rebaja de Tasa');
				entities.ApprovalCriteriaQuestion.rebateCustomerType = 0;
			}else{
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
			}
		}
		if(entities.ApprovalCriteriaQuestion.proposedRate < 0){
			entities.ApprovalCriteriaQuestion.proposedRate = 0;
		}
    };



	//Entity: ApprovalCriteriaQuestion
    //ApprovalCriteriaQuestion.rateApply (Button) View: ApproveCreditRequest
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_OVECRDTRQE4841_TPPY065 = function(entities, executeCommandEventArgs) {
       	if(entities.ApprovalCriteriaQuestion.rebateCustomerType == 0 || entities.ApprovalCriteriaQuestion.rebateCustomerType == undefined){
			var debtors = entities.DebtorGeneral.data().length;
			if(entities.ApprovalCriteriaQuestion.customerCPOPQuestion == 'N' || entities.ApprovalCriteriaQuestion.customerNoCPOPQuestion == 'N'){
			}else{
				executeCommandEventArgs.commons.messageHandler.showMessagesError('Se requiere Rebaja de Tasa');
				executeCommandEventArgs.commons.execServer = false;
			}
		}else{
			task.updateRow(entities,executeCommandEventArgs.commons.api);
			executeCommandEventArgs.commons.execServer = true;
			//entities.PaymentPlanHeader.rate = entities.ApprovalCriteriaQuestion.proposedRate;
		}
    };


	//Save (Button)
    task.executeCommand.CM_APVER36SAE19 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //**********************************************************
    //QueryView: Category
    task.gridInitDetailTemplate.QV_UYCTE6570_82 = function(entities, gridInitDetailTemplateArgs) {
        // gridInitDetailTemplateArgs.commons.execServer = false;
    };

    //QueryView: GridExceptions
    task.gridInitDetailTemplate.QV_UERXC4756_18 = function(entities, gridInitDetailTemplateArgs) {
        // gridInitDetailTemplateArgs.commons.execServer = false;
    };

      //IndexSizeActivity.btnReaclcular (Button) View: ApproveCreditRequest
    task.executeCommand.VA_OVECRDTRQE4831_NEIY294 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

    //QueryView: GridCollateral
    task.gridInitDetailTemplate.QV_YCLAE9320_92 = function(entities, gridInitDetailTemplateArgs) {
        // gridInitDetailTemplateArgs.commons.execServer = false;
    };

    //QueryView: GridInsurance
    task.gridInitDetailTemplate.QV_QUNUR2482_02 = function(entities, gridInitDetailTemplateArgs) {
        // gridInitDetailTemplateArgs.commons.execServer = false;
    };

    //QueryView: GridDisbursementForms
    task.gridInitDetailTemplate.QV_QURDM9228_60 = function(entities, gridInitDetailTemplateArgs) {
        // gridInitDetailTemplateArgs.commons.execServer = false;
    };
 //QueryView: GridExceptions
    task.gridInitDetailTemplate.QV_UERXC4756_18 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
        var nav = gridInitDetailTemplateArgs.commons.api.navigation;

        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_50_VPLIC33',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_VPLIC33_VAEPL_011'
        };
		nav.customDialogParameters = {
			Mnemonic:gridInitDetailTemplateArgs.modelRow.mnemonic,
		    VariableEx:entities.VariableExceptions,
			seccion:'E'
		};
        nav.openDetailTemplate('QV_UERXC4756_18', gridInitDetailTemplateArgs.modelRow);
    };

    //QueryView: GridPolicy
    task.gridInitDetailTemplate.QV_QUERO4480_42 = function(entities, gridInitDetailTemplateArgs) {
		gridInitDetailTemplateArgs.commons.execServer = false;
        var nav = gridInitDetailTemplateArgs.commons.api.navigation;

        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_50_VPLIC33',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_VPLIC33_VAEPL_011'
        };
		nav.customDialogParameters = {
			Mnemonic:gridInitDetailTemplateArgs.modelRow.mnemonic,
		    VariablePolicy:entities.VariablePolicy,
			seccion:'P'
		};
        nav.openDetailTemplate('QV_QUERO4480_42', gridInitDetailTemplateArgs.modelRow);
    };


	//QueryView: GridExceptions
    task.gridInitColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
        if(idColumn === 'Aproved'){
			return "<input type=\'checkbox\' name=\'Aproved\' id=\'VA_OVECRDTRQE4824_EULT673\' #if (Aproved === true) {# checked #}# ng-click=\"vc.grids.QV_UERXC4756_18.events.customRowClick($event, \'VA_OVECRDTRQE4824_EULT673\', \'Exceptions\', grids.QV_UERXC4756_18)\" ng-disabled=\"#=(Authorized===\'N\')#\"/>";
		}
    };
    //QueryView: GridExceptions - Actualiza el Valor de la Entidad.
	task.gridRowCommand.VA_OVECRDTRQE4824_EULT673 = function (entities, args) {
        args.commons.execServer = false;
        var index = args.rowIndex;
		for (var i = 0; i<=entities.Exceptions.data.length; i++)
		{
			if (i === index)
				entities.Exceptions.data()[i].Aproved = !entities.Exceptions.data()[i].Aproved;
		}
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

    //updatePoint QueryView: ManagersPointsGrid
    task.gridRowUpdating.QV_MARPN5915_10 = function(entities, gridRowUpdatingEventArgs) {
         gridRowUpdatingEventArgs.commons.execServer = true;
    };
    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //SelectingRole QueryView: ManagersPointsGrid
    task.gridRowSelecting.QV_MARPN5915_10 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

	task.gridRowSelecting.QV_UERXC4756_18 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

	task.gridRowSelecting.QV_ITRIC1523_63 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

	 //InsertingRow QueryView: GridDistributionLine
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {

		if( (gridRowInsertingEventArgs.rowData.CreditType != null && gridRowInsertingEventArgs.rowData.CreditType != "") && (gridRowInsertingEventArgs.rowData.Module != null &&  gridRowInsertingEventArgs.rowData.Module != "")&& gridRowInsertingEventArgs.rowData.Currency != null &&
		gridRowInsertingEventArgs.rowData.AmountProposed != 0 && gridRowInsertingEventArgs.rowData.AmountLocalCurrency != 0 && gridRowInsertingEventArgs.rowData.Quote != 0)
		{
			gridRowInsertingEventArgs.commons.execServer = true;
		}else
		{
			gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_VALIDATEO_88187');
			gridRowInsertingEventArgs.commons.execServer = false;
			gridRowInsertingEventArgs.cancel = true;

		}

    };

	//DeleteRow QueryView: GridDistributionLine
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = true;
    };

	//UpdateRow QueryView: GridDistributionLine
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
		if( (gridRowUpdatingEventArgs.rowData.CreditType != null && gridRowUpdatingEventArgs.rowData.CreditType != "") && (gridRowUpdatingEventArgs.rowData.Module != null &&  gridRowUpdatingEventArgs.rowData.Module != "")&& gridRowUpdatingEventArgs.rowData.Currency != null &&
		gridRowUpdatingEventArgs.rowData.AmountProposed != 0 && gridRowUpdatingEventArgs.rowData.AmountLocalCurrency != 0 && gridRowUpdatingEventArgs.rowData.Quote != 0)
		{

				gridRowUpdatingEventArgs.commons.execServer = true;


		}else
		{
			gridRowUpdatingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_VALIDATEO_88187');
			gridRowUpdatingEventArgs.commons.execServer = false;
		}

    };

    //achp
    task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };
    //**********************************************************
    //  Eventos para Grupos
    //**********************************************************
    //Contenedor de Pestañas (TabbedLayout)  View: ApproveCreditRequest
    task.changeGroup.GR_OVECRDTRQE48_04 = function(entities, changedGroupEventArgs) {
        /*changedGroupEventArgs.commons.execServer = true;
        if((changedGroupEventArgs.commons.item.id === 'GR_OVECRDTRQE48_07') && (changedGroupEventArgs.commons.item.isOpen === true)){
			console.log("Open by " + changedGroupEventArgs.commons.item.id);
			alert('SI SI');
        } else if((changedGroupEventArgs.commons.item.id === 'GR_OVECRDTRQE48_08') && (changedGroupEventArgs.commons.item.isOpen === true)){
			console.log("Open by " + changedGroupEventArgs.commons.item.id);
			alert('YES YES');
        }
		else {
			alert('NO NO');
		}*/
    };
	//Entity:
    //.Autorizar (Button) View: ApproveCreditRequest
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_OVECRDTRQE4827_0000833 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };
	//**********************************************************
    //  Eventos EXECUTE_COMMAND
    //**********************************************************
	task.executeCommandCallback.VA_OVECRDTRQE4827_0000833 = function(entities, executeCommandCallbackEventArgs) { //
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Original || task.IsDisbursement === true){
			executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitAddAmount.commitAddAmount';//MCA- Añade monto en la tabla de montos por sector
		}
	};

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: ApproveCreditRequest
	task.initData.VC_APVER36_PPDET_074 = function(entities, initDataEventArgs) {
		//Oculta Menu de Cabecera en Tabla de amortizacion
		BUSIN.API.GRID.hideFilter('QV_QUYOI3312_16', initDataEventArgs.commons.api);
		BUSIN.API.disable(initDataEventArgs.commons.api.viewState,['VA_OVECRDTRQE4837_AEET493','VA_OVECRDTRQE4837_AETE007','VA_OVECRDTRQE4837_RORT295','VA_OVECRDTRQE4837_OQSO471']);
		initDataEventArgs.commons.api.viewState.addStyle('VC_APVER36_GPOOE_100', 'TabstripOverflow');
		initDataEventArgs.commons.api.viewState.hide("VC_APVER36_TSEIE_892");// Vista Datos de Linea
		initDataEventArgs.commons.api.viewState.hide("GR_OVECRDTRQE48_30");// Pestaña Distribucion de Linea
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');

		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office=cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL =cobis.userContext.getValue(cobis.constant.USER_NAME);



		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.clientId != 0 && client.clientId != undefined && client.clientId != ''){
			var client = initDataEventArgs.commons.api.parentVc.model.Task;
			var cust = new DebtorGeneral(client.clientId,client.clientName, 'D', '');
			listCustomer.push(cust);
			initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
		}
		//APROBACION - DESEMBOLSO BAJO LINEA CREDITO
		if (FLCRE.UTILS.APPLICATION.isDisbursement(initDataEventArgs.commons.api)){
			entities.OriginalHeader.NumberLine = client.bussinessInformationStringOne;
			entities.OriginalHeader.OfficerName = cobis.userContext.getValue(cobis.constant.USER_FULLNAME);
			task.IsDisbursement = true;
			BUSIN.API.show(initDataEventArgs.commons.api.viewState , ['VA_ORIAHEADER8602_FNME018','VA_ORIAHEADER8602_NMLN737']);
		}
           initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_APIB151');
		   initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_FFCE753');
		   initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_SAMN032');
		   initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_SURE913');
		   initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_TERM877');
		   initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_TENY472');
		   initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_UNDU035');
		   initDataEventArgs.commons.api.viewState.disable("VA_OVECRDTRQE4831_NEIY294");
           initDataEventArgs.commons.api.viewState.disable("VA_OFICANSSEW2603_ORNG078");

		   //ABU servicio para validar el riesgo del cliente
			initDataEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICustomerRisk.evaluateCustomerRisk';

		if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
		}
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
			task.Etapa = parentParameters.Task.urlParams.ETAPA;
		}

	};

	task.initDataCallback.VC_APVER36_PPDET_074 = function(entities, initDataEventArgs) {
		var ds = initDataEventArgs.commons.api.vc.model['ManagersPoints'];
		var dsData = ds.data();

		var roh = initDataEventArgs.commons.api.vc.model['RoleHierarchy'];
		var rohData = roh.data();

		var	proposedRate = parseFloat(entities.Rate.AccordingTariffRate);
		for (var i = 0; i < dsData.length; i ++) {
			var dsRow = dsData[i];
			var point = parseFloat(dsRow.SalePoints);
			proposedRate= proposedRate- point;
			initDataEventArgs.commons.api.grid.hideGridRowCommand('QV_MARPN5915_10', dsRow, 'edit');
			for (var j = 0; j < rohData.length; j ++) {
				var rohRow = rohData[j];
			  if(dsRow.IdRole == rohRow.RoleHierarchyIdIni){
					initDataEventArgs.commons.api.grid.showGridRowCommand('QV_MARPN5915_10', dsRow, 'edit');
			  }
			}
		}

		entities.Rate.ProposedRate =proposedRate;//accordingTariffRate;

			initDataEventArgs.commons.api.viewState.disable("VA_OVECRDTRQE4831_ATRN348");
			initDataEventArgs.commons.api.viewState.disable("VA_OVECRDTRQE4831_0000709");
			initDataEventArgs.commons.api.viewState.disable("VA_OVECRDTRQE4831_0000495");
			initDataEventArgs.commons.api.viewState.disable("VA_OVECRDTRQE4831_0000135");
			initDataEventArgs.commons.api.viewState.disable("VA_OVECRDTRQE4831_0000641");

			/*Tambien para task.Etapa ===FLCRE.CONSTANTS.Stage.Aprobacion*/
		if(entities.LineHeader.Sector===entities.IndexSizeActivity.ParameterFixedIncome || entities.OfficerAnalysis.Sector===entities.IndexSizeActivity.ParameterFixedIncome || task.Etapa ===FLCRE.CONSTANTS.Stage.Aprobacion){//entities.IndexSizeActivity.ParameterFixedIncome){
			initDataEventArgs.commons.api.viewState.disable("VA_OVECRDTRQE4831_NEIY294");
		}else{
			  initDataEventArgs.commons.api.viewState.enable ("VA_OVECRDTRQE4831_NEIY294");
		}

		/*Seccion de Expromision*/
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Expromision){
		initDataEventArgs.commons.api.viewState.hide("VA_OFICANSSEW2603_POCT250");
		initDataEventArgs.commons.api.viewState.disable("VA_OFICANSSEW2603_SCOR371");//sector del cliente
		initDataEventArgs.commons.api.viewState.hide("VA_VIWLNEHADE4804_RTAY467");
		initDataEventArgs.commons.api.viewState.hide("VA_OFICANSSEW2603_CRTN299");
		initDataEventArgs.commons.api.viewState.hide("VA_VIWLNEHADE4804_RTAY467");
		initDataEventArgs.commons.api.viewState.show("VA_OFICANSSEW2603_TENY472");
		initDataEventArgs.commons.api.viewState.show("VA_ORIAHEADER8602_XSIN642");
        initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_XSIN642");
        initDataEventArgs.commons.api.viewState.disable("VA_OFICANSSEW2603_TENY472");
		initDataEventArgs.commons.api.viewState.hide("VA_ORIAHEADER8602_CRET312");
		initDataEventArgs.commons.api.viewState.hide("VA_ORIAHEADER8602_QUOA306");
		initDataEventArgs.commons.api.viewState.hide("VA_OFICANSSEW2603_TERM877");
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992'); //Boton Nuevo Operaciones
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978'); //Boton Eliminar Operaciones
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'create'); //Boton Nuevo Operaciones
		}

		//@LGU Flujo Expromision - Aprobacion
		if (entities.OriginalHeader.TypeRequest != FLCRE.CONSTANTS.Tramite.Expromision && entities.OriginalHeader.TypeRequest != FLCRE.CONSTANTS.Tramite.Refinanciamiento){ // si no es expromision se oculta
		  initDataEventArgs.commons.api.viewState.hide('VC_APVER36_TICNT_748');
		}
		if (entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento){ // si es Refinanciamiento
			initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992'); //Boton Nuevo Operaciones
			initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978'); //Boton Eliminar Operaciones
			initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'create'); //Boton Nuevo Operaciones
		}
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Reprogramacion){
			var viewState = initDataEventArgs.commons.api.viewState
			initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992'); //Boton Nuevo Operaciones
			initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978'); //Boton Eliminar Operaciones
			initDataEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'create'); //Boton Nuevo Operaciones
			viewState.show('VC_APVER36_TICNT_748');
			viewState.hide("VA_ORIAHEADER8602_QUOA306");// Campo Cuota
			viewState.hide("VA_ORIAHEADER8602_NQUE773");// Campo Frecuencia de Pago
			viewState.hide("VA_ORIAHEADER8602_CRET312"); //Destino Solicitado
		}
		//@LGU Flujo Expromision - Aprobacion
		entities.OfficerAnalysis.Province = entities.OfficerAnalysis.Province;
		entities.OfficerAnalysis.City = entities.OfficerAnalysis.City;
    };

    task.render = function(entities, renderEventArgs) {
		var ETAPA = renderEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.ETAPA; //dca

		var viewState = renderEventArgs.commons.api.viewState;
		var ctrs = ['VA_ORIAHEADER8602_OQUE134','VA_ORIAHEADER8602_URQT595','VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773',
					'VA_ORIAHEADER8602_CRET312','VA_OVECRDTRQE4821_CIRE384','VA_OVECRDTRQE4823_OSEE169','VA_OVECRDTRQE4814_UREC490',
					'GR_OVECRDTRQE48_14','GR_OVECRDTRQE48_15','GR_OVECRDTRQE48_17','GR_OVECRDTRQE48_18',
					'VC_APVER36_TSLIT_995','VC_APVER36_TSEIE_892','VA_OVECRDTRQE4839_PBTR708','GR_OVECRDTRQE48_34'];
		BUSIN.API.disable(viewState,ctrs);

       // viewState.disable("VA_OFICANSSEW2603_CITY183");

	   BUSIN.API.hide(viewState,['VA_OVECRDTRQE4841_TPPY065']);

		var grid = renderEventArgs.commons.api.grid;
		grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		grid.hideToolBarButton('QV_BOREG0798_55', 'create');

		//TITULO EN COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
		var maxNumRubros = 13;
		var count = entities.AmortizationTableHeader.data().length;
		if(count>maxNumRubros) count=maxNumRubros;
		for (var i=0; i<entities.AmortizationTableHeader.data().length; i++){
			grid.title("QV_QUYOI3312_16", "Item"+(i+1), entities.AmortizationTableHeader.data()[i].Description, false);
			grid.format('QV_QUYOI3312_16',"Item"+(i+1), '#,##0.00');
			grid.format('QV_QUYOI3312_16',"Balance", '#,##0.00');
			grid.format('QV_QUYOI3312_16',"Fee", '#,##0.00');
		}
		//OCULTA COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
		if(entities.AmortizationTableHeader.data().length<maxNumRubros) {
			for (var i=entities.AmortizationTableHeader.data().length+1; i<=maxNumRubros; i++){
				grid.hideColumn ('QV_QUYOI3312_16', 'Item'+i);
				grid.disabledColumn ('QV_QUYOI3312_16', 'Item'+i);
			}
		}
		//HABILITA LAS FILAS DE LA GRILLA DE LAS EXCEPCIONES QUE SE PUEDEN APROBAR
		var ds = renderEventArgs.commons.api.vc.model['Exceptions'];
		var dsData = ds.data();
        for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
            if(dsRow.Authorized === 'N'){
                grid.addRowStyle('QV_UERXC4756_18', dsRow, 'Disable_CTR');
            }else{
				grid.removeRowStyle('QV_UERXC4756_18', dsRow, 'Disable_CTR');
			}
        }

		// OCULTA PESTAÑAS DEACUERDO AL TIPO DE TRAMITE
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Original){
			viewState.hide("GR_OVECRDTRQE48_29");// Pestaña Fuente de Ingresos
			if(task.IsDisbursement === true) {
				//APROBACION - DESEMBOLSO BAJO LINEA CREDITO
				viewState.show("GR_OVECRDTRQE48_30");// Pestaña Distribucion de Linea			
				//----------
				//grid.hideToolBarButton('QV_QERIS7170_82', 'create');
				//viewState.addStyle('QV_QERIS7170_82', 'grupo-lectura');
			}
		}else if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Linea){
			viewState.show("VC_APVER36_TSEIE_892");// Vista Datos de Linea
			viewState.show("GR_OVECRDTRQE48_30");// Pestaña Distribucion de Linea
			viewState.hide("GR_OVECRDTRQE48_05");// Pestaña Rubros
			viewState.hide("GR_OVECRDTRQE48_13");// Pestaña Plan de Pagos
			viewState.hide("GR_OVECRDTRQE48_06");// Pestaña Formas de Desembolso
			viewState.hide("GR_OVECRDTRQE48_20");// Pestaña Beneficios
			//viewState.hide("VA_VIWLNEHADE4804_AAUN561");// Campo Monto Moneda Local
			viewState.hide("VA_ORIAHEADER8602_QUOA306");// Campo Cuota
			viewState.hide("VA_ORIAHEADER8602_NQUE773");// Campo Frecuencia de Pago
			//grid.hideToolBarButton('QV_QERIS7170_82', 'create');
            //viewState.addStyle('QV_QERIS7170_82', 'grupo-lectura');
			viewState.disable('VA_VIWLNEHADE4804_RTAY467');
			viewState.disable('VA_VIWLNEHADE4804_COMT755');
			viewState.hide("VA_OFICANSSEW2603_POCT250"); //tipo de producto
			viewState.hide("VA_OFICANSSEW2603_SCOR371"); //sector del cliente
			viewState.hide("VA_OFICANSSEW2603_ORNG078"); //sector del credito
		    viewState.hide("VA_OFICANSSEW2603_CRTN299");// tipo de credito
			viewState.hide("VA_OFICANSSEW2603_OCEC262");//oficial
			viewState.hide("VA_OFICANSSEW2603_PONE992");//provincia
			viewState.hide("VA_OFICANSSEW2603_CITY183");//ciudad
			viewState.hide("GR_OVECRDTRQE48_34");

		}else if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Expromision ||
                 entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento){
            viewState.hide("VA_ORIAHEADER8602_QUOA306"); //Cuota
            viewState.hide("VA_ORIAHEADER8602_CRET312"); //Destino Solicitado
            viewState.hide("VA_ORIAHEADER8602_NQUE773"); //Frecuencia de Pago
        }else if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Reprogramacion){
			viewState.hide("GR_OVECRDTRQE48_06");// Pestaña Formas de Desembolso
			viewState.hide("GR_OVECRDTRQE48_20");// Pestaña Beneficios
			viewState.hide("VA_ORIAHEADER8602_NMLN737");//Linea
		}
		renderEventArgs.commons.api.viewState.disable("VA_OFICANSSEW2603_CITY183");

		//Habilitar campo de Nivel de Endeudamiento para Linea y Modificacion LC Plazo
		if (entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Linea || entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.ModificacionLinea){
			viewState.show("GR_OVECRDTRQE48_32"); // Pestaña de consulta a Central
			viewState.show("VA_OVECRDTRQE4832_EDNE863"); //Aumento de nivel de endeudamiento
			viewState.show("CM_APVER36SAE19");
		}else{
			viewState.hide("GR_OVECRDTRQE48_32");
			viewState.hide("CM_APVER36SAE19");
		};
         //LGU ORI-0090-2 SPR-2015-14
        // if(task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento){ //CUANDO ES REFINANCIAMIENTO
            var ctrs1 = ['VA_ORIAHEADER8602_EVAL957'];
            var viewState = renderEventArgs.commons.api.viewState, template;

            BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs1);
            BUSIN.API.disable(viewState,ctrs1);
            viewState.template('VA_ORIAHEADER8602_EVAL957', template);

			var ctrs=['VA_ORIAHEADER8602_XSIN642','VA_OFICANSSEW2603_TENY472'];//Se oculta los campos motivos de expromision y el plazo
			BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs);
            BUSIN.API.disable(viewState,ctrs);
        }

		if (task.Etapa ===FLCRE.CONSTANTS.Stage.Aprobacion && task.EtapaTramite === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo){ //DCA  //Linea de Credito(CreditLineValid)//MCA se agrega el tipo ModLineaPlazo
			var ctrs1 = ['VA_ORIAHEADER8602_EVAL957','VA_ORIAHEADER8602_QUOA306'/*Cuota*/,'VA_ORIAHEADER8602_NQUE773'/*Frecuencia de pago*/];
            var viewState = renderEventArgs.commons.api.viewState, template;
            BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs1);
            BUSIN.API.disable(viewState,ctrs1);
		}

        //LGU ORI-0090-2 SPR-2015-14
		//Se deshabilita el nro de LINEA en los siguientes flujos
		if (task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Expromission 
			|| task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Reprogramming 
			|| task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Vivienda
			&&!task.IsDisbursement){
			var ctrs1 = ['VA_ORIAHEADER8602_NMLN737'];
            var viewState = renderEventArgs.commons.api.viewState;
            BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs1);
			BUSIN.API.disable(viewState,ctrs1);
		}
        if (task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Expromission ){
            if (task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion ){
                var ctrs1 = ['VA_OFICANSSEW2603_TENY472','VA_ORIAHEADER8602_EVAL957'];
                var viewState = renderEventArgs.commons.api.viewState;
                BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs1);
                BUSIN.API.disable(viewState,ctrs1);

            }
        }
		if(task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Reprogramming && task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion){
			viewState.show('GR_OVECRDTRQE48_20');//se muestra la pestaña de Beneficios en reprogramacion
		}

		//Para los campos coutaMax, coutaMaxLinea,saldoDisponible -- achp - SOlo para SOLICITUD LINEA DE CREDITO
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Linea && task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion){
			viewState.show('VA_VIWLNEHADE4804_MUQT825');
			viewState.show('VA_VIWLNEHADE4804_MAQI739');
			viewState.show('VA_VIWLNEHADE4804_ALEA255');
		}
		BUSIN.API.disableAsyncForce(renderEventArgs,'VA_VIWLNEHADE4804_ADSN982');
		BUSIN.API.disableAsyncForce(renderEventArgs,'VA_OFICANSSEW2603_CITY183');
    };



	//Validacion primera pregunta
    task.setChangeQuestionYesNoOneQ = function(ApprovalCriteriaQuestion, viewState) {
		if(ApprovalCriteriaQuestion.otherDebtCICQuestion=='S'){
			viewState.enable('VA_OVECRDTRQE4837_AEET493'); //Se habilita la preguta 1.1
			viewState.disable('VA_OVECRDTRQE4837_AETE007');	//Se desabilita la preguta 1.2
			ApprovalCriteriaQuestion.currentRateFIE = ''; //Se borra el campo Calificación Actual FIE
			ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion = '';	//Se borra el valor de la pregunta 1.2
		}else if(ApprovalCriteriaQuestion.otherDebtCICQuestion=='N'){
			viewState.disable('VA_OVECRDTRQE4837_AEET493'); //Se desabilita la preguta 1.1
		    viewState.disable('VA_OVECRDTRQE4837_AETE007');	//Se desabilita la preguta 1.2
			ApprovalCriteriaQuestion.sharedEntityQuestion = ''; //Se borra el valor de la pregunta 1.1
            ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion = ''; //Se borra el valor de la pregunta 1.2
			ApprovalCriteriaQuestion.currentRateFIE = ApprovalCriteriaQuestion.previousRateFIE; //Se asigna el valor inicial de la calificacion
		}
	};

	//validacion segunda pregunta
	task.setChangeQuestionYesNoTwoQ = function(ApprovalCriteriaQuestion, viewState) {
		if(ApprovalCriteriaQuestion.sharedEntityQuestion=='S'){
			viewState.enable('VA_OVECRDTRQE4837_AETE007'); //Se desabilita la preguta 1.2
		}else if(ApprovalCriteriaQuestion.sharedEntityQuestion=='N'){
			viewState.enable('VA_OVECRDTRQE4837_AETE007'); //Se desabilita la preguta 1.2
			ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion = ''; //Se borra el valor de la pregunta 1.2
		}
	};

	//validacion de la tercera pregunta
    task.setChangeQuestionYesNoThreeQ = function(ApprovalCriteriaQuestion) {
		if(ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion=='S'){ //Se mantiene la calificacion del cliente
			ApprovalCriteriaQuestion.currentRateFIE = ApprovalCriteriaQuestion.previousRateFIE; //Se asigna la calificacion antigua
			ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			ApprovalCriteriaQuestion.customerCPOPQuestion = '';
			task.setQuestionMaximumDiscoun(ApprovalCriteriaQuestion);
		}
	};

	//Validaciones para la pregunta 2
	/*validacion Pregunta 4*/
	task.setChangeQuestionFourV2 = function(entities, viewState){
		//Se cuenta el total de deudores para habilitar las siguientes preguntas
		var debtors = entities.DebtorGeneral.data().length;
		entities.ApprovalCriteriaQuestion.recordsMatchingQuestion==''
		//Pregunta igual a No
		if(entities.ApprovalCriteriaQuestion.customerCPOPQuestion=='N'){
			entities.ApprovalCriteriaQuestion.applyRebateCROP = 'N';
			if(debtors > 1){//Es mas de un solicitante se activa la siguiente pregunta 2.1
				viewState.disable('VA_OVECRDTRQE4837_RORT295');

			}
			//if(debtors == 1){
				if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'C' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'X' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX' ){
					entities.ApprovalCriteriaQuestion.currentRateFIE = 'B';
				}
				task.setQuestionMaximumDiscoun(entities.ApprovalCriteriaQuestion);
			//}else{
				//Se mantiene la calificacion de CCA
				//entities.ApprovalCriteriaQuestion.currentRateFIE = entities.ApprovalCriteriaQuestion.previousRateFIE; //calificacion anterior
				if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX'){
					entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
				}else if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'X'){
					entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
				}else if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'C'){
					entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
				}
		}

		//Pregunta igual a Si
		if(entities.ApprovalCriteriaQuestion.customerCPOPQuestion=='S'){
			entities.ApprovalCriteriaQuestion.applyRebateCROP = 'S';
			//task.setCustomerRating(entities); //Valida el valor de la calificacion
			task.setQuestionMaximumDiscoun(entities.ApprovalCriteriaQuestion);
			if(debtors > 1){//Es mas de un solicitante se activa la siguiente pregunta 2.1
				viewState.enable('VA_OVECRDTRQE4837_RORT295');
			}
			if(debtors == 1){//Es un solo solicitante Aplica condiciones preferentes
				viewState.disable('VA_OVECRDTRQE4837_RORT295');
				if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'C' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'X' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX' ){
					entities.ApprovalCriteriaQuestion.currentRateFIE = 'B';
				}
				task.setQuestionMaximumDiscoun(entities.ApprovalCriteriaQuestion);
			}
		}
	}
	/* fin validacion pregunta 4*/


	//Validaciones para la pregunta 2.1
	task.setChangeQuestionFive = function(entities, args){

		var viewState = args.commons.api.viewState
		if(entities.ApprovalCriteriaQuestion.recordsMatchingQuestion=='S'){
			entities.ApprovalCriteriaQuestion.applyRebateCROP = 'S';
			//task.setCustomerRating(entities);
			entities.ApprovalCriteriaQuestion.customerNoCPOPQuestion = '';
			viewState.disable('VA_OVECRDTRQE4837_OQSO471'); //Se habilita la pregunta 2.1.1
			task.preferenceConditions(entities, args);
		}else if(entities.ApprovalCriteriaQuestion.recordsMatchingQuestion=='N'){
			entities.ApprovalCriteriaQuestion.applyRebateCROP = ''; //Se mantiene en blanco el campo Rebaja CPOP
			viewState.enable('VA_OVECRDTRQE4837_OQSO471'); //Se habilita la pregunta 2.1.1
			if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'XX'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}else if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'X'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}else if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'C'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}
		}
	}

	//Validaciones para la pregunta 2.1.1
	task.setChangeQuestionYesNoSixQ = function(entities, args) {
		var viewState = args.commons.api.viewState
		if(entities.ApprovalCriteriaQuestion.customerNoCPOPQuestion=='N'){
			entities.ApprovalCriteriaQuestion.applyRebateCROP = 'S';
			task.preferenceConditions(entities, args);
		}else if(entities.ApprovalCriteriaQuestion.customerNoCPOPQuestion=='S'){
			entities.ApprovalCriteriaQuestion.applyRebateCROP = 'N';
			if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'XX'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}else if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'X'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}else if(entities.ApprovalCriteriaQuestion.previousRateFIE == 'C'){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
			}
		}
	};

	//funcion para validar la calificacion del cliente
	task.setCustomerRating = function(entities){
		if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'AA' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'A' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'B' ){
			entities.ApprovalCriteriaQuestion.currentRateFIE = entities.ApprovalCriteriaQuestion.previousRateFIE;
		} else if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'C' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'X' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX' ){
			entities.ApprovalCriteriaQuestion.currentRateFIE = 'B';
		}
	}

	task.setQuestionMaximumDiscoun = function(ApprovalCriteriaQuestion) {
		if(ApprovalCriteriaQuestion.currentRateFIE=='AA'){
			ApprovalCriteriaQuestion.maximumDiscountCustomerType = 3;
		}else if(ApprovalCriteriaQuestion.currentRateFIE=='A'){
			ApprovalCriteriaQuestion.maximumDiscountCustomerType = 2;
		}else if(ApprovalCriteriaQuestion.currentRateFIE=='B'){
			ApprovalCriteriaQuestion.maximumDiscountCustomerType = 1;
		}
	};

	task.setValidateProposedRate = function(ApprovalCriteriaQuestion){
	    if(ApprovalCriteriaQuestion.rebateCustomerType < ApprovalCriteriaQuestion.tariffRate){
	        ApprovalCriteriaQuestion.proposedRate = ApprovalCriteriaQuestion.tariffRate - ApprovalCriteriaQuestion.rebateCustomerType;
		    ApprovalCriteriaQuestion.proposedRate = ApprovalCriteriaQuestion.proposedRate.toFixed(2);
		}
	};

	task.setValidateTariffRate = function(ApprovalCriteriaQuestion, viewState){
	    if(ApprovalCriteriaQuestion.applyRebateCROP == 'S'){
			if (ApprovalCriteriaQuestion.tariffRate < 1 && ApprovalCriteriaQuestion.tariffRate > 0){
				ApprovalCriteriaQuestion.proposedRate = 'entre';
			}else{
				viewState.translate('BUSIN.DLB_BUSIN_SDFIVNE0Y_61468');
			}
		}
	};

	task.updateRow = function (entities,api){
	  var listCat = entities.Category.data();
	     for (var i = 0; i < listCat.length; i++) {
		    if(listCat[i].Concept == 'INT'){
			   var rowIndex = i;
			   api.grid.updateRow('Category', rowIndex, {
			   Percentage : entities.ApprovalCriteriaQuestion.proposedRate
			   });
			break;
			}
		 }
	};

	task.preferenceConditions = function(entities, args){
		var api = args.commons.api;
		if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'AA'){
			entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 3;
			if(entities.ApprovalCriteriaQuestion.rebateCustomerType == 0 || entities.ApprovalCriteriaQuestion.rebateCustomerType == null || entities.ApprovalCriteriaQuestion.rebateCustomerType < 0){
				args.commons.messageHandler.showMessagesError('Para la calificación AA es obligatorio bajar hasta un punto y opcional hasta 2 puntos');
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
				api.viewState.disable('VA_OVECRDTRQE4841_TPPY065');
			}else if(entities.ApprovalCriteriaQuestion.rebateCustomerType == 3){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 3;
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
				api.viewState.enable('VA_OVECRDTRQE4841_TPPY065');
			}else if(entities.ApprovalCriteriaQuestion.rebateCustomerType > 3){
				args.commons.messageHandler.showMessagesError('Para la calificación AA, maximo se puede rebajar 3 puntos');
				api.viewState.disable('VA_OVECRDTRQE4841_TPPY065');
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
			}else{
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
				api.viewState.enable('VA_OVECRDTRQE4841_TPPY065');
			}
		}
		if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'A'){
			entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 2;
			if(entities.ApprovalCriteriaQuestion.rebateCustomerType == 0 || entities.ApprovalCriteriaQuestion.rebateCustomerType == null || entities.ApprovalCriteriaQuestion.rebateCustomerType < 0){
				args.commons.messageHandler.showMessagesError('Para la calificación A es obligatorio bajar hasta un punto y opcional hasta 2 puntos');
				api.viewState.disable('VA_OVECRDTRQE4841_TPPY065');
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
			}else if(entities.ApprovalCriteriaQuestion.rebateCustomerType == 2){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 2;
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
				api.viewState.enable('VA_OVECRDTRQE4841_TPPY065');
			}else if(entities.ApprovalCriteriaQuestion.rebateCustomerType > 2){
				args.commons.messageHandler.showMessagesError('Para la calificación A, maximo se puede rebajar 2 puntos');
				api.viewState.disable('VA_OVECRDTRQE4841_TPPY065');
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
			}else{
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
				api.viewState.enable('VA_OVECRDTRQE4841_TPPY065');
			}
		}
		if(entities.ApprovalCriteriaQuestion.currentRateFIE == 'B'){
			entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 1;
			if(entities.ApprovalCriteriaQuestion.rebateCustomerType == 0 || entities.ApprovalCriteriaQuestion.rebateCustomerType == null || entities.ApprovalCriteriaQuestion.rebateCustomerType < 0){
				args.commons.messageHandler.showMessagesError('Cliente CPOP debe rebajar de 0 hasta 1 punto');
				api.viewState.disable('VA_OVECRDTRQE4841_TPPY065');
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate
			}else if(entities.ApprovalCriteriaQuestion.rebateCustomerType == 1){
				entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 1;
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
				api.viewState.enable('VA_OVECRDTRQE4841_TPPY065');
			}else if(entities.ApprovalCriteriaQuestion.rebateCustomerType > 1){
				args.commons.messageHandler.showMessagesError('Para la calificación B, maximo se puede rebajar 1 punto');
				api.viewState.disable('VA_OVECRDTRQE4841_TPPY065');
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
			}else{
				entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - entities.ApprovalCriteriaQuestion.rebateCustomerType;
				api.viewState.enable('VA_OVECRDTRQE4841_TPPY065');
			}
		}
	}


	task.IsDisbursement = false;

}());

DebtorGeneral = function(idClient, name, role, idNumber){
    this.CustomerCode = idClient;
    this.CustomerName = name;
    this.Role = role;
    this.Identification = idNumber;
}