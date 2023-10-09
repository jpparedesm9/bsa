<!-- Designer Generator v 5.0.0.1511 - release SPR 2015-11 12/06/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.constancyassessment;

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

    //OfficerAnalysis.AOProductType (ComboBox) View: OfficerAnalysisView 
    task.change.VA_OFICANSSEW2603_POCT250 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //OfficerAnalysis.Sector (ComboBox) View: OfficerAnalysisView 
    task.change.VA_OFICANSSEW2603_SCOR371 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
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
         changedEventArgs.commons.execServer = false;
    };

    //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView 
    task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;
		
		// Para enviar solo la entidad que se necesita en el load		
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OfficerAnalysis = true;
		
    };
	task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {	
		loadCatalogDataEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers 
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
         beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers 
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
         gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: constancyAssessmentForm 
    task.initData.VC_NYAST96_NCSEO_811 = function(entities, initDataEventArgs) {
        // initDataEventArgs.commons.execServer = false;
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
	//	entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);

		var ctrs = ['VA_ORIAHEADER8602_IOUR445','VA_ORIAHEADER8602_RQSD386','VA_ORIAHEADER8602_0000908','VA_ORIAHEADER8602_ITCE121',
					'VA_ORIAHEADER8602_OQUE134','VA_ORIAHEADER8602_URQT595','VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773',
					'VA_ORIAHEADER8602_CRET312','VA_ORIAHEADER8602_IALT328','GR_BORRWRVIEW27_83',
					'VA_OFICANSSEW2603_TENY472','VA_OFICANSSEW2603_ORNG078'];
		BUSIN.API.disable(initDataEventArgs.commons.api.viewState,ctrs);	
		initDataEventArgs.commons.api.viewState.hide('VC_AITIV39_DERFF_144');
            
    };
    
    task.initDataCallback.VC_NYAST96_NCSEO_811 = function(entities, initDataEventArgs) {
		var parentApi = initDataEventArgs.commons.api.parentApi();
		if(parentApi != undefined && initDataEventArgs.success){
		  var parentVc = parentApi.vc;
		  parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
		initDataEventArgs.commons.execServer = false;
	 };
    
    //ViewContainer: constancyAssessmentForm 
    task.render = function(entities, renderEventArgs) {
        // renderEventArgs.commons.execServer = false;
        		//OCULTAR FILTROS Y BOTONES DE CABECERAS DE GRID
		BUSIN.API.GRID.hideFilter('QV_BOREG0798_55', renderEventArgs.commons.api);
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		
		//CUANDO ES LINEA OCULTA CAMPOS
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Linea){
			BUSIN.API.hide(renderEventArgs.commons.api.viewState,['VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773']);
		//CUANDO ES DE EXPROMISION
		}else if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Expromision && entities.OriginalHeader.Expromission != null){
			var ctrs = ['VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_CRET312','VA_ORIAHEADER8602_NQUE773',
			            'VA_OFICANSSEW2603_APIB151','VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_UNDU035',
		                'VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_POCT250','VA_OFICANSSEW2603_FFCE753','VA_OFICANSSEW2603_SCOR371',
				        'VA_OFICANSSEW2603_CRTN299']; 
			BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs);
			var ctrs1 = ['VA_ORIAHEADER8602_XSIN642','VC_AITIV39_DERFF_144'];
			BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs1);	
            BUSIN.API.disable(renderEventArgs.commons.api.viewState,['VA_ORIAHEADER8602_XSIN642']);			
		}
           
    };

}());