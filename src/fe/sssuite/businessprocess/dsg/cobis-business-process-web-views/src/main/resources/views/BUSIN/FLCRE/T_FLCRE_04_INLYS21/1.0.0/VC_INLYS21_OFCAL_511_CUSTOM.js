<!-- Designer Generator v 5.0.0.1505 - release SPR 2015-05 20/03/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.applicationanalysis;
	task.IsDisbursement = false;
	task.etapa   = '';
	task.tramite = '';
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
   //Clarification QueryView: GridSourceRevenueCustomer
   task.gridRowCommand.VA_RIOTRDTAVI4908_LRIN325 = function(entities, gridRowCommandEventArgs) {
        gridRowCommandEventArgs.commons.execServer = false;
        gridRowCommandEventArgs.commons.api.vc.serverParameters.SourceRevenueCustomer = true;
		var nav = gridRowCommandEventArgs.commons.api.navigation;
		nav.label =cobis.translate('BUSIN.DLB_BUSIN_TALAONAIV_74609');
        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_17_SEVNO59',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_SEVNO59_LSREU_678'
        };
        nav.customDialogParameters = {
            //detailSourceRevenue: entities['SourceRevenueCustomer']
			detailSourceRevenue:gridRowCommandEventArgs.rowData.detailClarification,
			detailSubActividadEconomica:gridRowCommandEventArgs.rowData.subActivityEconomic
        };

		nav.modalProperties = {
			//Hay 3 tamaños permitidos:  sm - pequeño, lg - grande, o si no se declara usa el mediano
			//size: 'sm',
			//opcionalmente se puede definir una altura
			//height: 350,
			//si es llamado desde un evento de grilla el valor es true
			callFromGrid: true
		};
		nav.openModalWindow('VA_RIOTRDTAVI4908_LRIN325', gridRowCommandEventArgs.rowData);
    };

	//Entity: CreditOtherData
    //CreditOtherData.CreditDestination (TextInputButton) View: CreditOtherDataView
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto.
    task.textInputButtonEvent.VA_RIOTRDTAVI4904_EDSN666 = function(textInputButtonEventArgs) {
		textInputButtonEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.openFindLoan(textInputButtonEventArgs,[],null);
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
		OTHERCREDITDATA.changeActivity(entities, changedEventArgs,task.tramite);
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

	task.closeModalEvent.VC_CCOVI89_AECIT_172 = function(closeModalEventArgs) {
		var api = closeModalEventArgs.commons.api;
		var result = closeModalEventArgs.result['actividadEconomicaSeleccionada'];
		api.vc.model['CreditOtherData'].CreditDestinationValue = result.economicActivity;
		api.vc.model['CreditOtherData'].CreditDestination = result.codeEconomicActivity;
	};

    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

	//.Btn_Validate (Button) View: CreditOtherDataView  --Ady
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
		var parentParameters = executeCommandEventArgs.commons.api.parentVc.customDialogParameters;
		var etapa   = null;
		var tramite = null;
		var cuotaMaxima = null;
		var sumatoria = null;

	   	/*Para no dañar la primera validacion la segunda validacion
	   	solo se hizo en el custom para analisis de oficial en Refinaciamiento
	   	y desembolso Bajo LC */
		if(!BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.Etapa) && !BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.Tramite) ){
			etapa = parentParameters.Task.urlParams.Etapa;
			tramite = parentParameters.Task.urlParams.Tramite
		}
		if (((etapa===FLCRE.CONSTANTS.Stage.Analisis) && (tramite ===FLCRE.CONSTANTS.RequestName.Refinancing))||((etapa==='ANALISIS_OFICIAL' && (tramite ==='DESEMBOLSO_LC')))){
			if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.MaximumQuota)){
				if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.SumQuota)){
						cuotaMaxima = entities.ValidationQuotaVsAvailableBalance.MaximumQuota ;
						sumatoria = entities.ValidationQuotaVsAvailableBalance.SumQuota;
						if (cuotaMaxima>sumatoria){ // Validación Exitosa
							executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_UCESLIDAO_73855');
							return;
						}else{ // La Cuota Maxima debe ser mayor a la Sumatoria de las cuotas
							BUSIN.INBOX.STATUS.nextStep(false,executeCommandEventArgs.commons.api);
							executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MAXIMAFEE_23007');
						}
				}else{ //Mensaje Sumatoria Cuota no debe ser vacio
					executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FEESSUMUB_60939');
				}
			}else{ //Mensaje  Cuota Maxima no debe ser vacio
				executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FEEMAXIMA_06284');
			}
			executeCommandEventArgs.commons.execServer = false;
		}else{ // realizar validacion inicial
			if(entities.ValidationQuotaVsAvailableBalance.Rate === "" || entities.ValidationQuotaVsAvailableBalance.Rate === null ||
				entities.ValidationQuotaVsAvailableBalance.Term === "" || entities.ValidationQuotaVsAvailableBalance.Term === null ||
				entities.ValidationQuotaVsAvailableBalance.MaximumQuota === "" || entities.ValidationQuotaVsAvailableBalance.MaximumQuota === null ||
				entities.ValidationQuotaVsAvailableBalance.MaximumQuotaLine === "" || entities.ValidationQuotaVsAvailableBalance.MaximumQuotaLine === null
			){
				executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_CCKEMTFEL_83493');// Verificar campo vacio
				executeCommandEventArgs.commons.execServer = false;
			}else{
				executeCommandEventArgs.commons.execServer = true;
			}
		}
    };

	task.executeCommandCallback.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandCallbackEventArgs) {
		if(task.IsDisbursement === true) {
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}
    };

	//ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: CreditOtherDataView  -- Ady
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
		task.validateMount(entities.ValidationQuotaVsAvailableBalance.MaximumQuota, changedEventArgs,true);
    };

	//ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: ApproveCreditRequest -- Ady
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
        if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Term) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.OriginalHeader.AmountRequested) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Rate) )
        {
			changedEventArgs.commons.execServer = task.validateMount(entities.ValidationQuotaVsAvailableBalance.Rate, changedEventArgs,true);
		}else{
			changedEventArgs.commons.execServer = false;
		}
    };

    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: CreditOtherDataView   -- Ady
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
        if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Term) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.OriginalHeader.AmountRequested) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Rate) )
        {
            changedEventArgs.commons.execServer = task.validateMount(entities.ValidationQuotaVsAvailableBalance.Term, changedEventArgs,true);
		}else{
			changedEventArgs.commons.execServer = false;
		}
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };
    //OfficerAnalysis.AOProductType (ComboBox) View: OfficerAnalysisView
    task.change.VA_OFICANSSEW2603_POCT250 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };
	  //OriginalHeader.AttAmount (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

	task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
        if(parseInt(entities.OriginalHeader.Quota) > parseInt(entities.OriginalHeader.AmountRequested) ){
			changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_YETLSETDO_10126');
			changedEventArgs.focus =true;
			entities.OriginalHeader.Quota='';
		}
    };

	//OfficerAnalysis.Sector (ComboBox) View: OfficerAnalysisView
	task.change.VA_OFICANSSEW2603_SCOR371 = function(entities, changedEventArgs) {
		var serverParameters = changedEventArgs.commons.api.vc.serverParameters;
		serverParameters.IndexSizeActivity = true;
		serverParameters.OfficerAnalysis = true;
		serverParameters.LineHeader = true;
		serverParameters.HeaderGuaranteesTicket = true;
		changedEventArgs.commons.execServer = true;

		if(changedEventArgs.newValue===entities.IndexSizeActivity.ParameterFixedIncome){
			entities.IndexSizeActivity.Patrimony="";
			entities.IndexSizeActivity.PersonalNumber="";
			entities.IndexSizeActivity.Sales="";
			entities.IndexSizeActivity.IndexSizeActivity="";
			entities.IndexSizeActivity.AnnualSales="";
			entities.IndexSizeActivity.ProductiveAssets="";
			entities.IndexSizeActivity.sizeCompany = "";
			changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_ATRN190");
			changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_SALE147");
			changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_PESL753");
			changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NEIY699");
			changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NULE410");
			changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_RCIE187");
			changedEventArgs.commons.execServer = false;
		}else{
			entities.IndexSizeActivity.Patrimony="";
			entities.IndexSizeActivity.PersonalNumber="";
			entities.IndexSizeActivity.Sales="";
			entities.IndexSizeActivity.IndexSizeActivity="";
			entities.IndexSizeActivity.AnnualSales="";
			entities.IndexSizeActivity.ProductiveAssets="";
			changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_NULE410");
			changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_RCIE187");
			changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_ATRN190");
			changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_SALE147");
			changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_PESL753");
			changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_NEIY699");
			if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
			entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
			changedEventArgs.commons.execServer = true;
			}else{
				changedEventArgs.commons.execServer = false;
			}
		}
    };

	//IndexSizeActivity.Patrimony (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
		if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
			entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
			changedEventArgs.commons.execServer = true;
		}else{
			changedEventArgs.commons.execServer = false;
		}
    };

	//IndexSizeActivity.PersonalNumber (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
		if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
			entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
			changedEventArgs.commons.execServer = true;
		}else{
			changedEventArgs.commons.execServer = false;
		}
    };

	//IndexSizeActivity.Sales (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
		if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
			entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
			changedEventArgs.commons.execServer = true;
		}else{
			changedEventArgs.commons.execServer = false;
		}
    };

	task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };

    //OriginalHeader.AttIDRequested (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_RQSD386 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
		if(entities.OriginalHeader.IDRequested == null || entities.OriginalHeader.IDRequested == ""){
			changeEventArgs.commons.execServer = false; //el mensaje de err no baja al svr
		}
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button)
    task.executeCommand.CM_INLYS21AVE08 = function(entities, executeCommandEventArgs) {
	    executeCommandEventArgs.commons.api.vc.serverParameters = {};
		if( task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial) {//EN ETAPA DE ANALISIS DEL OFICIAL VALIDA QUE ESTE LLENO EL CAMPO 'FECHA-CIC'
			if(!FLCRE.UTILS.CUSTOMER.hasDateCIC(entities,executeCommandEventArgs,true)){
				executeCommandEventArgs.commons.execServer = false;
				return;
			}
		}
    };

	//**********************************************************
    //  Eventos de QUERY VIEW
    //**********************************************************
    //QueryView: GridSourceRevenueCustomer
    task.gridInitDetailTemplate.QV_RURCE2364_74 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
		var nav = gridInitDetailTemplateArgs.commons.api.navigation;
        var api = gridInitDetailTemplateArgs.commons.api;
        nav.customDialogParameters = { };
        nav.address = {
           moduleId: 'BUSIN',
           subModuleId: 'FLCRE',
           taskId: 'T_FLCRE_87_TRCOR12',
           taskVersion: '1.0.0',
           viewContainerId: 'VC_TRCOR12_RENCO_641'
        };
        nav.openDetailTemplate('QV_RURCE2364_74', gridInitDetailTemplateArgs.modelRow);
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
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

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        beforeOpenGridDialogEventArgs.commons.execServer = true;
    };

    //CommandNew (Button) QueryView: GridSourceRevenueCustomer
    task.gridCommand.CEQV_201_QV_RURCE2364_74_651 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
		var api = gridExecuteCommandEventArgs.commons.api, dsData, dsRow;
		api.grid.addRow('SourceRevenueCustomer',{Type: 'Nuevo', Sector: ' ', SubSector: ' ', EconomicActivity: ' '});
		dsData = api.vc.model['SourceRevenueCustomer'].data();
		dsRow = dsData[dsData.length-1];
		var uigrid = $('#' + 'QV_RURCE2364_74').data('kendoGrid');
		uigrid.expandRow($("[data-uid=\'" + dsRow.uid + "\']"));
    };

    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, queryViewCommandEventArgs) {
		 queryViewCommandEventArgs.commons.execServer = false;
		 FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(queryViewCommandEventArgs,true);
    };

	task.gridInitColumnTemplate.QV_BOREG0798_55 = function(idColumn) { //QueryView: Borrowers
		 if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC();
		}
	};
	task.change.VA_BORRWRVIEW2783_DTCC540 = function(entities, changedEventArgs) {//Change - Fecha CIC
		changedEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.setDateCIC(changedEventArgs);
	};
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: Application Analysis
    task.initData.VC_INLYS21_OFCAL_511 = function(entities, initDataEventArgs) {
		BUSIN.SYSTEM.importScript('OtherCreditData.js');
		BUSIN.SYSTEM.importScript('CreditBureau.js');
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = initDataEventArgs.commons.api.viewState;
		task.tramite = parentParameters.Task.urlParams.Tramite;
		task.etapa = parentParameters.Task.urlParams.Etapa;
		entities.OfficerAnalysis.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office=cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.NumberLine = parentParameters.Task.bussinessInformationStringOne;
		//ANALISIS DEL OFICIAL - MODIFICACIÓN LINEA DE CRIDITO PLAZO-MCA
		if (task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial && task.tramite === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo){
			// Se oculta pestaña de validación de cuota vs saldo
			var ctrs = ['VA_RIOTRDTAVI4912_MAMU147','VA_RIOTRDTAVI4912_UMUA249','VA_RIOTRDTAVI4912_0000847'];
		    BUSIN.API.disable(viewState,ctrs);
			BUSIN.API.hide(viewState,ctrs);
		}
		//OCULTAR FILTROS DE CABECERAS DE GRID
		BUSIN.API.GRID.hideFilter('QV_BOREG0798_55', initDataEventArgs.commons.api);
		BUSIN.API.GRID.hideFilter('QV_QERIS7170_82', initDataEventArgs.commons.api);

		//Validando campos que no se pueden modificar
		viewState.enable("VA_ORIAHEADER8602_0000908"); //BORRAR DESPUES SOLO PRUEBAS
		viewState.enable("VA_ORIAHEADER8602_ITCE121");//BORRAR DESPUES SOLO PRUEBAS
		viewState.hide("VA_RIOTRDTAVI4912_IULI202");//RLA
        viewState.hide("VA_RIOTRDTAVI4912_RATE281");//RLA
        viewState.hide("VA_RIOTRDTAVI4912_TERM010");//RLA
        viewState.show("VA_RIOTRDTAVI4912_UMUA249");//RLA

		//campo codigo actividad economica
		viewState.hide('VA_RIOTRDTAVI4904_EDSN666');
		viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true);
		viewState.enableValidation('VA_RIOTRDTAVI4904_EDSN666',VisualValidationTypeEnum.RangeValues);

		var ctrs = ['VA_ORIAHEADER8602_IOUR445','VA_ORIAHEADER8602_RQSD386','VA_ORIAHEADER8602_0000908','VA_ORIAHEADER8602_ITCE121','VA_ORIAHEADER8602_OQUE134',
					'VA_ORIAHEADER8602_URQT595','VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773','VA_ORIAHEADER8602_CRET312','VA_ORIAHEADER8602_IALT328',
					'VA_OFICANSSEW2603_SCOR371'];
		BUSIN.API.disable(viewState,ctrs);

		ctrs = ['VA_OFICANSSEW2603_APIB151','VA_OFICANSSEW2603_FFCE753','VA_ORIAHEADER8602_QUOA306'/*Campo Cuota*/,'VA_ORIAHEADER8602_NQUE773'/*Campo Frecuencia de pago*/]
		BUSIN.API.hide(viewState,ctrs);

		ctrs = ['VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_UNDU035','VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_POCT250',
				'VA_OFICANSSEW2603_TENY472','VA_OFICANSSEW2603_TERM877'];
		BUSIN.API.enable(viewState,ctrs);

		ctrs = ['VA_OFICANSSEW2603_PONE992','VA_OFICANSSEW2603_CITY183','VA_OFICANSSEW2603_CRTN299','VA_RIOTRDTAVI4904_EDSN666'];
		BUSIN.API.enable(viewState,ctrs);

		//entities.OriginalHeader.CurrencyRequested="0";
		ctrs = ['VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_UNDU035','VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_TERM877'];
		BUSIN.API.hide(viewState,ctrs);

		//ALISIS DEL OFICIAL - DESEMBOLSO BAJO LINEA CREDITO
		if (task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial && task.tramite === FLCRE.CONSTANTS.RequestName.Desembolso){
			entities.OriginalHeader.OfficerName = cobis.userContext.getValue(cobis.constant.USER_FULLNAME);
			task.IsDisbursement = true;
			BUSIN.API.show(viewState , ['VA_ORIAHEADER8602_FNME018','VA_ORIAHEADER8602_NMLN737','VA_ORIAHEADER8602_RUCE927','VA_ORIAHEADER8602_GCUN722']);
			//campo plazo
			BUSIN.API.disable(viewState,['VA_OFICANSSEW2603_TENY472']);
			BUSIN.API.hide(viewState,['VA_OFICANSSEW2603_TENY472']);
			BUSIN.API.disable(viewState,['VA_OFICANSSEW2603_POCT250']);
			BUSIN.API.hide(viewState,['VA_OFICANSSEW2603_POCT250']);
			BUSIN.API.hide(viewState,['VA_OFICANSSEW2603_OCEC262']);
			viewState.readOnly('VA_ORIAHEADER8602_RUCE927', false);
			viewState.readOnly('VA_ORIAHEADER8602_GCUN722', false);
		}
		//ALISIS DEL OFICIAL - ORIGINAL
		if (task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial && task.tramite === FLCRE.CONSTANTS.RequestName.Original){
			viewState.hide('VA_OFICANSSEW2603_TENY472');
			BUSIN.API.show(viewState , ['VA_ORIAHEADER8602_RUCE927','VA_ORIAHEADER8602_GCUN722']);
			viewState.readOnly('VA_ORIAHEADER8602_RUCE927', false);
			viewState.readOnly('VA_ORIAHEADER8602_GCUN722', false);
		}
		//ALISIS DEL OFICIAL - EXPROMISION
		if (task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial && task.tramite === FLCRE.CONSTANTS.RequestName.Expromission){
			BUSIN.API.show(viewState , ['VA_ORIAHEADER8602_RUCE927','VA_ORIAHEADER8602_GCUN722']);
			viewState.readOnly('VA_ORIAHEADER8602_RUCE927', false);
			viewState.readOnly('VA_ORIAHEADER8602_GCUN722', false);
		}

		entities.Context.RequestStage = task.etapa;
		entities.Context.RequestName = task.tramite;
    };

	task.initDataCallback.VC_INLYS21_OFCAL_511 = function(entities, initDataEventArgs) {
		if(initDataEventArgs.success) {
			if( task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial) {//EN ETAPA DE ANALISIS DEL OFICIAL SE PONE VISIBLE EL CAMPO FECHA-CIC
				initDataEventArgs.commons.api.grid.showColumn ('QV_BOREG0798_55', 'DateCIC');
			}
		}
	 };

	//Validacion de success del server para habilitacion de boton continuar
	task.executeCommandCallback.CM_INLYS21AVE08 = function(entities, executeCommandCallbackEventArgs) {
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
		if(task.IsDisbursement === false) {
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}
		//EN ETAPA DE ANALISIS DEL OFICIAL SE VALIDA BOTON CONTINUAR
		if( task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial) {
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}
	};
		 //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
		gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        FLCRE.UTILS.CUSTOMER.openFindCustomer(entities,gridABeforeEnterInLineRowEventArgs,{},true);
    };
	task.closeModalEvent.findCustomer = function (args) {
		FLCRE.UTILS.CUSTOMER.addDebtorFromSearch(args,'C',true);
    };
	task.render = function(entities, renderEventArgs) {
		renderEventArgs.commons.execServer = false;
		var viewState = renderEventArgs.commons.api.viewState;
		BUSIN.API.hide(viewState,['GR_RIOTRDTAVI49_11','GR_RIOTRDTAVI49_12','VC_INLYS21_EROES_021','GR_RIOTRDTAVI49_15']);
		viewState.disable('GR_RIOTRDTAVI49_12');

		if( task.etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial) {//EN ETAPA DE ANALISIS DEL OFICIAL SE OCULTA EL CAMPO DE TIPO DE CREDITO
		    viewState.hide('VA_OFICANSSEW2603_CRTN299');
		    CREDITBUREAU.QUERYCENTRAL.validateLevelIndebtedness(entities, renderEventArgs, 'VA_RIOTRDTAVI4907_EDNE010' );
		    viewState.readOnly('VA_OFICANSSEW2603_ORNG078',true); //desabilita el obligatorio y la edición del campo sector del credito
		}

		if(entities.OfficerAnalysis.Sector===entities.IndexSizeActivity.ParameterFixedIncome){
			entities.IndexSizeActivity.Patrimony="";
			entities.IndexSizeActivity.PersonalNumber="";
			entities.IndexSizeActivity.Sales="";
			entities.IndexSizeActivity.IndexSizeActivity="";

			var ctrs = ['VA_RIOTRDTAVI4909_ATRN190','VA_RIOTRDTAVI4909_SALE147','VA_RIOTRDTAVI4909_PESL753',
			'VA_RIOTRDTAVI4909_NEIY699','VA_RIOTRDTAVI4909_NULE410','VA_RIOTRDTAVI4909_RCIE187'];
			BUSIN.API.disable(viewState,ctrs);
		}else{
			//renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NULE410");
			//renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_RCIE187");
		}
		if(task.IsDisbursement === true) {
			//ANALISIS DEL OFICIAL - DESEMBOLSO BAJO LINEA CREDITO
			var grid = renderEventArgs.commons.api.grid;
			BUSIN.API.show(viewState,['GR_RIOTRDTAVI49_11','GR_RIOTRDTAVI49_12']); // Pestaña Distribucion de Linea, Moneda -- ady
			viewState.enable('GR_RIOTRDTAVI49_12');
			viewState.addStyle('QV_QERIS7170_82', 'grupo-lectura');
			grid.hideToolBarButton('QV_QERIS7170_82', 'create');
			//QUITA BOTONES DEL GRID DE DUDORES
			grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
			grid.hideToolBarButton('QV_BOREG0798_55', 'create');

			/*Deshabilitando validacion de campos requeridos en pestaña oculta Validacion de Cuota Vs. Saldo Disponible*/
		    viewState.disableValidation('VA_RIOTRDTAVI4912_MAMU147',VisualValidationTypeEnum.Required);
			if(entities.LineHeader.Rotary=='S'){
				viewState.disable('VA_RIOTRDTAVI4912_TERM010');
			}else{
				viewState.enable('VA_RIOTRDTAVI4912_TERM010');
			}

			//DESEMBOLSO BL DESABILITADOS CAMPOS DE ValidationQuotaVsAvailableBalance -- histoAct
			var ctrs = ['VA_RIOTRDTAVI4912_MAMU147','VA_RIOTRDTAVI4912_UMUA249'];
		    BUSIN.API.disable(viewState,ctrs);
		}
		if(entities.OriginalHeader.TypeRequest == FLCRE.CONSTANTS.Tramite.Expromision && entities.OriginalHeader.Expromission != null){
			//EXPROMISION
			var grid = renderEventArgs.commons.api.grid;
			viewState.show("VC_INLYS21_EROES_021");
			viewState.show("VA_ORIAHEADER8602_XSIN642");
			viewState.disable("VA_ORIAHEADER8602_XSIN642");
			viewState.disable("VA_RIOTRDTAVI4904_TATT517");

			BUSIN.API.hide(viewState,['VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773']);

			var ctrs = ['VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_CRET312','VA_ORIAHEADER8602_NQUE773',
			            'VA_OFICANSSEW2603_APIB151','VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_UNDU035',
		                'VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_POCT250','VA_OFICANSSEW2603_FFCE753','VA_OFICANSSEW2603_CRTN299','VA_OFICANSSEW2603_TENY472'
						];
			BUSIN.API.hide(viewState,ctrs);

			grid.hideToolBarButton('QV_ITRIC1523_37', 'CEQV_201_QV_ITRIC1523_37_807');
			grid.hideToolBarButton('QV_ITRIC1523_37', 'CEQV_201_QV_ITRIC1523_37_856');
			//Ocultando botones de Deudores
			grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
			grid.hideToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
			var columns = ['IdOperation', 'RefinancingOption', 'IsBase', 'oficialOperation']
			BUSIN.API.GRID.hideColumns('QV_ITRIC1523_37', columns, renderEventArgs.commons.api)

			var ctrs = ['VA_RIOTRDTAVI4904_RPPU470','VA_RIOTRDTAVI4904_DSNS029','VA_RIOTRDTAVI4904_OUED020','VA_RIOTRDTAVI4904_EDSN666'];
		    BUSIN.API.disable(renderEventArgs.commons.api.viewState,ctrs);

			//Se incluye un template al combo de ¿A qué Actividad se Destinará el Crédito? de la pestaña Otros Datos Credito
			var viewState = renderEventArgs.commons.api.viewState, template, templateActivityDestinationCredit;
			template = '<span>#: code #</span>' + '<span>-</span>'+ '<span>#: value #</span>';
			viewState.template('VA_RIOTRDTAVI4904_TATT517', template);
		}

		OTHERCREDITDATA.disableElements(entities, renderEventArgs,task.tramite); // para deshabilitar si viene el sector vacio
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

	//Rowupdating QueryView: GridVariableData
    task.gridRowUpdating.QV_QUERV3248_81 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

      //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView
    task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function(loadCatalogDataEventArgs) {
		// Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OfficerAnalysis = true;
		//serverParameters.DebtorGeneral = true;
		loadCatalogDataEventArgs.commons.execServer = true;
    };

	      //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView
    task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {
		// Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OfficerAnalysis = true;
		serverParameters.DebtorGeneral = true;
		serverParameters.HeaderGuaranteesTicket = true;
		loadCatalogDataEventArgs.commons.execServer = true;
    };

	//RowSelecting QueryView: GridExpromissionOperations
    task.gridRowSelecting.QV_ITRIC1523_37 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

	task.disableNullValue = function(entities, control, ventArgs) {
		if(entities != null || entities != undefined){
		    ventArgs.commons.api.viewState.disable(control);
		}else{
		    ventArgs.commons.api.viewState.enable(control);
		}
	};

	task.validateMount = function(value, args, showMessage) {
        args.commons.execServer = false;
        if(BUSIN.VALIDATE.IsNull(value) || (value==0)){
            if(showMessage===true){args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_IPAESOZEO_95873');}
            return false;
        }
        return true;
    };

}());