<!-- Designer Generator v 5.0.0.1514 - release SPR 2015-14 24/07/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.tpunishmentplan;
	task.EtapaTramite = '';
	task.Etapa = '';
	var taskHeader = {};

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

	//HeaderPunishment.Trouble (ComboBox) View: ViewHeaderPunishment
    task.change.VA_VIEANSHMET7202_TOBL390 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		task.ValidateImpossibilityDescription(entities, changedEventArgs);
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button)
    task.executeCommand.CM_PUSEN31SAV72 = function(entities, executeCommandEventArgs) {
         //executeCommandEventArgs.commons.execServer = false;
    };
    //Print (Button)
    task.executeCommand.CM_PUSEN31RIN94 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var debtors = entities.DebtorGeneral.data();
		for (var i = 0; i < debtors.length; i++) {
		   if(debtors[i].Role == 'C'){
					var debtorC = debtors[i].CustomerCode;
					break;
			}else{
				    var debtorC = 0;
			}
		}
		if(task.EtapaTramite==FLCRE.CONSTANTS.Stage.Entry){ //APCH
		    var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.ReportPunishmentRequest],['idTramit',entities.HeaderPunishment.IDRequested],['idProcess', entities.HeaderPunishment.ApplicationNumber],['cstDebtor',debtorC]];
		    BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.ReportPunishmentRequest,args);
		}
    };

    //Validacion de success del server para habilitacion de boton continuar
	task.executeCommandCallback.CM_PUSEN31SAV72 = function(entities, executeCommandCallbackEventArgs) {
		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
		LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'GR_WTTTEPRCES08_02');
			
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };
	task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
         gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
         beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //fileDeleting QueryView: GridPersonalGuarantor
    task.gridRowDeleting.QV_PESAU2317_81 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //Selecting Personal QueryView: GridPersonalGuarantor
    task.gridRowSelecting.QV_PESAU2317_81 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };


    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FPunishmentPlan
    task.initData.VC_PUSEN31_TIMNT_481 = function(entities, initDataEventArgs) {
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		entities.generalData.vinculado="";
		entities.generalData.symbolCurrency="";
		entities.generalData.sectorNeg=" ";
		entities.generalData.loanType="";
		
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.HeaderPunishment.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.HeaderPunishment.Agency = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.HeaderPunishment.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);		

		if(parentParameters.Task.bussinessInformationStringOne !== undefined &&parentParameters.Task.bussinessInformationStringOne !== '' && parentParameters.Task.bussinessInformationStringOne !== null){
			entities.HeaderPunishment.NumberOperation = parentParameters.Task.bussinessInformationStringOne;
		}
		if(parentParameters.Task.bussinessInformationIntegerOne !== undefined &&parentParameters.Task.bussinessInformationIntegerOne !== '' && parentParameters.Task.bussinessInformationIntegerOne !== null){
			entities.HeaderPunishment.CustomerId = parentParameters.Task.bussinessInformationIntegerOne;
		}
		if(parentParameters.Task.urlParams.Etapa != null && parentParameters.Task.urlParams.Etapa !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.Etapa;
		}		
    };

	task.initDataCallback.VC_PUSEN31_TIMNT_481 = function(entities, initDataEventArgs) {		
		var rowsAmt = entities.Amount.data();
		for (var i = 0; i < rowsAmt.length; i ++) {
			rowsAmt[i].Concept = cobis.translate(rowsAmt[i].Concept);
		}
		task.ValidateImpossibilityDescription(entities, initDataEventArgs);
		task.loadTaskHeader(entities,initDataEventArgs);		
	};

    //ViewContainer: FPunishmentPlan
    task.render = function(entities, renderEventArgs) {
		renderEventArgs.commons.execServer = false;
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = renderEventArgs.commons.api.viewState;
		var grid = renderEventArgs.commons.api.grid;
		var ds = renderEventArgs.commons.api.vc.model['PersonalGuarantor'];
		var dsData = ds.data();
		for (var i = 0; i < dsData.length; i ++) {
			var dsRow = dsData[i];
			grid.hideGridRowCommand('QV_PESAU2317_81', dsRow, 'delete');
			grid.hideGridRowCommand('QV_PESAU2317_81', dsRow, 'edit');
		}
		renderEventArgs.commons.api.grid.hideColumn('QV_PESAU2317_81','GuarantorPrimarySecondary');
		renderEventArgs.commons.api.grid.hideColumn('QV_PESAU2317_81','Type');
				
		renderEventArgs.commons.api.grid.hideColumn('QV_BOREG0798_55','TypeDocumentId');
		//renderEventArgs.commons.api.grid.hideColumn('QV_BOREG0798_55','Qualification');
		
		renderEventArgs.commons.api.viewState.hide('CM_PUSEN31RIN94');				
		task.showButtons(renderEventArgs);
		//******************************************/
		viewState.enable('VA_VIEANSHMET7202_AUOA601');		
		//********Modo		
		//Consulta
		if(parentParameters.Task.urlParams.MODE==FLCRE.CONSTANTS.Mode.Query){//en el caso de que la tarea se utilice con todos los campos deshabilitados			
			var ctrsToDisable = ['GR_VIEANSHMET72_02','GR_VIEANSHMET72_03','GR_VIEANSHMET72_04',//grupos de datos generales 
			'VC_PUSEN31_GOOMB_570','VC_PUSEN31_GSIOE_966','VC_PUSEN31_OSMBR_895'];//secciones monto/saldo, deudores, garantias
			BUSIN.API.disable(viewState,ctrsToDisable);
			var dsMonto = renderEventArgs.commons.api.vc.model['Amount'];
			var dsDataMonto = dsMonto.data();				
		}
		//********Etapas
		//Ingreso
		if(parentParameters.Task.urlParams.ETAPA==FLCRE.CONSTANTS.Stage.IngresoDeDatos		
		){
			var ctrsToHide=['GR_VIEANSHMET72_04'];//grupo recomendacion
			BUSIN.API.hide(viewState,ctrsToHide);
		}
		//Verificacion
		if(parentParameters.Task.urlParams.ETAPA==FLCRE.CONSTANTS.Stage.RevisedRecommendation		
		){
			var ctrsToDisable = ['GR_VIEANSHMET72_02','GR_VIEANSHMET72_03',//grupos de datos generales 
			'VC_PUSEN31_GOOMB_570','VC_PUSEN31_GSIOE_966','VC_PUSEN31_OSMBR_895'];//secciones monto/saldo, deudores, garantias
			BUSIN.API.disable(viewState,ctrsToDisable);			
			var ctrsToShow=['GR_VIEANSHMET72_04'];//grupo recomendacion
			BUSIN.API.show(viewState,ctrsToShow);
		}
		//********Tramite				
		
		//QUITA BOTONES DEL GRID DE DUDORES
		grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');		
    };

	//Funcion que habilita/deshabilita el campo "Descripción Imposibilidad de Pago"
    task.ValidateImpossibilityDescription = function(entities, args){
		if(entities.HeaderPunishment.Trouble == '4'){
		    args.commons.api.viewState.enable('VA_VIEANSHMET7203_EPTI020');
		}else{
		    args.commons.api.viewState.disable('VA_VIEANSHMET7203_EPTI020');
			entities.HeaderPunishment.ImpossibilityDescription = null;
		}
    };
	
	task.loadTaskHeader=function(entities,eventArgs){
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.OriginalHeader;
		
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.IDRequested==null||originalh.IDRequested=='null' ? '--':originalh.IDRequested),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Desembolsado',BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested ==null||originalh.AmountRequested =='null' ? 0:originalh.AmountRequested ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',entities.OriginalHeader.Term,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((entities.OfficerAnalysis.OfficierName!=null)?entities.OfficerAnalysis.OfficierName.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Desembolso',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};
	
	task.showButtons = function(args){
		var api = args.commons.api;
		var parentParameters = args.commons.api.parentVc.customDialogParameters;
		//Boton Principal (Wizard)
		//initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
		//	initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
		//}
		
		//Boton Secundario 1 (Wizard)
		//(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
		//(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
		//(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
		//(Tiene una limitacion de 5 axecute commands)
		
		if(parentParameters.Task.urlParams.Modo!= undefined&&parentParameters.Task.urlParams.Modo!=null
		&&parentParameters.Task.urlParams.Modo==FLCRE.CONSTANTS.Mode.Query){
			args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}else{
			args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar";
			args.commons.api.vc.parentVc.executeCommand1 = function(){
				args.commons.api.vc.executeCommand('CM_PUSEN31SAV72','Save', undefined, true, false, 'VC_PUSEN31_TIMNT_481', false);
			}	
		
			args.commons.api.vc.parentVc.labelExecuteCommand2 = "Imprimir";
			args.commons.api.vc.parentVc.executeCommand2 = function(){
				args.commons.api.vc.executeCommand('CM_PUSEN31RIN94','Print', undefined, true, false, 'VC_PUSEN31_TIMNT_481', false);
			}			
		}		
	};

}());