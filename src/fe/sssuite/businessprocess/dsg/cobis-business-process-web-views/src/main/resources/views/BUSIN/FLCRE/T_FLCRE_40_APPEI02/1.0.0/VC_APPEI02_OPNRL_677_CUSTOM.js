<!-- Designer Generator v 5.0.0.1509 - release SPR 2015-09 15/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.taskapplicationcreditline;
	task.RequestName = '';
	task.RequestStage = '';

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
		OTHERCREDITDATA.changeActivity(entities, changedEventArgs,task.RequestName);
    };

	//Entity: CreditOtherData
    //CreditOtherData.CreditPorpuse (ComboBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4904_RPPU470 = function(entities, changedEventArgs) {
	    changedEventArgs.commons.execServer = false;
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
		serverParameters.LineHeader = true;
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

    //.Btn_Validate (Button) View: CreditOtherDataView
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

	//Entity: LineHeader
    //LineHeader.EntryDate (DateField) View: ApplicationHeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_APITONEAEE5505_NDTE867 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

	    //Entity: LineHeader
    //LineHeader.Sector (ComboBox) View: ApplicationHeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_APITONEAEE5505_SCTR004 = function(entities, changedEventArgs) {
		if(task.RequestStage != FLCRE.CONSTANTS.Stage.AnalisisOficial){
            changedEventArgs.commons.execServer = false;
        }else{
	    if (changedEventArgs.newValue === entities.IndexSizeActivity.ParameterFixedIncome) {
            entities.IndexSizeActivity.Patrimony = "";
            entities.IndexSizeActivity.PersonalNumber = "";
            entities.IndexSizeActivity.Sales = "";
            entities.IndexSizeActivity.IndexSizeActivity = "";
            entities.IndexSizeActivity.AnnualSales = "";
            entities.IndexSizeActivity.ProductiveAssets = "";
			entities.IndexSizeActivity.sizeCompany = "";
            changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_ATRN190");
            changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_SALE147");
            changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_PESL753");
            changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NEIY699");
            changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NULE410");
            changedEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_RCIE187");
            changedEventArgs.commons.execServer = false;
            changedEventArgs.commons.messageHandler.showMessagesInformation($("#VA_APITONEAEE5505_SCTR004").data("kendoExtComboBox").text());
        } else {
            entities.IndexSizeActivity.Patrimony = "";
            entities.IndexSizeActivity.PersonalNumber = "";
            entities.IndexSizeActivity.Sales = "";
            entities.IndexSizeActivity.IndexSizeActivity = "";
            entities.IndexSizeActivity.AnnualSales = "";
            entities.IndexSizeActivity.ProductiveAssets = "";
            changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_NULE410");
            changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_RCIE187");
            changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_ATRN190");
            changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_SALE147");
            changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_PESL753");
            changedEventArgs.commons.api.viewState.enable("VA_RIOTRDTAVI4909_NEIY699");
            if ((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "") && (entities.IndexSizeActivity.PersonalNumber != null &&
                entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")) {
                changedEventArgs.commons.execServer = true;
            } else {
                changedEventArgs.commons.execServer = false;
            }
        }}
    };

    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //LineHeader.Number (TextLink) View: ApplicationHeaderView
    //task.executeCommand.VA_APITONEAEE5507_0000606 = function(entities, executeCommandEventArgs) {
	task.executeCommand.VA_APITONEAEE5510_0000944 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var nav = executeCommandEventArgs.commons.api.navigation;
		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CUOMREARH_28245');
        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_14_NEEDA85',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_NEEDA85_LHEIL_830'
        };
        nav.customDialogParameters = {
            lineHeader: entities['LineHeader']
        };
		nav.popoverProperties = {
            width: 500,
            height: 'auto',
            position: "left bottom"
        };
        nav.openPopover(executeCommandEventArgs.commons.controlId);
    };

    //IndexSizeActivity.Patrimony (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
		if (validateIndexSize(entities, changedEventArgs)) {
            changedEventArgs.commons.execServer = true;
        } else {
            changedEventArgs.commons.execServer = false;
        }
    };

    //IndexSizeActivity.PersonalNumber (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
		if (validateIndexSize(entities, changedEventArgs)) {
            changedEventArgs.commons.execServer = true;
        } else {
            changedEventArgs.commons.execServer = false;
        }
    };

    //IndexSizeActivity.Sales (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
		 if (validateIndexSize(entities, changedEventArgs)) {
            changedEventArgs.commons.execServer = true;
        } else {
            changedEventArgs.commons.execServer = false;
        }
    };

    //DistributionLine.AmountPurposed (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

  //DistributionLine.Currency (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

	//OriginalHeader.AmountRequested  (TextInputBox) View: CreditOtherDataView  -- problema con evento change no se encontro.
    task.change.VA_APITONEAEE5506_OQUE114 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //SaveApplication (Button)
    task.executeCommand.CM_APPEI02PAO80 = function(entities, executeCommandEventArgs) {
		if(task.RequestStage===FLCRE.CONSTANTS.Stage.AnalisisOficial) {
			//EN ETAPA DE 'ANALISIS DEL OFICIAL' VALIDA QUE ESTE LLENO EL CAMPO 'FECHA-CIC'
			if(!FLCRE.UTILS.CUSTOMER.hasDateCIC(entities,executeCommandEventArgs,true)){
				executeCommandEventArgs.commons.execServer = false;
				return;
			}
			//EN ETAPA DE 'ANALISIS DEL OFICIAL' y TRAMITE 'MODIFICACION LC PLAZO Y MONTO' - VALIDA QUE ESTE LLENO EL CAMPO "Monto aprobado"
			if( task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo){
				if(!BUSIN.VALIDATE.EmptyFieldValue(entities.OriginalHeader.AmountApproved,'BUSIN.DLB_BUSIN_MNTAPRODO_28697',executeCommandEventArgs,true)) {
					return;
				}
			}
		}

        if (entities.OriginalHeader.AmountRequested >0 ) {
			if (entities.LineHeader.AmountUsed > entities.OriginalHeader.AmountRequested ){
				executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_VALDCIOLC_68403');
				executeCommandEventArgs.commons.execServer = false;
				executeCommandEventArgs.commons.api.viewState.focus('VA_APITONEAEE5506_OQUE114');
			}else {
                executeCommandEventArgs.commons.execServer = true;
			}
        }else{
            executeCommandEventArgs.commons.messageHandler.showMessagesInformation('El monto Solicitado debe ser mayor que 0');
            executeCommandEventArgs.commons.execServer = false;
        }
    };

	task.executeCommandCallback.CM_APPEI02PAO80  = function(entities, executeCommandCallbackEventArgs) {
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
		var api = executeCommandCallbackEventArgs.commons.api;
		BUSIN.API.GROUP.selectTab('GR_RIOTRDTAVI49_03',0,api);
		if(executeCommandCallbackEventArgs.success){
			api.viewState.enable("CM_APPEI02TCI41");
		}
		if(parentApi != undefined && executeCommandCallbackEventArgs.success){
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
	}

    //Registrar Infocred (Button)
    task.executeCommand.CM_APPEI02EGC47 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };

    task.executeCommandCallback.CM_APPEI02EGC47 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		FLCRE.UTILS.INFOCRED.openReentryWindowDebtor(entities.InfocredHeader,executeCommandCallbackEventArgs);
	};

    //PrintApplication (Button)
    task.executeCommand.CM_APPEI02TCI41 = function(entities, executeCommandEventArgs) {
		var debtor = entities.DebtorGeneral._data[0].CustomerCode;
		//entities.DocumentProduct.ReportParamGuarantor = 'mix';
		//var reportGuarantor = entities.DocumentProduct.ReportParamGuarantor;
        for (var i = 0; i <= entities.DocumentProduct.data().length - 1; i++) {
			if(entities.DocumentProduct.data()[i].YesNot === true){
				var city = entities.OriginalHeader.CityCode;
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
					var args = [['report.module', 'credito'],['report.name', entities.DocumentProduct.data()[i].Template],['idCustomer', debtor],['idCustomerTwo','0'],['idTramit',entities.OriginalHeader.IDRequested], ['idCity',city],['reportGuarantor',''],['idProcess',entities.OriginalHeader.ApplicationNumber]];
				}
				BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template,args);
			}
		}
		executeCommandEventArgs.commons.execServer = true;
    };

	task.executeCommandCallback.CM_APPEI02TCI41 = function(entities, executeCommandCallbackEventArgs) {
        var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
		if(parentApi != undefined && executeCommandCallbackEventArgs.success){
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
		executeCommandCallbackEventArgs.commons.execServer = false;
	};

    //Infocred Report (Button)
    task.executeCommand.CM_APPEI02ORE38 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };

    task.executeCommandCallback.CM_APPEI02ORE38 = function(entities, executeCommandCallbackEventArgs) {
		if(executeCommandCallbackEventArgs.success){
			FLCRE.UTILS.INFOCRED.getReportByCustomer(executeCommandCallbackEventArgs);
		}
	};
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) { //InsertingRow QueryView: GridDistributionLine
    };
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {//UpdateRow QueryView: GridDistributionLine
    };
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) { //DeleteRow QueryView: GridDistributionLine
    };
	
    task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { //SectingDeudores QueryView: Borrowers
        gridRowSelectingEventArgs.commons.execServer = false;
    };
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) { //RowInserting QueryView: Borrowers
        gridRowInsertingEventArgs.commons.execServer = false;
    };
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) { //GridCommand (Button) QueryView: Borrowers
		gridExecuteCommandEventArgs.commons.execServer = false;
		//Solo para eliminar del grid
		FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(gridExecuteCommandEventArgs);
    };
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) { //BeforeViewCreationCl QueryView: Borrowers
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) { //BeforeEnterLine QueryView: Borrowers
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.openFindCustomer(entities,gridABeforeEnterInLineRowEventArgs,{});
    };
	task.gridInitColumnTemplate.QV_BOREG0798_55 = function(idColumn) { //QueryView: Borrowers
		 if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC();
		}
	};
	task.change.VA_BORRWRVIEW2783_DTCC540 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.setDateCIC(changedEventArgs);
	};
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormApplicationCreditLine
    task.initData.VC_APPEI02_OPNRL_677 = function(entities, initDataEventArgs) {
		BUSIN.SYSTEM.importScript('OtherCreditData.js');
		BUSIN.SYSTEM.importScript('CreditBureau.js');
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.ValidationQuotaVsAvailableBalance.MaximumQuota = 0;
		entities.ValidationQuotaVsAvailableBalance.Rate = 0;
		entities.ValidationQuotaVsAvailableBalance.Term = 0;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringOne;
		entities.OriginalHeader.UserL=userL;
        entities.OriginalHeader.TypeRequest = 'P';
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		entities.Flag.flag = 0;
		var ts = initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.ETAPA;//taskSubject;
		if(ts === FLCRE.CONSTANTS.Stage.ImpresionDocumentos){
			entities.Flag.flag = 1;
		}
		//campo codigo actividad economica
		initDataEventArgs.commons.api.viewState.hide('VA_RIOTRDTAVI4904_EDSN666');
		initDataEventArgs.commons.api.viewState.show('VA_RIOTRDTAVI4904_RDTN715');
		//initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true);
		initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_RDTN715',true);


		if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
			task.RequestName = parentParameters.Task.urlParams.TRAMITE;
		}
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
			task.RequestStage = parentParameters.Task.urlParams.ETAPA;
		}
		entities.Context.RequestStage = task.RequestStage;
    };
	task.initDataCallback.VC_APPEI02_OPNRL_677 = function(entities, initDataEventArgs) {
        if(task.RequestStage===FLCRE.CONSTANTS.Stage.AnalisisOficial) {
			initDataEventArgs.commons.api.grid.showColumn ('QV_BOREG0798_55', 'DateCIC');
		}
	};

    //ViewContainer: FormApplicationCreditLine
    //ViewContainer: FormApplicationCreditLine
    task.render = function(entities, renderEventArgs) {
        var api = renderEventArgs.commons.api;
		var viewState = renderEventArgs.commons.api.viewState;
		var ts = renderEventArgs.commons.api.parentVc.customDialogParameters.Task.urlParams.ETAPA;//taskSubject;
        var ps = renderEventArgs.commons.api.parentVc.customDialogParameters.Task.processSubject;
		var parentApi = renderEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		viewState.disable('VA_APITONEAEE5511_RQSD053'); //Deshabilito el Código de Solicitud

		api.viewState.disable("CM_APPEI02TCI41");

		 if (entities.LineHeader.Sector === entities.IndexSizeActivity.ParameterFixedIncome) {
            entities.IndexSizeActivity.Patrimony = "";
            entities.IndexSizeActivity.PersonalNumber = "";
            entities.IndexSizeActivity.Sales = "";
            entities.IndexSizeActivity.IndexSizeActivity = "";
			var ctrs = ['VA_RIOTRDTAVI4909_ATRN190','VA_RIOTRDTAVI4909_SALE147','VA_RIOTRDTAVI4909_PESL753','VA_RIOTRDTAVI4909_NEIY699','VA_RIOTRDTAVI4909_NULE410','VA_RIOTRDTAVI4909_RCIE187'];
			BUSIN.API.disable(viewState,ctrs);
        }

		//se agrega la provincia
		viewState.show("VA_APITONEAEE5505_RVIC744");
		viewState.disable("VA_APITONEAEE5505_RVIC744");

		viewState.disable("GR_RIOTRDTAVI49_12");// Cuota Variable
		viewState.hide("GR_RIOTRDTAVI49_12");// Cuota Variable

		if(task.RequestStage === FLCRE.CONSTANTS.Stage.IngresoDeDatos || task.RequestStage === FLCRE.CONSTANTS.Stage.ValidaRequisitos || task.RequestStage === FLCRE.CONSTANTS.Stage.ConstanciaDeGravamen || task.RequestStage === FLCRE.CONSTANTS.Stage.ImpresionDocumentos || task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisOficial){
			viewState.disable("GR_RIOTRDTAVI49_09");
            if(task.RequestStage != FLCRE.CONSTANTS.Stage.AnalisisOficial){
                viewState.disable("GR_RIOTRDTAVI49_11");
                viewState.hide("GR_RIOTRDTAVI49_11");// Distribution Line
            }
			viewState.disable("GR_RIOTRDTAVI49_04");
			viewState.disable("GR_RIOTRDTAVI49_12");// Cuota Variable

		    viewState.hide("GR_RIOTRDTAVI49_12");// Cuota Variable
			if(task.RequestStage === FLCRE.CONSTANTS.Stage.ValidaRequisitos || task.RequestStage === FLCRE.CONSTANTS.Stage.ConstanciaDeGravamen || task.RequestStage === FLCRE.CONSTANTS.Stage.ImpresionDocumentos ){
				BUSIN.API.disable(viewState,['VA_APITONEAEE5506_OQUE114','VA_APITONEAEE5506_TERM631']);
			}
		}

		//MCA - Cuando es INGRESO DE DATOS y MODIFICACION LC PLAZO
        if(task.RequestStage === FLCRE.CONSTANTS.Stage.IngresoDeDatos && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo){
            entities.OriginalHeader.AmountRequested = entities.LineHeader.AmountProposed;
            viewState.disable('VA_APITONEAEE5506_OQUE114'); // Deshabilito Monto Solicitado
        }

	    //MCA - Cuando es INGRESO DE DATOS y MODIFICACION LC MONTO PLAZO  -- Cambio de lugar
		if(task.RequestStage === FLCRE.CONSTANTS.Stage.IngresoDeDatos && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo){
            //entities.OriginalHeader.AmountRequested = entities.LineHeader.AmountProposed;
            viewState.enable('VA_APITONEAEE5506_OQUE114'); // Habilito Monto solicitado
        }

        //Cuando es ANALISIS DEL OFICIAL y MODIFICACION LC PLAZO Y MONTO
        if(task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisOficial && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo){
            entities.OriginalHeader.AmountRequested = entities.LineHeader.AmountProposed;
            viewState.disable('VA_APITONEAEE5506_OQUE114'); // Deshabilito Monto Solicitado
			api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');  // para ocultar botones sobre las grillas
        }

		//Cuando es ANALISIS DEL OFICIAL y MODIFICACION LC PLAZO Y MONTO o MODIFICACION LC PLAZO
		if((task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisOficial && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo) ||
		   (task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisOficial && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo)){
			CREDITBUREAU.QUERYCENTRAL.validateLevelIndebtedness(entities, renderEventArgs, 'VA_RIOTRDTAVI4907_EDNE010');
			task.hideButtonIIRI(viewState);     //funcion para ocultar botones
            var ctrsS = ['VC_APPEI02_RUIRE_910'];
            BUSIN.API.show(viewState,ctrsS);	//Se visualiza Fuente de Ingresos Cliente y  Consulta Central
			viewState.enable("GR_RIOTRDTAVI49_09"); //Indice de Actividad
			viewState.hide('GR_RIOTRDTAVI49_13');
			viewState.hide('GR_RIOTRDTAVI49_04'); //se Oculta la pestaña Otros Datos de Credito
			api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');  // Ocultar el boton de nuevo sobre la grilla de distribucion de linea
			BUSIN.API.disable(viewState,['VA_APITONEAEE5506_OQUE114','GR_RIOTRDTAVI49_13','GR_RIOTRDTAVI49_04']);
			//Cuando es ANALISIS DEL OFICIAL y MODIFICACION LC PLAZO Y MONTO
			if( task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo){
				viewState.show('VA_APITONEAEE5506_AUPR372');
				viewState.enable('VA_APITONEAEE5506_AUPR372');
			}
        }else{
		    viewState.hide("GR_RIOTRDTAVI49_09"); //Indice de Actividad
		}

        //Cuando es ANALISIS LEGAL y MODIFICACION LC PLAZO o MODIFICACION LC PLAZO MONTO
        if(task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisLegal){
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			task.hideButtonIIRI(viewState);     //funcion para ocultar botones
            BUSIN.API.hide(viewState,['VC_APPEI02_RUIRE_910','CM_APPEI02PAO80']);	//Se oculta el boton continuar
            BUSIN.API.disable(viewState,['VA_APITONEAEE5506_OQUE114','VA_APITONEAEE5506_TERM631']);	//Se desabilita Código de Solicitud, monto,plazo
        }

		viewState.hide("GR_RIOTRDTAVI49_10");// Datos Variables

		//Oculto el VC de los documento siempre
		viewState.hide('VC_APPEI02_UNDCI_832');

        //Etapa de Analisis Oficial
		if(task.RequestStage != FLCRE.CONSTANTS.Stage.AnalisisOficial){
			task.hideButtonIIRI(viewState);     //funcion para ocultar botones
			viewState.hide("GR_RIOTRDTAVI49_09");
		}

		// Cuando es INGRESO DE DATOS y MODIFICACION LC MONTO PLAZO  o MODIFICACION LC PLAZO -- Cambio de lugar
		if((task.RequestStage === FLCRE.CONSTANTS.Stage.IngresoDeDatos && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo) ||
		   (task.RequestStage === FLCRE.CONSTANTS.Stage.IngresoDeDatos && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo)){
			var ctrsSB = ['CM_APPEI02EGC47','CM_APPEI02ORE38','CM_APPEI02TCI41'];//Visible botones: Impresión, Registro Infocred e impresión de Infocred
            BUSIN.API.show(viewState,ctrsSB);
			//Se oculta Fuente de Ingresos Cliente, Consulta Central y otros datos del crédito
            var ctrs = ['VC_APPEI02_RUIRE_910'];
            BUSIN.API.hide(viewState,ctrs);
        }

        //Modo Lectura para controles cuando este
        viewState.disable('VA_APITONEAEE5505_RTAY481');
        viewState.disable('VA_APITONEAEE5505_PROE367');
        viewState.disable('VA_APITONEAEE5505_TERM140');//Plazo
        viewState.disable('VA_APITONEAEE5505_NDTE867');
        viewState.disable('VA_APITONEAEE5505_XPIA086');
        viewState.disable('VA_APITONEAEE5505_OFIC220');
		viewState.disable('VA_APITONEAEE5505_SCTR004');
		viewState.disable('VA_APITONEAEE5505_ADSN125');
		viewState.disable('VA_APITONEAEE5506_IALT470');
		viewState.disable('VA_APITONEAEE5505_EPRO465');
		viewState.disable('VA_APITONEAEE5505_USED740');

        //Modo Lectura para Solicitud
        viewState.disable('VA_APITONEAEE5506_FICE377');
        //api.viewState.disable('VA_APITONEAEE5506_ITCE223');
		BUSIN.API.readOnlyAsync(renderEventArgs,['VA_APITONEAEE5506_ITCE223'],true,2000); //Para desabilitar destino geofrafico en explorer

		if(entities.OriginalHeader.IDRequested === null || angular.isUndefined(entities.OriginalHeader.IDRequested) || task.RequestStage === FLCRE.CONSTANTS.Stage.ImpresionDocumentos
		   || task.RequestStage === FLCRE.CONSTANTS.Stage.AnalisisLegal ){
			//Deshabilito los botones de crear nuevo de deudores
			api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
			api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		}else{
			api.grid.showToolBarButton('QV_BOREG0798_55', 'create');
			api.grid.showToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		}

        //Etapa constancia de Gravamen
		if(task.RequestStage === FLCRE.CONSTANTS.Stage.ConstanciaDeGravamen){
		    viewState.disable('VA_APITONEAEE5506_OQUE114');  //Monto
		    viewState.disable('VA_APITONEAEE5506_TERM631');  //Plazo
			task.hideButtonIIRI(viewState);     //funcion para ocultar botones

		    //Se oculta Fuente de Ingresos Cliente, Consulta Central y otros datos del crédito
		    var ctrs = ['GR_RIOTRDTAVI49_11'];
		    BUSIN.API.show(viewState,ctrs);

		    //para ocultar botones sobre las grillas
		    api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');
		    api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton Nuevo Seccion Deudores
		    api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton Eliminar Seccion Deudores
			viewState.hide('GR_RIOTRDTAVI49_13'); //Se oculta y deshabilita la Pestaña porcentaje de comision
			viewState.disable('GR_RIOTRDTAVI49_13');

		}

		//Cuando es ALTA CON/SIN GRAVAMEN de MODIFICACION LC PLAZO o es MODIFICACION LC MONTO Y PLAZO
		if((task.RequestStage === FLCRE.CONSTANTS.Stage.AltaCSGravamen && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo) ||
			(task.RequestStage === FLCRE.CONSTANTS.Stage.AltaCSGravamen && task.RequestName && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo)) {
			viewState.show('VA_APITONEAEE5505_NBTE960'); //se muestra el campo Numero de testimonio
			api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');
			viewState.enable('VA_APITONEAEE5505_NDTE867'); // Fecha de Ingreso
			task.disableFieldsAltaCSGravamen(viewState);
			api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton Nuevo Seccion Deudores
			api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton Eliminar Seccion Deudoresc
			viewState.hide('VA_APITONEAEE5506_IALT470'); // Fecha de Ingreso
			viewState.hide('GR_RIOTRDTAVI49_04'); //se Oculta la pestaña Otros Datos de Credito
			viewState.disable('GR_RIOTRDTAVI49_04');
        }

		//Cuando es ALTA CON/SIN GRAVAMEN de MODIFICACION LC PLAZO
		if(task.RequestStage === FLCRE.CONSTANTS.Stage.AltaCSGravamen && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo) {
			viewState.hide("GR_RIOTRDTAVI49_09"); //Indice de Actividad
        }

		//Cuando es ALTA CON/SIN GRAVAMEN de MODIFICACION LC MONTO Y PLAZO
		if(task.RequestStage === FLCRE.CONSTANTS.Stage.AltaCSGravamen && task.RequestName && task.RequestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo) {
			viewState.show("GR_RIOTRDTAVI49_09"); //Indice de Actividad
        }

		if(task.RequestStage === FLCRE.CONSTANTS.Stage.ImpresionDocumentos ){
			entities.Flag.flag = 1;
			viewState.show('VC_APPEI02_UNDCI_832');//VC de documentos
			viewState.show('CM_APPEI02TCI41');//IMprimir
			viewState.enable('CM_APPEI02TCI41');//IMprimir
			task.hideButtonImpresion(viewState);     //funcion para ocultar botones
			viewState.hide('GR_RIOTRDTAVI49_13');
			viewState.hide('VC_APPEI02_RUIRE_910');	//seccion viñetas
			viewState.disable('GR_RIOTRDTAVI49_13');
			$("#CM_APPEI02TCI41").removeClass('btn-default');
			$("#CM_APPEI02TCI41").addClass('btn-primary');
		}

		viewState.enable('VA_RIOTRDTAVI4904_TATT517');
		OTHERCREDITDATA.disableElements(entities, renderEventArgs,task.RequestName); // para deshabilitar si viene el sector vacio

		viewState.hide('GR_RIOTRDTAVI49_04'); //se Oculta la pestaña Otros Datos de Credito
		viewState.disable('GR_RIOTRDTAVI49_04');
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

	task.closeModalEvent.findCustomer = function (args) { //RESULTADO DE BUSQUEDA DE CLIENTE
		FLCRE.UTILS.CUSTOMER.addDebtorFromSearch(args,'C',true);
	};

	//QueryView: GridDocumentProduct
    task.gridInitColumnTemplate.QV_QDMNT8051_16 = function(idColumn) {
        if(idColumn === 'YesNot'){
			return "<input type=\'checkbox\' name=\'YesNot\' id=\'VA_DOCUNODCVW7303_YSNO533\' #if (YesNot === true) {# checked #}# ng-click=\"vc.grids.QV_QDMNT8051_16.events.customRowClick($event, \'VA_DOCUNODCVW7303_YSNO533\', \'DocumentProduct\', \'QV_QDMNT8051_16\')\"/>";
		}
    };

	//QueryView: GridDocumentProduct - Actualiza el Valor de la Entidad.
	task.gridRowCommand.VA_DOCUNODCVW7303_YSNO533 = function (entities, args) {
        args.commons.execServer = false;
		var index = args.rowIndex;
		for (var i = 0; i<=entities.DocumentProduct.data().length; i++) {
			if (i === index)
				entities.DocumentProduct.data()[i].YesNot = !entities.DocumentProduct.data()[i].YesNot;
		}
	};

	//RowSelecting QueryView: GridExpromissionOperations
    task.gridRowSelecting.QV_QDMNT8051_16 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };


	task.disableFieldsAltaCSGravamen= function(viewState) {
		var grps = ['VA_APITONEAEE5506_TERM631', // Plazo
					'VA_APITONEAEE5506_OQUE114',  // Monto Solicitado
					'GR_RIOTRDTAVI49_07', //Consulta Centrales
					'GR_RIOTRDTAVI49_04', //Otros Datos Credito
					'GR_RIOTRDTAVI49_09']; //Indice tamaño Actividad Principal
		BUSIN.API.disable(viewState,grps);
	};

    //Ocultar Imprimir, Registro Infocred,Imprimir Infocred
	task.hideButtonIIRI= function(viewState){
	    var grps = ['CM_APPEI02EGC47', // Registrar Infocred
					'CM_APPEI02ORE38', // Reporte infoCred
					'CM_APPEI02TCI41'] // Imprimir
	    BUSIN.API.hide(viewState,grps);
	};

	//Ocultar Imprimir, Registro Infocred,Imprimir Infocred
	task.hideButtonImpresion= function(viewState){
	    var grps = ['CM_APPEI02EGC47', // Registrar Infocred
					'CM_APPEI02ORE38', // Reporte infoCred
					'CM_APPEI02PAO80'] // Guardar
	    BUSIN.API.hide(viewState,grps);
	};

}());

function validateIndexSize(entities, args) {
    if (entities.LineHeader.Sector !== undefined && entities.LineHeader.Sector !== null && entities.LineHeader.Sector !== "") {
        if ((entities.IndexSizeActivity.Patrimony !== null && entities.IndexSizeActivity.Patrimony !== "") &&
            (entities.IndexSizeActivity.PersonalNumber !== null && entities.IndexSizeActivity.PersonalNumber !== "") &&
            (entities.IndexSizeActivity.Sales !== null && entities.IndexSizeActivity.Sales !== "")) {
            return true;
        } else {
            return false;
        }
    } else {
        var params = [cobis.translate('BUSIN.DLB_BUSIN_CUXVQJCMT_72827')];
        args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_DEBEESTAR_51364', params, null, false);
        return false;
    }
}
