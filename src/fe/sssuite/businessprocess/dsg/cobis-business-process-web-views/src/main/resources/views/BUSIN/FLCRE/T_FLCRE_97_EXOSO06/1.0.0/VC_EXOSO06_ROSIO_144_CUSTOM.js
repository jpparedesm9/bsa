<!-- Designer Generator v 5.0.0.1510 - release SPR 2015-10 29/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.genericexpromission;
	task.EtapaTramite = '';
	task.Etapa = '';
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) { //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) { //DebtorGeneral.Role (ComboBox) View: BorrowerView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_OFICANSSEW2603_POCT250 = function(entities, changedEventArgs) { //OfficerAnalysis.AOProductType (ComboBox) View: OfficerAnalysisView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_OFICANSSEW2603_SCOR371 = function(entities, changedEventArgs) { //OfficerAnalysis.Sector (ComboBox) View: OfficerAnalysisView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_OQUE134 = function(entities, changedEventArgs) { //OriginalHeader.AmountRequested (TextInputBox) View: HeaderView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) { //OriginalHeader.Quota (TextInputBox) View: HeaderView
		changedEventArgs.commons.execServer = false;
		if(entities.OriginalHeader.Quota===0){
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_GEDTTDCRO_41910');
		 }
    };
    task.change.VA_ORIAHEADER8602_URQT595 = function(entities, changedEventArgs) { //OriginalHeader.CurrencyRequested (ComboBox) View: HeaderView
		if(changedEventArgs.newValue===null || changedEventArgs.newValue===''){
			changedEventArgs.commons.execServer = false;
			task.clearHeaderData(entities);
		}else if(!task.hasOperations(entities, changedEventArgs)){
			changedEventArgs.commons.execServer = false;
			task.clearHeaderData(entities);
		}
    };
    task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function(loadCatalogDataEventArgs) {

		// Para enviar solo la entidad que se necesita en el load
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OfficerAnalysis = true;
	}; //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView

	task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {
		loadCatalogDataEventArgs.commons.execServer = false;
    };
	//Entity: OriginalHeader
    //OriginalHeader.CurrencyRequested (ComboBox) View: HeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.loadCatalog.VA_ORIAHEADER8602_URQT595 =  function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.api.vc.serverParameters.OfficerAnalysis = true;
		loadCatalogDataEventArgs.commons.api.vc.serverParameters.OriginalHeader = true;
		loadCatalogDataEventArgs.commons.execServer = true;

    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
	//Print (Button)
    task.executeCommand.CM_EXOSO06PRN39 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;

		var debtor = FLCRE.UTILS.CUSTOMER.getDebtor(entities.DebtorGeneral.data());
		if(debtor!=null){
		   if(entities.OriginalHeader.IDRequested!=null){
					//var args = [['cstDebtor',debtor.CustomerCode],['cstName',debtor.CustomerName],['cstId',debtor.Identification],['cstTrId',entities.OriginalHeader.IDRequested],['cstAplId',entities.OriginalHeader.ApplicationNumber]];
					var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.LoanApplication],['cstDebtor',debtor.CustomerCode],['cstName',debtor.CustomerName],['cstId',debtor.Identification],['cstTrId',entities.OriginalHeader.IDRequested],['cstAplId',entities.OriginalHeader.ApplicationNumber]];
					var debtors = entities.DebtorGeneral.data();
					var count = 0;
					for (var i = 0; i < debtors.length; i++) {
						if(debtors[i].Role == 'C'){
							count = count + 1;
							args.push(['cstCodeu'+count, debtors[i].CustomerCode]);
						}
					}
					BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.LoanApplication,args);
				} else {
			//Mensaje de que no existe aun el tramite
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_NMRREEUID_75532');
		   }
		}
		else {
			//Mensaje de no tener deudor
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SAOUCENTD_07389');
		}
    };
    task.executeCommand.CM_EXOSO06SVE84 = function(entities, executeCommandEventArgs) { //Save (Button)
		var numErrors = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_RDIHONLYVE38_02',false);
		executeCommandEventArgs.commons.api.errors.setErrorsGroup('GR_RDIHONLYVE38_02',numErrors);
		//VALIDA SI TIENE DEUDORES
        if(entities.DebtorGeneral==null || entities.DebtorGeneral.data().length==0){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_PNOTSBORW_04809');
		}
		//VALIDA SI TIENE OPERACIONES A EXPROMISIONAR
		if(!task.hasOperations(entities, executeCommandEventArgs)){
			executeCommandEventArgs.commons.execServer = false;
		}
    };
	task.executeCommandCallback.CM_EXOSO06SVE84 = function(entities, executeCommandCallbackEventArgs) {
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};

	 //SaveInfocred (Button)
    task.executeCommand.CM_EXOSO06VEI89 = function(entities, executeCommandEventArgs) {
	   FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };

	//Callback
	task.executeCommandCallback.CM_EXOSO06VEI89 = function(entities, executeCommandCallbackEventArgs) {
	FLCRE.UTILS.INFOCRED.openReentryWindowDebtor(entities.InfocredHeader,executeCommandCallbackEventArgs);
	};

	 //ReportInfocred (Button)
    task.executeCommand.CM_EXOSO06NOD61 = function(entities, executeCommandEventArgs) {
       FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };
	task.executeCommandCallback.CM_EXOSO06NOD61 = function(entities, executeCommandCallbackEventArgs) {
       if(executeCommandCallbackEventArgs.success){
          FLCRE.UTILS.INFOCRED.getReportByCustomer(executeCommandCallbackEventArgs);
       }

	};

    //**********************************************************
    //  Acciones de QUERY VIEW - Borrowers
    //**********************************************************
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) { //RowInserting QueryView: Borrowers
        gridRowInsertingEventArgs.commons.execServer = false;
    };
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) { //BeforeViewCreationCl QueryView: Borrowers
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) { //BeforeEnterLine QueryView: Borrowers
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.openFindCustomer(entities,gridABeforeEnterInLineRowEventArgs,{});
    };
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) { //GridCommand (Button) QueryView: Borrowers
		gridExecuteCommandEventArgs.commons.execServer = false;
		//Solo para eliminar del grid
		FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(gridExecuteCommandEventArgs);
    };
    //**********************************************************
    //  Acciones de QUERY VIEW - GridExpromissionOperations
    //**********************************************************
    task.gridRowSelecting.QV_ITRIC1523_37 = function(entities, gridRowSelectingEventArgs) { //RowSelecting QueryView: GridExpromissionOperations
        gridRowSelectingEventArgs.commons.execServer = false;
    };
    task.gridCommand.CEQV_201_QV_ITRIC1523_37_856 = function(entities, gridExecuteCommandEventArgs) { //cmdDelete (Button) QueryView: GridExpromissionOperations
        gridExecuteCommandEventArgs.commons.execServer = false;
		var selectedRow = gridExecuteCommandEventArgs.commons.api.grid.getSelectedRows('QV_ITRIC1523_37');
		if( selectedRow!=null && selectedRow.length>0 ){
			gridExecuteCommandEventArgs.commons.api.grid.removeRowByDsgnrId('RefinancingOperations',selectedRow[0]);
			task.clearHeaderData(entities);
			//gridExecuteCommandEventArgs.commons.execServer = true;
		} else {
			gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ELCNEUNAR_05370');
		}
    };
    task.gridCommand.CEQV_201_QV_ITRIC1523_37_807 = function(entities, gridExecuteCommandEventArgs) { //cmdNew (Button) QueryView: GridExpromissionOperations
        gridExecuteCommandEventArgs.commons.execServer = false;
	    var nav = FLCRE.API.getApiNavigation(gridExecuteCommandEventArgs,'T_FLCRE_21_OSRCH32','VC_OSRCH32_AOEAR_233');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_BQEEERCIE_19389');
		nav.modalProperties = { size: 'lg' };
		nav.queryParameters = { mode: gridExecuteCommandEventArgs.commons.constants.mode.Insert };
		nav.customDialogParameters = { operations: entities.RefinancingOperations.data()  };
		nav.openModalWindow(gridExecuteCommandEventArgs.commons.controlId);
    };
	//**********************************************************
    //  Eventos para PopUps
    //**********************************************************
	task.closeModalEvent.findCustomer = function (args) { //RESULTADO DE BUSQUEDA DE CLIENTE
		FLCRE.UTILS.CUSTOMER.addDebtorFromSearch(args,'C');
    };
	task.closeModalEvent.VC_OSRCH32_AOEAR_233 = function (args) { //RESULTADO DE BUSQUEDA DE OPERACIONES
		var operationSelected = args.result;
		var ent = args.commons.api.vc.model;
		var objects  = [];
		for (var i = 0; i < ent.RefinancingOperations.data().length; i++) {
			var obj = ent.RefinancingOperations.data()[i];
			objects.push(obj);
		}
		objects = objects.concat(operationSelected);
		args.commons.api.grid.addAllRows('RefinancingOperations', objects, true);
		task.clearHeaderData(args.model);
	};
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_EXOSO06_ROSIO_144 = function(entities, initDataEventArgs) { //ViewContainer: GenericExpromission
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
		initDataEventArgs.commons.api.viewState.show('VA_ORIAHEADER8602_XSIN642');
		//VISUALIZACION DE CAMPOS
		var ctrs = ['VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773',
					'VA_OFICANSSEW2603_APIB151','VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_UNDU035','VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_TENY472',
					'VA_OFICANSSEW2603_TERM877','VA_OFICANSSEW2603_POCT250','VA_OFICANSSEW2603_FFCE753','VA_OFICANSSEW2603_SCOR371',//'VA_OFICANSSEW2603_CRTN299',
					'VA_RDIHONLYVE3802_NCRI218'];
		BUSIN.API.hide(initDataEventArgs.commons.api.viewState,ctrs);
		initDataEventArgs.commons.api.grid.hideColumn('QV_ITRIC1523_37', 'PayoutPercentage');
		initDataEventArgs.commons.api.grid.hideColumn('QV_ITRIC1523_37', 'Rate');

		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		//MAPEO DE DATOS
		var parentTask = initDataEventArgs.commons.api.parentVc.customDialogParameters.Task;
		entities.OfficerAnalysis.ApplicationNumber = parentTask.processInstanceIdentifier;
		entities.OriginalHeader.ApplicationNumber = parentTask.processInstanceIdentifier;
		entities.OriginalHeader.Office=cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);
		task.clearHeaderData(entities);

		//ETAPA Y TIPO DE TRAMITE
		if(parentTask.urlParams.Etapa===FLCRE.CONSTANTS.Stage.Entry && parentTask.urlParams.Tramite===FLCRE.CONSTANTS.RequestName.Expromission){
			entities.OriginalHeader.ProductType = parentTask.bussinessInformationStringTwo
			initDataEventArgs.commons.api.viewState.show("VA_ORIAHEADER8602_PEOE356");
			initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_PEOE356");
			initDataEventArgs.commons.api.grid.hideColumn('QV_ITRIC1523_37', 'IsBase');
			//initDataEventArgs.commons.api.viewState.enable("VA_OFICANSSEW2603_CRTN299");//Tipo de credito
			//se muestra en ingreso de datos la frecuencia de pago y la cuota
			var viewState = initDataEventArgs.commons.api.viewState;
			ctrs = ['VA_ORIAHEADER8602_NQUE773','VA_ORIAHEADER8602_QUOA306'];
			BUSIN.API.show(viewState,ctrs);
			var ctrs1=['VA_OFICANSSEW2605_BINO138', 'VA_OFICANSSEW2603_ORNG078','VA_OFICANSSEW2603_CRTN299'];
			BUSIN.API.hide(viewState,ctrs1);
			var ctrs1 = ['VA_ORIAHEADER8602_TERM237'];
		    BUSIN.API.show(viewState,ctrs1);
		    BUSIN.API.enable(viewState,ctrs1);

		}
		//DATOS DEUDOR
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.clientId != null && typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== ''){
			var cust = new FLCRE.UTILS.CUSTOMER.getDebtorGeneral(client.clientId,client.clientName, 'D', '', '');
			initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', [cust], true);
		}

		if(parentParameters.Task.urlParams.Tramite != null && parentParameters.Task.urlParams.Tramite !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.Tramite;
		}
		if(parentParameters.Task.urlParams.Etapa != null && parentParameters.Task.urlParams.Etapa !== undefined){
			task.Etapa = parentParameters.Task.urlParams.Etapa;
		}

    };
	task.initDataCallback.VC_EXOSO06_ROSIO_144 = function(entities, initDataEventArgs) {
		if(!initDataEventArgs.success){
			initDataEventArgs.commons.api.viewState.disable('CM_EXOSO06SVE84');
		}
	};
    task.render = function(entities, renderEventArgs) { //ViewContainer: GenericExpromission
		var viewState = renderEventArgs.commons.api.viewState;
		var ctrs = ['VA_OFICANSSEW2603_TERM877','VA_OFICANSSEW2603_PONE992','VA_OFICANSSEW2603_CITY183'];
		BUSIN.API.enable(viewState,ctrs);
		ctrs = ['VA_ORIAHEADER8602_OQUE134','VA_ORIAHEADER8602_IALT328'];
		BUSIN.API.disable(viewState,ctrs);

		if(task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Expromission && task.Etapa === FLCRE.CONSTANTS.Stage.Entry){
			viewState.hide('VC_EXOSO06_ERONV_022');//Se oculta la pestaña Otros Datos Credito
			viewState.disable('VC_EXOSO06_ERONV_022');
		}
    };
    //**********************************************************
    //  Metodos privados
    //**********************************************************
    task.clearHeaderData = function(entities) {
		entities.OriginalHeader.AmountRequested = null;
		entities.OriginalHeader.CurrencyRequested = null;
	};
    task.hasOperations = function(entities, eventArgs) { //VALIDA SI TIENE OPERACIONES A EXPROMISIONAR
		var notOperations = (entities.RefinancingOperations==null || entities.RefinancingOperations.data().length==0);
		if(notOperations){
			eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OANEOASXO_69606',null,5000);
		}
		return !notOperations;
	};

}());