<!-- Designer Generator v 5.0.0.1518 - release SPR 2015-16 18/09/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.infocredmanagement;

    //**********************************************************
    //  Eventos de GRID
    //**********************************************************
    task.gridRowCommand.VA_CEDNAGMTIE2107_TEOD048 = function(entities, gridRowCommandEventArgs) { //[Imprimir] QueryView: InfocredItemGrig
        gridRowCommandEventArgs.commons.execServer = false;
		FLCRE.UTILS.INFOCRED.getReportById(gridRowCommandEventArgs, gridRowCommandEventArgs.rowData.Code);
    };
    //**********************************************************
    //  Eventos de BOTONES
    //**********************************************************
    task.textInputButtonEvent.VA_CEDNAGMTIE2108_CTOM392 = function(textInputButtonEventArgs) { //Entity: InfocredHeader.CustomerName (TextInputButton) View: InfocredManagementView
        textInputButtonEventArgs.commons.execServer = false;
		task.clear(textInputButtonEventArgs.commons.api.vc.model, textInputButtonEventArgs);
		BUSIN.API.getNavigationFindCustomer(textInputButtonEventArgs.commons.api);
    };

    task.executeCommand.VA_CEDNAGMTIE2108_0000798 = function(entities, executeCommandEventArgs) { //Entity: InfocredHeader.[Botón-Limpiar] (Button) View: InfocredManagementView
        executeCommandEventArgs.commons.execServer = false;
		task.clear(entities, executeCommandEventArgs);
    };

    task.executeCommand.VA_CEDNAGMTIE2108_CTME537 = function(entities, executeCommandEventArgs) { //Entity: InfocredHeader.[Botón-Buscar] (Button) View: InfocredManagementView
		if(!task.hasCustomer(entities.InfocredHeader) ){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OSEEOULIN_28612',null,6000);
		}
    };

    task.executeCommand.VA_CEDNAGMTIE2106_0000307 = function(entities, executeCommandEventArgs) { //Entity: InfocredHeader.[Botón Registrar Infocred] (Button) View: InfocredManagementView
		if(!task.hasCustomer(entities.InfocredHeader) ){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OSEEOULIN_28612',null,6000);
		}
    };
	task.executeCommandCallback.VA_CEDNAGMTIE2106_0000307 = function(entities, executeCommandEventArgs) {
		var entInfH = entities.InfocredHeader;
		if(executeCommandEventArgs.success===false && entInfH.Out_HasManySimilar===true){
			FLCRE.UTILS.INFOCRED.openReentryWindowFull(executeCommandEventArgs,entInfH.Out_SimilarList, entInfH.Out_Source, entInfH.Out_Role, entInfH.Out_RequestIdLoanId, entInfH.CustomerId);
		}
	};

    //**********************************************************
    //  Eventos de WINDOWs
    //**********************************************************
	task.closeModalEvent.findCustomer = function (args) { //PANTALLA DE BUSQUEDA DE CLIENTES
		var resp = args.commons.api.vc.dialogParameters;
		var customerInfo = resp.documentId + ' / ';
		if(resp.commercialName !== ''){ customerInfo = customerInfo + resp.commercialName; }
		else{ customerInfo = customerInfo + resp.name; }
		customerInfo = customerInfo + ' - (' + resp.CodeReceive + ')';

		args.model.InfocredHeader.CustomerId = resp.CodeReceive;
		args.model.InfocredHeader.CustomerName = customerInfo;
	};

	task.closeModalEvent.VC_FOTYI44_RTTYV_089 = function(args){ //PANTALLA DE RE-INGRESO INFOCRED(VARIOS CLIENTES MISMA IDENTIFICACION)
		var parameter = args.result.parameter;
		args.commons.api.vc.executeCommand('VA_CEDNAGMTIE2108_CTME537','[Botón-Buscar]',undefined,false,false,'',false);
	}
    //**********************************************************
    //  Eventos de CHANGE
    //**********************************************************
    task.change.VA_CEDNAGMTIE2105_TYPE927 = function(entities, changedEventArgs) { //Entity: InfocredHeader.AssociateTo (ComboBox) View: InfocredManagementView
        changedEventArgs.commons.execServer = false;
		task.changeAssociateTo(entities.InfocredHeader, changedEventArgs, changedEventArgs.newValue);
    };

    task.change.VA_CEDNAGMTIE2105_RUSI719 = function(entities, changedEventArgs) { //Entity: InfocredHeader.ExistsLoanId (ComboBox) View: InfocredManagementView
        changedEventArgs.commons.execServer = false;
		if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.InfocredHeader.ExistsLoanId)){
			changedEventArgs.commons.api.viewState.disable('VA_CEDNAGMTIE2106_0000307');
			if(task.validateLoanStatus(entities.InfocredHeader, changedEventArgs, changedEventArgs.newValue)===true){
				changedEventArgs.commons.api.viewState.enable('VA_CEDNAGMTIE2106_0000307');
			}
		}else{
			changedEventArgs.commons.api.viewState.disable('VA_CEDNAGMTIE2106_0000307');
		}
    };

    task.change.VA_CEDNAGMTIE2105_SCAP360 = function(entities, changedEventArgs) { //Entity: InfocredHeader.AssociateWith (RadioButtonList) View: InfocredManagementView
        changedEventArgs.commons.execServer = false;
		task.changeAssociateWith(entities.InfocredHeader, changedEventArgs, changedEventArgs.newValue);
    };

    task.change.VA_CEDNAGMTIE2105_ANCK440 = function(entities, changedEventArgs) {//Entity: InfocredHeader.NewLoanCode (TextInputBox) View: InfocredManagementView
		task.validateChange(entities, changedEventArgs);
    };
	task.changeCallback.VA_CEDNAGMTIE2105_ANCK440 = function(entities, changedEventArgs) {
		task.validateChangeCallback(entities.InfocredHeader,changedEventArgs);
	};

    task.change.VA_CEDNAGMTIE2105_WEEI096 = function(entities, changedEventArgs) {//Entity: InfocredHeader.NewRequestId (TextInputBox) View: InfocredManagementView
		task.validateChange(entities, changedEventArgs);
    };
	task.changeCallback.VA_CEDNAGMTIE2105_WEEI096 = function(entities, changedEventArgs) {
		task.validateChangeCallback(entities.InfocredHeader,changedEventArgs);
	};

    //**********************************************************
    //  Eventos de LOAD CATALOG
    //**********************************************************
    task.loadCatalog.VA_CEDNAGMTIE2105_RUSI719 = function(loadCatalogDataEventArgs) { //Entity: InfocredHeader.ExistsLoanId (ComboBox) View: InfocredManagementView
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.InfocredHeader = true;
		var customerId = loadCatalogDataEventArgs.commons.api.vc.model.InfocredHeader.CustomerId;
		if(BUSIN.VALIDATE.IsNullOrEmpty(customerId) || (customerId<=0) ){
			loadCatalogDataEventArgs.commons.execServer = false;
		}
    };

    task.loadCatalog.VA_CEDNAGMTIE2105_TYPE927 = function(loadCatalogDataEventArgs) { //Entity: InfocredHeader.AssociateTo (ComboBox) View: InfocredManagementView
        loadCatalogDataEventArgs.commons.execServer = false;
		var associateTo=[];
		associateTo.push({code:'E',value:loadCatalogDataEventArgs.commons.api.viewState.translate('BUSIN.DLB_BUSIN_OPECNITNT_59440')});
		associateTo.push({code:'N',value:loadCatalogDataEventArgs.commons.api.viewState.translate('BUSIN.DLB_BUSIN_UEAICARNT_66840')});
		return associateTo;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_IDMEN42_NRTFR_390 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.api.viewState.readOnly('VA_CEDNAGMTIE2108_CTOM392', true);
		task.clear(entities, initDataEventArgs);
    };

    task.render = function(entities, renderEventArgs) {
		var viewState = renderEventArgs.commons.api.viewState, template;
		template = '<span class=\'Span-white-space-nowrap\'><b>Operaci\u00f3n:  </b>#: attributes[4]#</span><br>' +
        '<span class=\'Span-white-space-nowrap\'><b>Tr\u00e1mite: </b>#: code#<b> Estado: </b>#: attributes[3]#</span><br>' +
        '<span><b>Rol:  </b>#: attributes[1]#</span>';
		viewState.template('VA_CEDNAGMTIE2105_RUSI719', template);
    };

    //**********************************************************
    //  Funciones
    //**********************************************************
    task.clear = function(entities, args) {
		args.commons.api.grid.removeAllRows('InfocredItem');
		entities.InfocredHeader.CustomerId = null;
		entities.InfocredHeader.CustomerName = null;
		entities.InfocredHeader.ExistsLoanId = null;
		entities.InfocredHeader.NewLoanCode = null;
		entities.InfocredHeader.NewLoanId = null;
		entities.InfocredHeader.NewRequestId = null;
		entities.InfocredHeader.Role = null;
		entities.InfocredHeader.AssociateWith = 'O';
		entities.InfocredHeader.AssociateTo = 'E';
		entities.InfocredHeader.Out_SimilarList = null;
		entities.InfocredHeader.Out_HasManySimilar = false;
		entities.InfocredHeader.Out_Source = null;
		entities.InfocredHeader.Out_Role = null;
		entities.InfocredHeader.Out_RequestIdLoanId = null;
		args.commons.api.vc.catalogs.VA_CEDNAGMTIE2105_RUSI719.read();
		task.changeAssociateTo(entities.InfocredHeader, args, entities.InfocredHeader.AssociateTo);
		args.commons.api.viewState.disable('VA_CEDNAGMTIE2106_0000307');
	};

    task.changeAssociateTo = function(InfocredHeader, args, value) { //FUNCION QUE OCULTA CONTROLES DEPENDIENTO DEL COMBO 'Asociar a'
		var ctrs = ['VA_CEDNAGMTIE2105_RUSI719','VA_CEDNAGMTIE2105_SCAP360','VA_CEDNAGMTIE2105_ANCK440','VA_CEDNAGMTIE2105_WEEI096'];
		BUSIN.API.hide(args.commons.api.viewState,ctrs);
		args.commons.api.viewState.disable('VA_CEDNAGMTIE2106_0000307');
		if(value==='E'){
			args.commons.api.viewState.show('VA_CEDNAGMTIE2105_RUSI719');
		}else if(value==='N'){
			InfocredHeader.ExistsLoanId = null;
			args.commons.api.viewState.show('VA_CEDNAGMTIE2105_SCAP360');
			task.changeAssociateWith(InfocredHeader, args, InfocredHeader.AssociateWith);
		}
    };

    task.changeAssociateWith = function(InfocredHeader, args, value) { //FUNCION QUE OCULTA LA 'OPERACION' O EL 'TRAMITE' DEPENDIENTO DEL RADIO-BUTTON 'Asociar con'
		BUSIN.API.hide(args.commons.api.viewState,['VA_CEDNAGMTIE2105_ANCK440','VA_CEDNAGMTIE2105_WEEI096']);
		args.commons.api.viewState.disable('VA_CEDNAGMTIE2106_0000307');
		if(InfocredHeader.AssociateTo==='N'){
			if(value==='O'){
				InfocredHeader.NewRequestId = null;
				args.commons.api.viewState.show('VA_CEDNAGMTIE2105_ANCK440');
			}else if(value==='T'){
				InfocredHeader.NewLoanId = null;
				InfocredHeader.NewLoanCode = null;
				args.commons.api.viewState.show('VA_CEDNAGMTIE2105_WEEI096');
			}
		}
    };

    task.validateLoanStatus = function(InfocredHeader, args, value) { //ENCUENTRA EL OBJETO SELECCIONADO DEL COMBO-BOX - PARA LUEGO VALIDAR SU ESTADO
		var rows = args.commons.api.vc.catalogs.VA_CEDNAGMTIE2105_RUSI719.data();
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].code === value){
				if(rows[i].attributes[2]===3 || rows[i].attributes[2]===6){//estado 3(cancelado) y  6(anulado)
					var params = [value,rows[i].attributes[2]];
					args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_STORIOEAA_96312',params,5000);
					return false;
				}
				InfocredHeader.Role = rows[i].attributes[0];
			}
		}
		return true;
	};

    task.validateChange = function(entities, args) { //VALIDA EN EL (CHANGE) - QUE EXISTA UN CLIENTE Y QUE LA OPERACION/TRAMITE INGRESADO NO SEA NULL O VACIO
        if(!task.hasCustomer(entities.InfocredHeader)){
			args.commons.execServer = false;
			task.clear(entities, args);
		}
		if(BUSIN.VALIDATE.IsNullOrEmpty(args.newValue)){
			args.commons.execServer = false;
			args.commons.api.viewState.disable('VA_CEDNAGMTIE2106_0000307');
		}
    };

	task.validateChangeCallback = function(InfocredHeader,args) { //VALIDA EN EL CALLBACK(CHANGE) - QUE LA OPERACION/TRAMITE SEA CORRECTO PARA HABILITAR EL BOTON DE REGISTRO INFOCRED
		if(task.hasCustomer(InfocredHeader) && args.success===true){
			args.commons.api.viewState.enable('VA_CEDNAGMTIE2106_0000307');
		}else{
			args.commons.api.viewState.disable('VA_CEDNAGMTIE2106_0000307');
		}
	};

	task.hasCustomer = function(InfocredHeader) { //VALIDA QUE HAYA UN CLIENTE SELECCIONADO
		return (!BUSIN.VALIDATE.IsNullOrEmpty(InfocredHeader.CustomerId) && (InfocredHeader.CustomerId>0))
	};

}());