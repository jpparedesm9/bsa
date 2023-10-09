<!-- Designer Generator v 5.0.0.1504 - release SPR 2015-04 06/03/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.legalanalysisactivity;
	task.EtapaTramite = '';
	task.Etapa = '';

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

    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) { //DebtorGeneral.Role (ComboBox) View: BorrowerView
        // changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) { //OriginalHeader.AttAmount (TextInputBox) View: HeaderView
        // changedEventArgs.commons.execServer = false;
    };

    task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) { //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView
        loadCatalogDataEventArgs.commons.execServer = false;
    };

	//No habia
    task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function(loadCatalogDataEventArgs) {
        // Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OfficerAnalysis = true;
    };

    task.change.VA_OFICANSSEW2603_POCT250 = function(entities, changedEventArgs) { //OfficerAnalysis.AOProductType (ComboBox) View: OfficerAnalysisView
        // changedEventArgs.commons.execServer = false;
    };

    task.change.VA_OFICANSSEW2603_SCOR371 = function(entities, changedEventArgs) { //OfficerAnalysis.Sector (ComboBox) View: OfficerAnalysisView
        // changedEventArgs.commons.execServer = false;
    };

    /*task.change.VA_ORIAHEADER8602_OQUE134 = function(entities, changedEventArgs) { //OriginalHeader.AmountRequested (TextInputBox) View: HeaderView
        changedEventArgs.commons.execServer = false;
    };*/

    task.change.VA_ORIAHEADER8602_URQT595 = function(entities, changedEventArgs) { //OriginalHeader.CurrencyRequested (ComboBox) View: HeaderView
         changedEventArgs.commons.execServer = false;
    };


    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) { //RowInserting QueryView: Borrowers
         gridRowInsertingEventArgs.commons.execServer = false;
    };
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) { //BeforeViewCreationCl QueryView: Borrowers
         beforeOpenGridDialogEventArgs.commons.execServer = false;
    };
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) { //BeforeEnterLine QueryView: Borrowers
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) { //GridCommand (Button) QueryView: Borrowers
         gridExecuteCommandEventArgs.commons.execServer = false;
    };
    //SectingDeudores QueryView: Borrowers
    task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

	//**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Guardar (Button)
    task.executeCommand.CM_AITIV39ARR73 = function(entities, executeCommandEventArgs) {
		var parametro=executeCommandEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.step;
		var parentApi = executeCommandEventArgs.commons.api.parentApi();
		if (parametro=='GRAVAMEN'){
				var parentVc = parentApi.vc;
					parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
		if(task.Etapa===FLCRE.CONSTANTS.Stage.Rejection && entities.OriginalHeader.TypeRequest==='O'){
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
        executeCommandEventArgs.commons.execServer = true;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: LegalAnalysisActivityForm
    task.initData.VC_AITIV39_LGLAA_742 = function(entities, initDataEventArgs) {
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
	//	entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		var viewState = initDataEventArgs.commons.api.viewState;
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		var parametro=initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.step;
		if (parametro=='GRAVAMEN'){
			initDataEventArgs.commons.api.vc.viewState.VC_AITIV39_GUOIB_483.visible=true;
			viewState.hide("GR_RIOTRDTAVI49_08");
			viewState.hide("GR_RIOTRDTAVI49_04");
			viewState.hide("GR_RIOTRDTAVI49_09");
			viewState.hide("GR_RIOTRDTAVI49_10");
			viewState.hide("GR_RIOTRDTAVI49_11");
			viewState.hide("GR_RIOTRDTAVI49_12");
			initDataEventArgs.commons.api.vc.viewState.CM_AITIV39ARR73.visible=true;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		}else{
			initDataEventArgs.commons.api.vc.viewState.VC_AITIV39_GUOIB_483.visible=false;
			initDataEventArgs.commons.api.vc.viewState.CM_AITIV39ARR73.visible=false;
		}

		var ctrs = ['VA_ORIAHEADER8602_IOUR445','VA_ORIAHEADER8602_RQSD386','VA_ORIAHEADER8602_0000908','VA_ORIAHEADER8602_ITCE121',
					'VA_ORIAHEADER8602_OQUE134','VA_ORIAHEADER8602_URQT595','VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773',
					'VA_ORIAHEADER8602_CRET312','VA_ORIAHEADER8602_IALT328','GR_BORRWRVIEW27_83',
					'VA_OFICANSSEW2603_TENY472','VA_OFICANSSEW2603_ORNG078','VA_OFICANSSEW2603_CITY183'];
		BUSIN.API.disable(viewState,ctrs);
		viewState.hide('VC_AITIV39_DERFF_144');

		if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
		}
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
			task.Etapa = parentParameters.Task.urlParams.ETAPA;
		}
		//campo codigo actividad economica
		viewState.hide('VA_RIOTRDTAVI4904_RDTN715');
		viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true);
    };

	task.initDataCallback.VC_AITIV39_LGLAA_742 = function(entities, initDataEventArgs) {
	var parametro=initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.step;
		var parentApi = initDataEventArgs.commons.api.parentApi();
		if (parametro=='GRAVAMEN'){
			if(parentApi != undefined && initDataEventArgs.success){
				var parentVc = parentApi.vc;
				parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
			}
		}else
		{
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}

		initDataEventArgs.commons.execServer = false;
	 };


	   //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };
  //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

    //ViewContainer: LegalAnalysisActivityForm
    task.render = function(entities, renderEventArgs) {
	try{
		var viewState = renderEventArgs.commons.api.viewState;
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
		}else if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Reprogramacion){
            var ctrs = ['VA_ORIAHEADER8602_CRET312','VA_OFICANSSEW2603_APIB151','VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_SAMN032',
			            'VA_OFICANSSEW2603_UNDU035','VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_FFCE753','VA_OFICANSSEW2603_SCOR371',
				        'VA_OFICANSSEW2603_CRTN299','VA_OFICANSSEW2603_TENY472','VA_OFICANSSEW2603_TERM877'];
			             BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs);

			ctrs = ['VC_AITIV39_DERFF_144','VA_OFICANSSEW2603_POCT250','VA_OFICANSSEW2603_OCEC262','VA_OFICANSSEW2603_SCOR371','VA_OFICANSSEW2603_PONE992',
			        'VA_OFICANSSEW2603_ORNG078','VA_OFICANSSEW2603_CITY183','VA_OFICANSSEW2603_CRTN299'];
			            BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs);
        }
        //LGU ORI-0090-2 SPR-2015-14
		// if(task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
		if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento){ //CUANDO ES REFINANCIAMIENTO
 	     	var ctrs1 = ['VA_ORIAHEADER8602_EVAL957'];
			var viewState = renderEventArgs.commons.api.viewState, template;

	    	BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs1);
         	BUSIN.API.disable(viewState,ctrs1);
			viewState.template('VA_ORIAHEADER8602_EVAL957', template);
		}
		//LGU ORI-0090-2 SPR-2015-14

		if ((task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Expromission && task.Etapa===FLCRE.CONSTANTS.Stage.AnalisisLegal)
			|| (task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Expromission &&task.Etapa===FLCRE.CONSTANTS.Stage.Gravamen )){ //Se oculta linea de credito para expromision
			var ctrs1 = ['VA_ORIAHEADER8602_EVAL957','VA_OFICANSSEW2603_TENY472'];
            var viewState = renderEventArgs.commons.api.viewState;
            BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs1);
			BUSIN.API.disable(viewState,ctrs1);
		}

		//Cuando llega a la Actividad de Rechazo
		if(task.Etapa===FLCRE.CONSTANTS.Stage.Rejection){
			var parentApi = renderEventArgs.commons.api.parentApi();
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"
			 task.hideFieldRejection (viewState);
			 task.showFieldRejection (viewState);
			 renderEventArgs.commons.api.vc.viewState.CM_AITIV39ARR73.visible=true; //visualiza boton guardar
			viewState.enable('VA_ORIAHEADER8602_EIEA610'); //deshabilita el campo Motivo de Rechazo
		}
		//Cuando llega a la Actividad de Rechazo
		if(task.Etapa===FLCRE.CONSTANTS.Stage.Rejection && entities.OriginalHeader.TypeRequest==='O'){
			var parentApi = renderEventArgs.commons.api.parentApi();
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"
			task.hideFieldRejection (viewState);
		    task.showFieldRejection (viewState);
			task.hideFieldRejectionOriginal(viewState);
			renderEventArgs.commons.api.vc.viewState.CM_AITIV39ARR73.visible=true;
			viewState.enable('VA_ORIAHEADER8602_EIEA610');
		}
		BUSIN.API.disableAsyncForce(renderEventArgs,'VA_OFICANSSEW2603_CITY183');
		} catch (err){
			renderEventArgs.commons.messageHandler.showMessagesInformation('Error al Renderizar');
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
			console.log("Open by " + changedGroupEventArgs.commons.item.id);
			var valueActivityDestinationCredit = changedGroupEventArgs.commons.api.viewState.selectedText('VA_RIOTRDTAVI4904_RDTN715', entities.CreditOtherData.CreditDestination);
			entities.CreditOtherData.CreditDestinationValue = valueActivityDestinationCredit;
        }
    };

	task.hideFieldRejection = function(viewState){
		var ctrs = ['VA_ORIAHEADER8602_EVAL957', //linea de credito
					'VA_ORIAHEADER8602_XSIN642', //Motivo Expromision
					'VA_ORIAHEADER8602_ITCE121', //Ciudad Destino
					'VA_OFICANSSEW2603_TENY472', //plazo
					'VA_OFICANSSEW2603_TERM877', //Destino Solicitado
					'VA_ORIAHEADER8602_CRET312']; //Frecuencia de Pago
		BUSIN.API.hide(viewState,ctrs);
	};
	task.showFieldRejection = function(viewState){
		var ctrs = ['VA_OFICANSSEW2603_PONE992', //provincia
					'VA_OFICANSSEW2603_OCEC262', //Oficial
					'VA_OFICANSSEW2603_ORNG078', //Sector del Credito
					'VC_AITIV39_DERFF_144',
					'VA_ORIAHEADER8602_EIEA610'] //Motivo de Rechazo
		BUSIN.API.show(viewState,ctrs);
	};
	task.hideFieldRejectionOriginal = function(viewState){
		var ctrs = ['VA_ORIAHEADER8602_EVAL957', //linea de credito
					'VA_ORIAHEADER8602_XSIN642', //Motivo Expromision
					'VA_ORIAHEADER8602_ITCE121', //Ciudad Destino
					'VA_OFICANSSEW2603_TENY472', //plazo
					'VA_OFICANSSEW2603_TERM877', //Destino Solicitado
					'VA_ORIAHEADER8602_NQUE773', //Frecuencia de Pago
					'VA_ORIAHEADER8602_QUOA306', //CUOta
					'VA_OFICANSSEW2603_APIB151', //Numero de Solicitud
					'VA_OFICANSSEW2603_SAMN032', //monto propuesto
					'VA_OFICANSSEW2603_SURE913',  //Moneda Propuesta
					'VA_OFICANSSEW2603_UNDU035', //Monto adesembolsar
					'VA_OFICANSSEW2603_POCT250', //Tipo de producto
					'VA_OFICANSSEW2603_FFCE753',  //oficial
					'VA_OFICANSSEW2603_SCOR371',  //Sector de la Actividad
					'VA_OFICANSSEW2603_CRTN299',  //Tipo de Credito;
					'VA_OFICANSSEW2603_ORNG078']  //Sector del Credito
		BUSIN.API.hide(viewState,ctrs);
	};

}());

