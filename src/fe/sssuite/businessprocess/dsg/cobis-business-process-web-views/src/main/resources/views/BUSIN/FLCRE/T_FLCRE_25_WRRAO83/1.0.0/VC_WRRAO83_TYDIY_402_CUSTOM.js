<!-- Designer Generator v 5.0.0.1516 - release SPR 2015-16 21/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.warrantymodify;
    task.RequestStage = '';
    task.RequestName = '';
    task.RequestType = '';
	task.otherWarranty = '';
	task.ModifyType = '';
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) { //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) { //DebtorGeneral.Role (ComboBox) View: BorrowerView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_OQUE134 = function(entities, changedEventArgs) { //OriginalHeader.AmountRequested (TextInputBox) View: HeaderView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) { //OriginalHeader.Quota (TextInputBox) View: HeaderView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_REEM856 = function(entities, changedEventArgs) {  //OriginalHeader.Agreement (CheckBox) View: HeaderView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_REET975 = function(entities, changedEventArgs) { //OriginalHeader.CodeAgreement (ComboBox) View: HeaderView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_ORIAHEADER8602_URQT595 = function(entities, changedEventArgs) { //OriginalHeader.CurrencyRequested (ComboBox) View: HeaderView
        changedEventArgs.commons.execServer = false;
    };
    task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) { //OriginalHeader.CreditLineValid (ComboBox) View: HeaderView
        loadCatalogDataEventArgs.commons.execServer = false;
    };
    task.loadCatalog.VA_ORIAHEADER8602_REET975 = function(loadCatalogDataEventArgs) { //OriginalHeader.CodeAgreement (ComboBox) View: HeaderView
        loadCatalogDataEventArgs.commons.execServer = false;
    };
    task.change.VA_WRRTAERRES1199_TYPE485 = function(entities, changedEventArgs) { //Entity: WarrantyHeaderRequest.Type (ComboBox) View: VWarrantyHeaderRequest
        changedEventArgs.commons.execServer = false;
		task.ModifyType = changedEventArgs.newValue;
		changedEventArgs.commons.api.grid.filter('QV_URYTH5890_38');
		if(task.changeModifyType(entities,changedEventArgs,true)===false){
			task.ModifyType = changedEventArgs.oldValue;
			entities.WarrantyHeaderRequest.Type = changedEventArgs.oldValue;
		}
    };
	 //Entity:
    //.Autorizar (Button) View: ViewExceptionApprove
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VEWCEIOPOV3807_0000587 = function(entities, executeCommandEventArgs) {
    };
	task.executeCommandCallback.VA_VEWCEIOPOV3807_0000587 = function(entities, executeCommandCallbackEventArgs) {
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};
    //**********************************************************
    //  Acciones de QUERY VIEW - Borrowers
    //**********************************************************
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
    };
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };
    //**********************************************************
    //  Acciones de QUERY VIEW - GridDocumentProduct
    //**********************************************************
    task.gridRowSelecting.QV_QDMNT8051_16 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };
	task.gridInitColumnTemplate.QV_QDMNT8051_16 = function(idColumn) {
        if(idColumn === 'YesNot'){
			return "<input type=\'checkbox\' name=\'YesNot\' id=\'VA_DOCUNODCVW7303_YSNO533\' #if (YesNot === true) {# checked #}# ng-click=\"vc.grids.QV_QDMNT8051_16.events.customRowClick($event, \'VA_DOCUNODCVW7303_YSNO533\', \'DocumentProduct\', 'QV_QDMNT8051_16')\"/>";
			//return "<input type=\'checkbox\' name=\'YesNot\' id=\'VA_DOCUNODCVW7303_YSNO533\' #if (YesNot === true) {# checked #}# ng-click=\"vc.grids.QV_QDMNT8051_16.events.customRowClick($event, \'VA_DOCUNODCVW7303_YSNO533\', \'DocumentProduct\', grids.QV_QDMNT8051_16)\"/>";
		}
    };
	task.gridRowCommand.VA_DOCUNODCVW7303_YSNO533 = function (entities, args) {	//QueryView: GridDocumentProduct - Actualiza el Valor de la Entidad.
        args.commons.execServer = false;
		args.rowData.YesNot = !args.rowData.YesNot;
	};
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Guardar (Button)
    task.executeCommand.CM_WRRAO83GDR62 = function(entities, executeCommandEventArgs) {
	    if( task.isWarrantyModify() && task.isAnalysis() ) {
			executeCommandEventArgs.commons.execServer = false;
			BUSIN.INBOX.STATUS.nextStep(true,executeCommandEventArgs.commons.api);
		}else if( task.isWarrantyModify() && task.isPrintingDocuments() ) {
			//Para impresion de documentos
			var debtor = entities.DebtorGeneral._data[0].CustomerCode;
			for (var i = 0; i <= entities.DocumentProduct.data().length - 1; i++) {
				if(entities.DocumentProduct.data()[i].YesNot === true){
					var city = executeCommandEventArgs.commons.api.viewState.selectedText('VA_ORIAHEADER8602_ITCE121', entities.OriginalHeader.CityCode);
					if(FLCRE.CONSTANTS.Report.LoanApplication===entities.DocumentProduct.data()[i].Template){
						var debtorP = FLCRE.UTILS.CUSTOMER.getDebtor(entities.DebtorGeneral.data());
						var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.LoanApplication],['cstDebtor',debtorP.CustomerCode],['cstName',debtorP.CustomerName],['cstId',debtorP.Identification],['cstTrId',entities.OriginalHeader.IDRequested],['cstAplId',entities.OriginalHeader.ApplicationNumber]];
						var debtors = entities.DebtorGeneral.data();
						var count = 0;
						for (var j = 0; j < debtors.length; j++) {
							if(debtors[j].Role == 'C'){
								count = count + 1;
								args.push(['cstCodeu'+count, debtors[j].CustomerCode]);
							}
						}
					}else{
						var args = [['report.module', 'credito'],['report.name', entities.DocumentProduct.data()[i].Template],['idCustomer', debtor],['idCustomerTwo','0'],['idTramit',entities.OriginalHeader.IDRequested], ['idCity',city],['reportGuarantor','']];
					}
					BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template,args);
				}
			}
			executeCommandEventArgs.commons.execServer = true;
		}else if( task.isWarrantyModify() && task.isEntry() ) {
			var rows = entities.OtherWarranty.data();
			var countRows = 0;
			var erroMessage = '';
			switch (task.ModifyType) {
			case 'ABG': //ADICION
				erroMessage = 'BUSIN.DLB_BUSIN_NOSOVESTS_40083';
				for (var i = 0; i < rows.length; i ++) {
					if(rows[i].IsNew===true){countRows = countRows + 1; }
				}
				break;
			case 'CJE': //SUSTITUCION
			case 'LEV': //ELIMINACION
				erroMessage = 'BUSIN.DLB_BUSIN_SEOTUNGNT_12028';
				for (var i = 0; i < rows.length; i ++) {
					if(rows[i].Flag===true){countRows = countRows + 1; }
				}
				break;
			}
			if(countRows===0){
				executeCommandEventArgs.commons.execServer = false;
				executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError(erroMessage,null,10000);
			}
		}
    };
	task.executeCommandCallback.CM_WRRAO83GDR62 = function(entities, executeCommandEventArgs) {
		if( task.isWarrantyModify() && task.isEntry() ) {
			task.formatWarrantyGrid(entities,executeCommandEventArgs);
		} else if( task.isWarrantyModify() && task.isAnalysis() ) {
			task.disableWarrantyGrid(entities,executeCommandEventArgs);
		}
		BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
	};

    //Hide (Button)
    task.executeCommand.CM_WRRAO83IDE96 = function(entities, executeCommandEventArgs) {
    };
	task.executeCommandCallback.CM_WRRAO83IDE96 = function(entities, executeCommandEventArgs) {
		task.formatWarrantyGrid(entities,executeCommandEventArgs);
	}
    //**********************************************************
    //  Acciones de QUERY VIEW - GOtherWarranty
    //**********************************************************
	task.gridRowDeleting.QV_URYTH5890_38 = function(entities, args) {
        args.commons.execServer = false;
		entities.Context.Type = 'F';
		entities.Context.Bookmark = args.rowData.CodeWarranty;
		args.commons.api.vc.executeCommand('CM_WRRAO83IDE96','Hide', undefined, false, false, 'VC_WRRAO83_TYDIY_402', false);
    };
    task.gridRowSelecting.QV_URYTH5890_38 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };
    task.gridInitDetailTemplate.QV_URYTH5890_38 = function(entities, args) {
        args.commons.execServer = false;
		var nav = FLCRE.API.getApiNavigation(args,'T_FLCRE_35_RAYTI33','VC_RAYTI33_AEAIL_889');
		nav.customDialogParameters = { Data: args.modelRow, OtherWarranty: entities.OtherWarranty, OriginalHeader:entities.OriginalHeader,  RequestName: task.RequestName , RequestStage: task.RequestStage };
		nav.openDetailTemplate('QV_URYTH5890_38', args.modelRow);
    };
    task.gridInitColumnTemplate.QV_URYTH5890_38 = function(idColumn) {
		 if(idColumn === 'Flag'){
			var template = "<input type=\'checkbox\' name=\'Flag\' id=\'VA_VORWARRANT9457_LSON247' ";
			template = template + " #if (IsNew === true) {# disabled #}# ";
			template = template + " #if (Flag === true) {# checked #}# ";
			template = template + " ng-click=\"vc.grids.QV_URYTH5890_38.events.customRowClick($event, \'VA_VORWARRANT9457_LSON247\', \'OtherWarranty\', 'QV_URYTH5890_38')\"/>";
			return template;
		}
    };

	task.gridRowCommand.VA_VORWARRANT9457_LSON247 = function (entities, args) { //OtherWarranty.Flag - VA_VORWARRANT9457_LSON247
        args.commons.execServer = false;
		if( task.isWarrantyModify() && task.isEntry() ) {
			args.rowData.Flag = !args.rowData.Flag;
			args.commons.api.grid.filter('QV_URYTH5890_38'); //No existe filtro, solo mando esta instruccion para que se refresque el icono del detalle del grid
			if(args.rowData.Flag){
				entities.Context.Type = 'C';
			}else{
				entities.Context.Type = 'D';
			}
			entities.Context.Bookmark = args.rowData.CodeWarranty;
			args.commons.api.vc.executeCommand('CM_WRRAO83IDE96','Hide', undefined, false, false, 'VC_WRRAO83_TYDIY_402', false);
		}
	};
	task.showGridRowDetailIcon.QV_URYTH5890_38 = function (entities, showGridRowDetailIconEventArgs){ //Ocultar icono de detalle de grilla dinamicamente - programaticamente
        var row = showGridRowDetailIconEventArgs.rowData;
        return ( (row.Flag===true) && (task.ModifyType==='CJE') ); //SUSTITUCION
    };
	task.gridBeforeEnterInLineRow.QV_URYTH5890_38 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
		task.otherWarranty = entities.OtherWarranty;
		if( task.isWarrantyModify() && task.isEntry() ) {
			var regs = entities.OtherWarranty.data();
			if(regs.length>0){
				gridABeforeEnterInLineRowEventArgs.commons.api.grid.removeRow('OtherWarranty', 0);
			}
			//Abrir pantalla de busqueda de garantias
			var nav = FLCRE.API.getApiNavigation(gridABeforeEnterInLineRowEventArgs,'T_FLCRE_24_GURNH31','VC_GURNH31_OMREA_904');
			nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
			nav.modalProperties = { size: 'lg' };
			nav.queryParameters = { mode: gridABeforeEnterInLineRowEventArgs.commons.constants.mode.Update };
			nav.customDialogParameters = { };
			nav.openModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId);
		}
    };
    //**********************************************************
    //  Acciones Windows
    //**********************************************************
	task.closeModalEvent.VC_GURNH31_OMREA_904 = function(args){
		var parameter = args.result.parameterGuarantee;
		if(parameter.UserCreation != args.commons.args.user){//mensaje que indica que el usuario de la sesion no ha dado de alta la garantia que esta asociando
			args.commons.messageHandler.showTranslateMessagesInfo('BUSIN.DLB_BUSIN_USENEATAA_82909',null,5000);
		}
		if(task.existWarrantyModify(task.otherWarranty, parameter)=== true){
			args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_SQULSOLEA_55728',null,5000);
			return;
		}
		var newOtherWarranty={
			CodeWarranty: parameter.GuaranteeCode,
			Type: parameter.GuaranteeType,
			Description: parameter.Description,
			//GuarantorPrimarySecondary: parameter.GuarantorName,
			InitialValue: parameter.InitialValue,
			DateAppraisedValue: parameter.AppraisedValueDate,
			ValueApportionment: null, //OJA VALIDAR CON AURELIA PORQUE ESTA QUEMADO ESTE VALOR
			ClassOpen: parameter.CloseOpen,
			ValueAvailable: parameter.ValueAvailable,
			IdCustomer:parameter.CustomerId,
			NameGar: parameter.GuarantorName,
			State: parameter.Status,
			IsNew: true,
			Flag: false
		};
		args.commons.api.grid.addRow('OtherWarranty', newOtherWarranty);
		args.commons.api.vc.model.Context.Type = 'I';
		args.commons.api.vc.model.Context.Bookmark = newOtherWarranty.CodeWarranty;
		args.commons.api.vc.executeCommand('CM_WRRAO83IDE96','Hide', undefined, false, false, 'VC_WRRAO83_TYDIY_402', false);
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_WRRAO83_TYDIY_402 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.api.viewState.hide('CM_WRRAO83IDE96');
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		if(parentParameters.Task.urlParams.Tramite != null && parentParameters.Task.urlParams.Tramite !== undefined){
            task.RequestName = parentParameters.Task.urlParams.Tramite;
			entities.Context.RequestName = parentParameters.Task.urlParams.Tramite;
		}
        if(parentParameters.Task.urlParams.Etapa != null && parentParameters.Task.urlParams.Etapa !== undefined){
            task.RequestStage = parentParameters.Task.urlParams.Etapa;
			entities.Context.RequestStage = parentParameters.Task.urlParams.Etapa;
        }
        if(parentParameters.Task.urlParams.Type != null && parentParameters.Task.urlParams.Type !== undefined){
            task.RequestType = parentParameters.Task.urlParams.Type;
			entities.Context.RequestType = parentParameters.Task.urlParams.Type;
        }

        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.Context.Application = parentParameters.Task.processInstanceIdentifier;
		entities.Context.CustomerId = parentParameters.Task.bussinessInformationIntegerOne;
		if(!BUSIN.VALIDATE.IsNull(parentParameters.Task.bussinessInformationIntegerTwo) && (parentParameters.Task.bussinessInformationIntegerTwo>0)){
			entities.OriginalHeader.IDRequested = parentParameters.Task.bussinessInformationIntegerTwo
		}
        entities.OriginalHeader.OpNumberBank = parentParameters.Task.bussinessInformationStringOne
        entities.OriginalHeader.Office=cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);

		if( task.isWarrantyModify()){
			var viewState = initDataEventArgs.commons.api.viewState;
			var grid = initDataEventArgs.commons.api.grid;
			grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
			grid.hideToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
			viewState.label('VA_ORIAHEADER8602_NRAK349','BUSIN.DLB_BUSIN_OPEIONBER_32159');
			var ctrs = ['VA_ORIAHEADER8602_OQUE134','VA_ORIAHEADER8602_URQT595','VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773','VA_ORIAHEADER8602_CRET312',
						'VC_WRRAO83_NLAUR_144','VC_WRRAO83_XCPOV_772','VC_WRRAO83_RIOME_631','VC_WRRAO83_NRRED_631'];
			BUSIN.API.hide(viewState,ctrs);
			BUSIN.API.show(viewState,['VA_ORIAHEADER8602_FNME018','VA_ORIAHEADER8602_NRAK349']);
			ctrs = ['VA_ORIAHEADER8602_IALT328','VA_ORIAHEADER8602_NRAK349','VA_WRRTAERRES1199_RUEY376','VA_WRRTAERRES1199_MOUT074','VA_WRRTAERRES1199_RRCY912',
					'VA_WRRTAERRES1199_BLAC194','VA_WRRTAERRES1199_TERM768','VA_WRRTAERRES1199_TYPE485','VA_WRRTAERRES1195_RASO850'];
			BUSIN.API.disable(viewState,ctrs);

			grid.title('QV_IFOPA9055_49', 'titleColumn', '');
			BUSIN.API.GRID.hideColumns('QV_IFOPA9055_49', ['agreedPayment','balance'], initDataEventArgs.commons.api)
			viewState.addStyle('QV_IFOPA9055_49','Grid-Width-360');
			//viewState.addStyle('VC_WRRAO83_NRRED_631','Group-Margin-Top--40');
			//BUSIN.API.addStyle('Group-Margin-Top--30',viewState,['VC_WRRAO83_RIOME_631','VC_WRRAO83_PANPW_425','VC_WRRAO83_PPARN_927','VC_WRRAO83_NLAUR_144','VC_WRRAO83_XCPOV_772']);
		}
    };

	task.initDataCallback.VC_WRRAO83_TYDIY_402 = function(entities, initDataEventArgs) {
		if(initDataEventArgs.success===false){
            initDataEventArgs.commons.api.viewState.hide('CM_WRRAO83GDR62');
            initDataEventArgs.commons.api.viewState.disable('CM_WRRAO83GDR62');
			task.ModifyType = 'XX';
		}else{
			task.ModifyType = entities.WarrantyHeaderRequest.Type;
		}
		task.changeModifyType(entities,initDataEventArgs);
		//NOMBRE DE COLUMNAS
		var rowsIP = entities.InfoPayment.data();
		for (var i = 0; i < rowsIP.length; i ++) {
			rowsIP[i].titleColumn = cobis.translate(rowsIP[i].titleColumn);
		}
	};

    task.render = function(entities, renderEventArgs) {
		var viewState = renderEventArgs.commons.api.viewState;

		if( task.isWarrantyModify() && task.isEntry() ) {
			task.formatWarrantyGrid(entities,renderEventArgs);
			BUSIN.API.show(viewState,['VC_WRRAO83_RIOME_631','VC_WRRAO83_NRRED_631']);
			BUSIN.API.enable(viewState,['VA_WRRTAERRES1199_TYPE485','VA_WRRTAERRES1195_RASO850']);
		}else if( task.isWarrantyModify() && task.isAnalysis() ) {
			viewState.disable('VA_WRRTAERRES1195_RASO850');
			task.disableWarrantyGrid(entities,renderEventArgs);
			renderEventArgs.commons.api.vc.viewState.CM_WRRAO83GDR62.visible=false;
			BUSIN.INBOX.STATUS.nextStep(true,renderEventArgs.commons.api);
			BUSIN.API.show(viewState,['VC_WRRAO83_RIOME_631','VC_WRRAO83_NRRED_631']);
		}else if( task.isWarrantyModify() && task.isAsocWarranty() ) {
			viewState.disable('VA_WRRTAERRES1195_RASO850');
			task.disableWarrantyGrid(entities,renderEventArgs);
			renderEventArgs.commons.api.vc.viewState.CM_WRRAO83GDR62.visible=false;
			BUSIN.INBOX.STATUS.nextStep(true,renderEventArgs.commons.api);
		}else if( task.isWarrantyModify() && task.isPrintingDocuments() ) {
			viewState.label("CM_WRRAO83GDR62", "BUSIN.DLB_BUSIN_PRINTNQCA_63767");
			viewState.disable('VA_WRRTAERRES1195_RASO850');
			viewState.hide('VC_WRRAO83_PPARN_927');
			BUSIN.API.show(viewState,['VC_WRRAO83_NRRED_631','VC_WRRAO83_NLAUR_144']); //APCH
			//renderEventArgs.commons.api.grid.hideColumn('QV_QDMNT8051_16', 'ReportParamGuarantor');
		}else if(task.isWarrantyModify() && task.isAproval()){
			viewState.show('VC_WRRAO83_XCPOV_772');
			BUSIN.API.show(viewState,['VC_WRRAO83_RIOME_631','VC_WRRAO83_NRRED_631']);
			task.disableAllField(viewState);
			renderEventArgs.commons.api.vc.viewState.CM_WRRAO83GDR62.visible=false;//se oculta el boton Guardar
			task.disableWarrantyGrid(entities,renderEventArgs);
		}
    };

    task.isWarrantyModify = function() { return task.RequestName === FLCRE.CONSTANTS.RequestName.WarrantyModify;};
    task.isEntry = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.Entry;};
    task.isAnalysis = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.Analisis;};
	task.isAsocWarranty = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.AsociacionGarantias;};
	task.isPrintingDocuments = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.ImpresionDocumentos;};
	task.isAproval = function() {return task.RequestStage === FLCRE.CONSTANTS.Stage.Aprobacion;};
	task.formatWarrantyGrid = function(entities,args) {
		var rows = entities.OtherWarranty.data();
		for (var i = 0; i < rows.length; i ++) {
			if(rows[i].IsNew===false){
				args.commons.api.grid.hideGridRowCommand('QV_URYTH5890_38', rows[i], 'delete');
			}else if(task.ModifyType==='ABG'){//ADICION
				args.commons.api.grid.addRowStyle('QV_URYTH5890_38', rows[i], 'row-mark-style2');
			}
			if(rows[i].Flag===true){
				if( (task.ModifyType==='CJE') || (task.ModifyType==='LEV') ){//SUSTITUCION-ELIMINACION
					args.commons.api.grid.addRowStyle('QV_URYTH5890_38', rows[i], 'row-mark-style3');
				}
			}
		}
	};
	task.disableWarrantyGrid = function(entities,args) {
		args.commons.api.grid.hideToolBarButton('QV_URYTH5890_38', 'create');//boton nuevo
		var rows = entities.OtherWarranty.data();
		for (var i = 0; i < rows.length; i ++) {
			if(rows[i].IsNew===true){
				if(task.ModifyType==='ABG'){//ADICION
					args.commons.api.grid.addRowStyle('QV_URYTH5890_38', rows[i], 'row-mark-style2');
				}
			}
			if(rows[i].Flag===true){
				if( (task.ModifyType==='CJE') || (task.ModifyType==='LEV') ){//SUSTITUCION-ELIMINACION
					args.commons.api.grid.addRowStyle('QV_URYTH5890_38', rows[i], 'row-mark-style3');
				}
			}
			rows[i].IsNew=true;
		}
		args.commons.api.grid.filter('QV_URYTH5890_38'); //No existe filtro, solo mando esta instruccion para que se refresque el icono del detalle del grid
		BUSIN.API.GRID.hideCommandColumns('QV_URYTH5890_38',entities.OtherWarranty.data(),args.commons.api,'delete');
	}

	//Funcion para deshabilitar todos los campos
	task.disableAllField = function(viewState) {
		var grps = ['VA_ORIAHEADER8602_IOUR445','VA_ORIAHEADER8602_RQSD386','VA_ORIAHEADER8602_ITCE121','VA_ORIAHEADER8602_0000908',
			'VA_WRRTAERRES1195_RASO850','VA_ORIAHEADER8602_IALT328','VA_ORIAHEADER8602_NRAK349','VA_ORIAHEADER8602_FNME018'];
		BUSIN.API.disable(viewState,grps);
	};
	//Valida que la garantía no se encuentre ingresada.
	task.existWarrantyModify = function(Warranty, parameter) {
		var regs = Warranty.data();
		var flag = false;
		if(regs.length>0){
			regs.forEach(function(data){
				if(data.CodeWarranty===parameter.GuaranteeCode){
					flag =  true;
				}
			});
		}
		return flag;
	};

	task.changeModifyType = function(entities,args,showMessage) {
		var returnValue = true;
		var rows = entities.OtherWarranty.data();
		var erroMessage = '';
		var grid = args.commons.api.grid;
		switch (task.ModifyType) {
			case 'ABG': //ADICION
				grid.showToolBarButton('QV_URYTH5890_38', 'create');
				grid.hideColumn ('QV_URYTH5890_38', 'Flag');
				for (var i = 0; i < rows.length; i ++) {
					if(rows[i].Flag===true){returnValue = false; erroMessage = 'BUSIN.DLB_BUSIN_PCISEEASU_20444'; }
				}
				break;
			case 'CJE': //SUSTITUCION
				grid.hideToolBarButton('QV_URYTH5890_38', 'create');
				grid.showColumn ('QV_URYTH5890_38', 'Flag');
				grid.title('QV_URYTH5890_38', 'Flag', 'BUSIN.DLB_BUSIN_SUSTITUIR_39364');
				for (var i = 0; i < rows.length; i ++) {
					if(rows[i].IsNew===true){returnValue = false; erroMessage = 'BUSIN.DLB_BUSIN_SEDMRNEGS_25989'; }
				}
				break;
			case 'LEV': //ELIMINACION
				grid.hideToolBarButton('QV_URYTH5890_38', 'create');
				grid.showColumn ('QV_URYTH5890_38', 'Flag');
				grid.title('QV_URYTH5890_38', 'Flag', 'BUSIN.DLB_BUSIN_DELETEVPS_36022');
				for (var i = 0; i < rows.length; i ++) {
					if(rows[i].IsNew===true){returnValue = false; erroMessage = 'BUSIN.DLB_BUSIN_SEDMRNEGS_25989';}
				}
				break;
			default:
				grid.hideColumn ('QV_URYTH5890_38', 'Flag');
				grid.hideToolBarButton('QV_URYTH5890_38', 'create');
				break;
		}
		if(returnValue === false && showMessage===true){
			args.commons.messageHandler.showTranslateMessagesError(erroMessage,null,10000);
		}
		return returnValue;
	};
}());