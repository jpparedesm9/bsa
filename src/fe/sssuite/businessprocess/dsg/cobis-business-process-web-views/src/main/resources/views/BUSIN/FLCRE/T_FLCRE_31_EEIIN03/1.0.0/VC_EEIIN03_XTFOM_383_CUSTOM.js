<!-- Designer Generator v 5.0.0.1508 - release SPR 2015-08 30/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.executionexpromision;
	task.TipoTramite = '';
	task.Etapa = '';

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //.Autorizar (Button) View: ApproveCreditRequest
    task.executeCommand.VA_OVECRDTRQE4827_0000833 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false; //aa
    };

    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //OfficerAnalysis.AOProductType (ComboBox) View: OfficerAnalysisView
    task.change.VA_OFICANSSEW2603_POCT250 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //OfficerAnalysis.Sector (ComboBox) View: OfficerAnalysisView
    task.change.VA_OFICANSSEW2603_SCOR371 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //IndexSizeActivity.btnReaclcular (Button) View: ApproveCreditRequest
    task.executeCommand.VA_OVECRDTRQE4831_NEIY294 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false; //aaa
    };

    //OriginalHeader.AmountRequested (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_OQUE134 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //OriginalHeader.Quota (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //OriginalHeader.CurrencyRequested (ComboBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_URQT595 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };
    //RefinancingOperations.IsBase (CheckBox) View: RefinancingOperationView
    task.change.VA_ININGOTONE0435_SIAL979 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.AmountProposed (TextInputBox) View: ApproveCreditRequest
    task.change.VA_OVECRDTRQE4830_AONO775 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.Currency (ComboBox) View: ApproveCreditRequest
    task.change.VA_OVECRDTRQE4830_CUCY033 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    task.change.VA_OVECRDTRQE4830_RITT981 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    task.loadCatalog.VA_OVECRDTRQE4830_RITT981 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };
    //OriginalHeader.CreditLineValid (ComboBox) View: HeaderView
    task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

    //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView
    task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;

		// Para enviar solo la entidad que se necesita en el load
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OfficerAnalysis = true;
    };

	//**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button)
    task.executeCommand.CM_EEIIN03SAE01 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //**********************************************************
    //QueryView: GridExceptions aaa
    task.gridInitDetailTemplate.QV_UERXC4756_18 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
    };

    //QueryView: GridPolicy
    task.gridInitDetailTemplate.QV_QUERO4480_42 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
    };

    //QueryView: GridExceptions
    task.gridInitColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
    };
    //QueryView: GridExceptions
    task.gridInitEditColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        // gridRowInsertingEventArgs.commons.execServer = false;
    };

    //Rowinserting QueryView: GridRefinancingOperations
    task.gridRowInserting.QV_ITRIC1523_63 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
    };

	//SelectOperation QueryView: GridRefinancingOperations
    task.gridRowSelecting.QV_ITRIC1523_63 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //InsertingRow QueryView: GridDistributionLine
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //rowUpdating QueryView: GridRefinancingOperations
    task.gridRowUpdating.QV_ITRIC1523_63 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //updatePoint QueryView: ManagersPointsGrid
    task.gridRowUpdating.QV_MARPN5915_10 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //UpdateRow QueryView: GridDistributionLine
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //DeleteOperation QueryView: GridRefinancingOperations
    task.gridRowDeleting.QV_ITRIC1523_63 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
    };

    //DeleteRow QueryView: GridDistributionLine
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //DeleteCommand (Button) QueryView: GridRefinancingOperations
    task.gridCommand.CEQV_201_QV_ITRIC1523_63_978 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //cmdNew (Button) QueryView: GridRefinancingOperations
    task.gridCommand.CEQV_201_QV_ITRIC1523_63_992 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: executionExpromisionForm
    task.initData.VC_EEIIN03_XTFOM_383 = function(entities, initDataEventArgs) {
		BUSIN.SYSTEM.importScript('CreditBureau.js');
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
        initDataEventArgs.commons.api.viewState.show('VA_ORIAHEADER8602_XSIN642');
		//VISUALIZACION DE CAMPOS
        initDataEventArgs.commons.api.viewState.hide('VA_ORIAHEADER8602_QUOA306');
        initDataEventArgs.commons.api.viewState.hide('VA_ORIAHEADER8602_CRET312');
        initDataEventArgs.commons.api.viewState.hide('VA_ORIAHEADER8602_NQUE773');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_APIB151');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_SAMN032');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_UNDU035');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_SURE913');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_POCT250');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_FFCE753');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_SCOR371');
        initDataEventArgs.commons.api.viewState.hide('VA_OFICANSSEW2603_CRTN299');

        initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_OQUE134");
        initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_IALT328");
        initDataEventArgs.commons.api.viewState.disable("VA_OFICANSSEW2603_TENY472");
         initDataEventArgs.commons.api.viewState.disable("VA_OFICANSSEW2603_ORNG078");

        initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_URQT595");
        initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_XSIN642");
        initDataEventArgs.commons.api.viewState.disable("VA_OFICANSSEW2603_CITY183");

		//MAPEO DE DATOS
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OfficerAnalysis.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office=cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);

		if(!BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.urlParams.TRAMITE)){ task.TipoTramite = parentParameters.Task.urlParams.TRAMITE;}
		else if(!BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.urlParams.Tramite)){ task.TipoTramite = parentParameters.Task.urlParams.Tramite;}

		if(!BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.urlParams.ETAPA)){ task.Etapa = parentParameters.Task.urlParams.ETAPA;}
		else if(!BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.urlParams.Etapa)){ task.Etapa = parentParameters.Task.urlParams.Etapa;}
    };
    //HABILITANDO EL BOTON CONTINUAR
    task.initDataCallback.VC_EEIIN03_XTFOM_383 = function(entities, initDataEventArgs) {
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var viewState = initDataEventArgs.commons.api.viewState;
		if(parentApi != undefined && initDataEventArgs.success){
		  var parentVc = parentApi.vc;
		  parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
		initDataEventArgs.commons.execServer = false;
		viewState.focus('GR_OVECRDTRQE48_13');//Pestaña de plan de pagos
	 };

    //ViewContainer: executionExpromisionForm
    task.render = function(entities, renderEventArgs) {
        // renderEventArgs.commons.execServer = false;
		var viewState = renderEventArgs.commons.api.viewState;
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');

		var ctrs = ['GR_OVECRDTRQE48_07','GR_OVECRDTRQE48_05','GR_OVECRDTRQE48_06','GR_OVECRDTRQE48_06','GR_OVECRDTRQE48_08','GR_OVECRDTRQE48_09','GR_OVECRDTRQE48_12','GR_OVECRDTRQE48_20','GR_OVECRDTRQE48_29','GR_OVECRDTRQE48_30','GR_OVECRDTRQE48_31'];
		BUSIN.API.hide(viewState,ctrs);
		ctrs = [
		'GR_OVECRDTRQE48_14', //Datos Generales
		'GR_OVECRDTRQE48_15', //Tipo de Tabla
		'GR_OVECRDTRQE48_17', //Plazo
		'GR_OVECRDTRQE48_18', //Periodos de Gracias
		]
		BUSIN.API.hide(viewState,ctrs);
		viewState.focus('VA_OVECRDTRQE4814_PANE672');
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'create');
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');

        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento){ //CUANDO ES REFINANCIAMIENTO
            var viewState2 = renderEventArgs.commons.api.viewState, template;
			viewState.show('VA_ORIAHEADER8602_EVAL957');
			viewState.disable('VA_ORIAHEADER8602_EVAL957');
            viewState2.template('VA_ORIAHEADER8602_EVAL957', template);
        }

		//Coloco el foco en la pestania de plan de pagos
		BUSIN.API.GROUP.selectTab('GR_OVECRDTRQE48_04', 3, renderEventArgs.commons.api);
		BUSIN.INBOX.STATUS.nextStep(true,renderEventArgs.commons.api) //siempre se habilita el boton continuar del inbox

		//oculto el plazo tanto para refinanciamiento como expromision
		viewState.hide('VA_OFICANSSEW2603_TENY472');

		//Si estoy en refinanciamiento oculto el campo de expromision
		if(renderEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.Tramite !== undefined && renderEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.Tramite === 	FLCRE.CONSTANTS.RequestName.Refinancing){
			viewState.hide('VA_ORIAHEADER8602_XSIN642');
        }

        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Reprogramacion){
			viewState.hide('VA_ORIAHEADER8602_XSIN642');
        }

		if((task.TipoTramite === FLCRE.CONSTANTS.RequestName.Reprogramming) && (task.Etapa === FLCRE.CONSTANTS.Stage.Ejecucion)){ //SOLICITUD REPROGRAMACION - EJECUCION REPROGRAMACION
			viewState.hide('GR_OVECRDTRQE48_34');
		}

		//Habilitar pestaña de Expromision-Refinanciamiento
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Expromision ||
		   entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento ||
		   entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Reprogramacion){
				BUSIN.API.show(viewState,['GR_OVECRDTRQE48_32','CM_EEIIN03SAE01']);
				CREDITBUREAU.QUERYCENTRAL.validateLevelIndebtedness(entities, renderEventArgs, 'VA_OVECRDTRQE4832_EDNE863' );
				renderEventArgs.commons.api.grid.showColumn('QV_ITRIC1523_63', 'IsBase');
		}else{
			BUSIN.API.hide(viewState,['GR_OVECRDTRQE48_32','CM_EEIIN03SAE01']);
		};
         task.formatAmortizationTable(entities, renderEventArgs.commons.api)

	   if (task.TipoTramite === FLCRE.CONSTANTS.RequestName.Expromission && task.Etapa===FLCRE.CONSTANTS.Stage.Ejecucion){ //Se oculta linea de credito para expromision
			viewState.disable('VA_ORIAHEADER8602_EVAL957');
			viewState.hide('VA_ORIAHEADER8602_EVAL957');
		}
		BUSIN.API.disableAsyncForce(renderEventArgs,'VA_OFICANSSEW2603_CITY183');
	}

    //**********************************************************
    //  Eventos para Grupos
    //**********************************************************
    //Contenedor de Pestañas (TabbedLayout)  View: ApproveCreditRequest
    task.changeGroup.GR_OVECRDTRQE48_04 = function(entities, changedGroupEventArgs) {
        // changedGroupEventArgs.commons.execServer = false;
        //if((changedGroupEventArgs.commons.item.id === 'GroupId') && (changedGroupEventArgs.commons.item.isOpen === true)){
        //console.log("Open by " + changedGroupEventArgs.commons.item.id);
        //}
    };

	task.formatAmortizationTable = function(entities, api){
		//TITULO EN COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
		var maxNumRubros = 13;
		var count = entities.AmortizationTableHeader.data().length-1;
		if(count>maxNumRubros) count=maxNumRubros;
		for (var i=1; i<=count; i++){
			api.grid.title("QV_QUYOI3312_16", "Item"+i, entities.AmortizationTableHeader.data()[i].Description, false);
			api.grid.format('QV_QUYOI3312_16',"Item"+(i), '#,##0.00');
			api.grid.format('QV_QUYOI3312_16',"Item"+(i+1), '#,##0.00');
			api.grid.format('QV_QUYOI3312_16',"Balance", '#,##0.00');
			api.grid.format('QV_QUYOI3312_16',"Fee", '#,##0.00');
		}
		//OCULTA COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
		if(count<maxNumRubros) {
			if(count === -1){
				count = 0; //Cuando no hay tabla de amortizacion.
			}
			for (var i=count+1; i<=maxNumRubros; i++){
				api.grid.hideColumn ('QV_QUYOI3312_16', 'Item'+i);
				//api.grid.disabledColumn ('QV_QUYOI3312_16', 'Item'+i);
			}
		}
	};
}());