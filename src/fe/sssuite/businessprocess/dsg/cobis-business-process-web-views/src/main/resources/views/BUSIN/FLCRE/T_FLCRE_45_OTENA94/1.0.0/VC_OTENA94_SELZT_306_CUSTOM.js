<!-- Designer Generator v 5.0.0.1514 - release SPR 2015-14 24/07/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.tconsolidatepenalization;
	task.Type = '';
	task.CanEdit = 'NO';
	task.ApplicationNumber = 0;

	//**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: Punishment
    //Punishment.OperationStatus (ComboBox) View: VConsolidatePenalization
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VOSOLDTENI3504_RANS132 = function(loadCatalogDataEventArgs) { //Punishment.OperationStatus (ComboBox) View: VConsolidatePenalization
        loadCatalogDataEventArgs.commons.execServer = false;
    };
	
    //Operation QueryView: GConsolidatePenalization 
    task.gridRowCommand.VA_VOSOLDTENI3504_CTDT512 = function(entities, gridRowCommandEventArgs) {
        gridRowCommandEventArgs.commons.execServer = false;
        // gridRowCommandEventArgs.commons.serverParameters.Punishment = true;
    };
	
	//btnObservation QueryView: GConsolidatePenalization 
    task.gridRowCommand.VA_VOSOLDTENI3504_CTDT512 = function(entities, gridRowCommandEventArgs) {
        gridRowCommandEventArgs.commons.execServer = false;		
		var nav ='';		
		nav= FLCRE.API.getApiNavigation(gridRowCommandEventArgs,'T_FLCRE_03_TAONE32','VC_TAONE32_GEPLI_734');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_SERVACINS_39064');
		nav.modalProperties = { size: 'mg' };
		nav.queryParameters = { mode: gridRowCommandEventArgs.commons.constants.mode.Insert };
		nav.customDialogParameters = { HeaderPunishmentRow:gridRowCommandEventArgs.rowData};
		nav.openModalWindow(gridRowCommandEventArgs.commons.controlId);        
    };
	
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    task.executeCommand.CM_OTENA94GAD25 = function(entities, executeCommandEventArgs) { //Guardar (Button)
		if(!task.validateStatus(entities, executeCommandEventArgs,true)){
			executeCommandEventArgs.commons.execServer = false;
			return;
		}
		
		for (var i = 0; i< entities.Punishment.data().length; i++){
			var row = entities.Punishment.data()[i];
			if (row.Recommended === false && ( row.Observation === null ||  row.Observation.trim() === '' ) && row.Status=='R'){
				executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('DSGNR.SYS_DSGNR_LBLERRCNS_00025',null,6000);
				executeCommandEventArgs.commons.execServer = false;
				return;
			}
		}
		BUSIN.API.disable(executeCommandEventArgs.commons.api.viewState,['CM_OTENA94COM63']);
    };
	
	task.executeCommandCallback.CM_OTENA94GAD25 = function(entities, executeCommandCallbackEventArgs) { //Guardar (Button)		
		task.setSecurity(entities, executeCommandCallbackEventArgs , 'CM_OTENA94GAD25');
		//seteo de boton 
		if(entities.Punishment!=null){
			for (var i = 0; i< entities.Punishment.data().length; i++){
			var row = entities.Punishment.data()[i];
				if(row.Recommended ===false){
					$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).show();
				}
			}
		}
		if((task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='NO') 
			|| (task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='YES' 
				&& entities.HeaderPunishment.Status === FLCRE.CONSTANTS.StatusPenalization.Processed)
		){
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);			
		}				
    };

    task.executeCommand.CM_OTENA94COM63 = function(entities, executeCommandEventArgs) { //Recomendacion (Button)
        executeCommandEventArgs.commons.execServer = false;
		if(!task.validateStatus(entities, executeCommandEventArgs,true)&&!task.validateObservations(entities, executeCommandEventArgs,true)){
			return;
		}
		var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_52_VREDE97','VC_VREDE97_EREMM_306');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_RECENDAON_73799');
		nav.modalProperties = { size: 'mg' };
		nav.queryParameters = { mode: executeCommandEventArgs.commons.constants.mode.Insert };
		nav.customDialogParameters = { Request: FLCRE.CONSTANTS.RequestName.Castigo, Type:task.Type, HeaderPunishment:entities.HeaderPunishment  };
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);
    };
	task.closeModalEvent.VC_VREDE97_EREMM_306 = function (args) { //RESULTADO ENVIO DE RECOMENDACION
		var result = args.result;
		if(result[0] === FLCRE.CONSTANTS.RequestName.Castigo && result[2] === 'YES'){
			task.ApplicationNumber = result[3];
			args.commons.api.vc.executeCommand('CM_OTENA94IDE41','Hide', undefined, false, false, 'VC_OTENA94_SELZT_306', false);
		}
	};

    task.executeCommand.CM_OTENA94AAI98 = function(entities, executeCommandEventArgs) { //Declaración Juramentada (Button)	
	//APCH
		if(task.Type === FLCRE.CONSTANTS.OfficerType.ChiefAgency){
		   executeCommandEventArgs.commons.execServer = false;
		   var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.AffidavitPunishment],['grupo',entities.HeaderPunishment.GroupID],['typeDDJJ','AGENCIA']];
		   BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.AffidavitPunishment,args);
		   executeCommandEventArgs.commons.api.vc.closeModal();
		} else if (task.Type === FLCRE.CONSTANTS.OfficerType.RegionalManager){
		   executeCommandEventArgs.commons.execServer = false;
		   var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.AffidavitPunishment],['grupo',entities.HeaderPunishment.GroupID],['typeDDJJ','REGIONAL']];
		   var args1 = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.ReportRequestPunishment],['grupo',entities.HeaderPunishment.GroupID],['typeDDJJ','REGIONAL']];		
		   BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.AffidavitPunishment,args);
		   BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.ReportRequestPunishment,args1);
		   executeCommandEventArgs.commons.api.vc.closeModal();
		} else if (task.Type === FLCRE.CONSTANTS.OfficerType.CreditAnalyst){		   
		   executeCommandEventArgs.commons.execServer = false;
		   var nav = BUSIN.API.getApiNavigation('FLCRE',executeCommandEventArgs,'T_FLCRE_63_TAKNO30','VC_TAKNO30_INIOS_332');
		   nav.modalProperties = { size: 'md' };
		   nav.customDialogParameters = { group: entities.HeaderPunishment};
		   nav.openModalWindow(executeCommandEventArgs.commons.controlId);
		}		
    };

    task.executeCommand.CM_OTENA94IDE41 = function(entities, executeCommandEventArgs) { }//Hide (Button) Eliminar
    task.executeCommandCallback.CM_OTENA94IDE41 = function(entities, executeCommandCallbackEventArgs) { //Hide (Button) Eliminar
		task.setSecurity(entities, executeCommandCallbackEventArgs , 'CM_OTENA94IDE41');
		if(task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='YES') {
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}
		if(entities.HeaderPunishment.Status===FLCRE.CONSTANTS.StatusPenalization.Processed && task.Type === FLCRE.CONSTANTS.OfficerType.CreditAnalyst){
			var menu = cobis.translate('BUSIN.DLB_BUSIN_OECIEAATA_43936');
			BUSIN.INBOX.STATUS.openNewTab(task.ApplicationNumber,menu);
		}
    };

    //**********************************************************
    //  QUERY VIEW - QV_DTPEA0472_42
    //**********************************************************
	task.gridRowSelecting.QV_DTPEA0472_42 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //QueryView: GConsolidatePenalization
    task.gridInitDetailTemplate.QV_DTPEA0472_42 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
		var nav = FLCRE.API.getApiNavigation(gridInitDetailTemplateArgs,'T_FLCRE_58_ETLLN40','VC_ETLLN40_LENTI_976');
        nav.customDialogParameters = {        };
        nav.openDetailTemplate('QV_DTPEA0472_42', gridInitDetailTemplateArgs.modelRow);
    };

    //QueryView: GConsolidatePenalization
    task.gridInitColumnTemplate.QV_DTPEA0472_42 = function(idColumn) {
        if(idColumn === 'bankclient'){
			var template ="<span ng-class=\'vc.viewState.QV_DTPEA0472_42.column.VA_VOSOLDTENI3504_CTDT512.imageId\' class=\'glyphicon glyphicon-ok\' id=\'VA_CHECK01_#=Operation#\'>&nbsp;</span>";
			template = template +"<span  data-bind=\'text:DescriptionClient\'>#=bankclient#</span>";			
			return template;
        } if(idColumn === 'Recommended'){
			var template = "#if (Status === 'R') {# ";
			template = template + "<input type=\'checkbox\' name=\'Recommended\' id=\'VA_VOSOLDTENI3504_REOE379_#=Operation#\' #if (Recommended === true) {# checked #}# ";
			template = template + " ng-click=\"vc.grids.QV_DTPEA0472_42.events.customRowClick($event, \'VA_VOSOLDTENI3504_REOE379\', \'Punishment\', 'QV_DTPEA0472_42')\"/>";
			template = template +"#}#";			
			template = template +"<a name=\'btnObservation\' id=\'VA_VOSOLDTENI3504_CTDT512_#=Operation#\' class=\'btn btn-default cb-row-image-button\'";
			template = template + " ng-click=\"vc.grids.QV_DTPEA0472_42.events.customRowClick($event, \'VA_VOSOLDTENI3504_CTDT512\', \'Punishment\', 'QV_DTPEA0472_42')\"";
			template = template + " style=\'display: none; margin-left: 10px; height: 25px; width: 25px; padding: 0px; font-size: 20px;\'>";
			template = template + "<span >...</span>"
			template = template +"</a>";
			return template;
		}
    };

	task.gridRowCommand.VA_VOSOLDTENI3504_REOE379 = function (entities, args) { //QueryView: GConsolidatePenalization - VA_VOSOLDTENI3504_REOE379
        var nav ='';
		args.commons.execServer = false;		
		if(entities.HeaderPunishment.Status != FLCRE.CONSTANTS.StatusPenalization.Processed){					
			args.rowData.Recommended = !args.rowData.Recommended;			
			if(args.rowData.Recommended ===true){				
				$('#VA_VOSOLDTENI3504_CTDT512_' + args.rowData.Operation).hide();
				//$('#VA_VOSOLDTENI3504_OBSE727_' + args.rowData.Operation).val('');
				args.rowData.Observation = '';
			}else{				
				$('#VA_VOSOLDTENI3504_CTDT512_' + args.rowData.Operation).show();
				nav= FLCRE.API.getApiNavigation(args,'T_FLCRE_03_TAONE32','VC_TAONE32_GEPLI_734');
				nav.label = cobis.translate('BUSIN.DLB_BUSIN_SERVACINS_39064');
				nav.modalProperties = { size: 'mg' };
				nav.queryParameters = { mode: args.commons.constants.mode.Insert };
				nav.customDialogParameters = { HeaderPunishmentRow:args.rowData};
				nav.openModalWindow(args.commons.controlId);
			}			
		}
	};
	/*task.gridRowCommand.VA_VOSOLDTENI3504_OBSE727 = function (entities, args) { //QueryView: GConsolidatePenalization - VA_VOSOLDTENI3504_OBSE727
        args.commons.execServer = false;
		if(entities.HeaderPunishment.Status != FLCRE.CONSTANTS.StatusPenalization.Processed){
			args.rowData.Observation = $('#'+args.commons.controlId + '_' + args.rowData.Operation).val();
		}
	};*/
    task.gridRowSelecting.QV_DTPEA0472_42 = function(entities, gridRowSelectingEventArgs) { //GridRowSelectingCons QueryView: GConsolidatePenalization
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_OTENA94_SELZT_306 = function(entities, initDataEventArgs) { //ViewContainer: FConsolidatePenalization
		var viewState = initDataEventArgs.commons.api.viewState;
		BUSIN.API.disable(viewState,['CM_OTENA94GAD25','CM_OTENA94COM63','CM_OTENA94IDE41']);
		BUSIN.API.hide(viewState,['CM_OTENA94AAI98','CM_OTENA94IDE41']);
		task.Type = BUSIN.SYSTEM.getParameterByName('Type');        
		if(task.Type === ''){
			if(initDataEventArgs.commons.api.parentVc!=undefined||initDataEventArgs.commons.api.parentVc!=null){
				var parentTask = initDataEventArgs.commons.api.parentVc.customDialogParameters.Task;
				task.CanEdit = parentTask.urlParams.Editable;
				task.Type = parentTask.urlParams.Type;
				entities.HeaderPunishment.Step = parentTask.urlParams.Etapa;
				entities.HeaderPunishment.ApplicationNumber = parentTask.processInstanceIdentifier;
				entities.HeaderPunishment.ParentGroupID = parentTask.bussinessInformationIntegerTwo;
				entities.HeaderPunishment.CourtDate = BUSIN.CONVERT.DATE.FromStringMDY(parentTask.bussinessInformationStringTwo);
			}else{
				task.Type = 'AC';
			}			
		}
		entities.HeaderPunishment.Type = task.Type;
    };
	task.initDataCallback.VC_OTENA94_SELZT_306 = function(entities, initDataEventArgs) {
		task.setSecurity(entities, initDataEventArgs , 'INIT');
		if((task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='NO') 
			|| (task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='YES' 
				&& entities.HeaderPunishment.Status === FLCRE.CONSTANTS.StatusPenalization.Processed)
		){
			//BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
			BUSIN.API.hide(initDataEventArgs.commons.api.viewState,['CM_OTENA94COM63']);
			BUSIN.API.enable(initDataEventArgs.commons.api.viewState,['CM_OTENA94GAD25']);
		}
	};
	
    task.render = function(entities, renderEventArgs) { //ViewContainer: FConsolidatePenalization
		var viewState = renderEventArgs.commons.api.viewState;
		BUSIN.API.hide(viewState,['CM_OTENA94AAI98']);
		var ctr = ['Office','Bank','DescriptionClient','OperationStatus','Currency','Recommended','Amount','CapitalBalance','CapitalBalanceToDate','InterestBalance','InterestBalanceToDate','OtherBalance'];
		BUSIN.API.GRID.addColumnsStyle('QV_DTPEA0472_42', 'Grid-Column-Header',renderEventArgs.commons.api,ctr);
		//BUSIN.API.GRID.addColumnsStyle('QV_DTPEA0472_42', 'Grid-Column-Vertical-Align-Middle',renderEventArgs.commons.api,['Office','Bank','DescriptionClient','OperationStatus','Currency','Recommended']);
		//BUSIN.API.GRID.addColumnsStyle('QV_DTPEA0472_42', 'Grid-Column-White-Space-Normal',renderEventArgs.commons.api,['Amount','CapitalBalance','CapitalBalanceToDate','InterestBalance','InterestBalanceToDate','OtherBalance']);
		renderEventArgs.commons.api.grid.addColumnStyle('QV_DTPEA0472_42', 'Recommended', 'Grid-Column-Text-Align-Center');
		//renderEventArgs.commons.api.grid.addColumnStyle('QV_DTPEA0472_42','VA_VOSOLDTENI3504_CTDT512','cb-icon-ok');		
		
		var ctrToHide = ['Office','OperationStatus','Amount','OtherBalance','Bank'];
		BUSIN.API.GRID.hideColumns('QV_DTPEA0472_42', ctrToHide,renderEventArgs.commons.api);
		
		renderEventArgs.commons.api.grid.addColumnStyle('QV_UMMAY4215_41','Office','Grid-Column-Vertical-Align-Middle');
		renderEventArgs.commons.api.grid.addColumnStyle('QV_UMMAY4215_41','Currency','Grid-Column-Vertical-Align-Middle');		
		
		BUSIN.API.GRID.addColumnsStyle('QV_UMMAY4215_41', 'Grid-Column-White-Space-Normal',renderEventArgs.commons.api,['CapitalBalance','CapitalBalanceToDate']);				
		
		if(task.Type !== FLCRE.CONSTANTS.OfficerType.ChiefAgency){
			renderEventArgs.commons.api.grid.addColumnStyle('QV_UMMAY4215_41','Office','Grid-Column-Vertical-Align-Middle');
		}
		
		var parametroReporte='N'
		if (parametroReporte==='S'){
			viewState.show('CM_OTENA94AAI98');
		}else{
			viewState.hide('CM_OTENA94AAI98');
		}

			
		//seteo de boton 
		if(entities.Punishment!=null){
			for (var i = 0; i< entities.Punishment.data().length; i++){
			var row = entities.Punishment.data()[i];
				if(row.Recommended ===false){
					$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).show();
				}
				if(row.Status=='R'){
					$('#VA_CHECK01_' + row.Operation).show();
				}else{
					$('#VA_CHECK01_' + row.Operation).hide();
				}
			}
		}	
    };
	
	// Evento para recuperar valores de una pantalla modal cuando se cierra
	task.closeModalEvent.VC_TAONE32_GEPLI_734 = function(args) {
		if (args.result != null && args.result != undefined){
			for (var i = 0; i< args.model.Punishment.data().length; i++){
			var row = args.model.Punishment.data()[i];
				if(row.uid===args.result.uid){
					if (args.result.Observation !== null ||  args.result.Observation.trim() !== ''){
						row.Observation=args.result.Observation;
					}
				}
			}
		}
	};

    //**********************************************************
    //  FUNCIONES DE UTILERIA
    //**********************************************************
    task.setSecurity = function(entities, Args , Source) {
		var api=Args.commons.api;
		if(Args.success===true){
			var viewState = Args.commons.api.viewState;
			if(entities.HeaderPunishment.Status===FLCRE.CONSTANTS.StatusPenalization.Processed ||
			  (task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='NO') ){				
				BUSIN.API.disable(viewState,['CM_OTENA94AAI98','CM_OTENA94COM63','CM_OTENA94IDE41']);
				Args.commons.messageHandler.showTranslateMessagesInfo('BUSIN.DLB_BUSIN_RCESIADOM_93424',null);
				Args.commons.api.ext.timeout(function(){
					for (var i = 0; i< entities.Punishment.data().length; i++){
						var row = entities.Punishment.data()[i];
						if(row.Recommended ===false){
							/*$('#SPAN_VA_VOSOLDTENI3504_OBSE727_' + row.Operation).show();
							$('#DIV_VA_VOSOLDTENI3504_OBSE727_' + row.Operation).hide();*/
							$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).show();
							$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).attr("disabled",false);
						}
						if(task.Type!==FLCRE.CONSTANTS.OfficerType.Inbox){
							$('#VA_VOSOLDTENI3504_REOE379_' + row.Operation).prop( "disabled", true );
						}else{
							$('#VA_VOSOLDTENI3504_REOE379_' + row.Operation).prop( "disabled", false );
						}
						
					}
				},1000);			
			} else{
				if(Source==='CM_OTENA94GAD25'){
					BUSIN.API.enable(viewState,['CM_OTENA94GAD25','CM_OTENA94COM63']);
				}else if(Source==='INIT'){
					BUSIN.API.enable(viewState,['CM_OTENA94GAD25']);
				}			
			}
		}
		/*for (var i = 0; i< entities.Punishment.data().length; i++){
			var dsRow = entities.Punishment.data()[i];
			if(dsRow.Status === 'R'){
				api.grid.showGridRowCommand('QV_DTPEA0472_42', dsRow, 'VA_VOSOLDTENI3504_CTDT512');
			}
			else {						
				api.grid.hideGridRowCommand('QV_DTPEA0472_42', dsRow, 'VA_VOSOLDTENI3504_CTDT512');
				//viewState.disable('CM_OTENA94GAD25');
			}
		}*/
    };
	task.validateStatus = function(entities, args, showMessage) {
		if(entities.HeaderPunishment.Status === FLCRE.CONSTANTS.StatusPenalization.Processed){ //ESTADO PROCESADO
			if(showMessage===true){
				args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_STORIOEAA_96312',null,6000);
			}
			return false;
		}
		return true;
    };
	
	task.validateObservations = function(entities, args, showMessage) {
		
		for (var i = 0; i< entities.Punishment.data().length; i++){
		var row = entities.Punishment.data()[i];
			if(!row.Recommended){
				if (row.Observation === null || row.Observation.trim() === ''){
					args.commons.messageHandler.showTranslateMessagesError('Una o más Observaciones requeridas no se encuentran ingresadas',null,6000);
					return false;
				}
			}
		}
		return true;
    };

}());
