<!-- Designer Generator v 5.0.0.1504 - release SPR 2015-04 06/03/2015 -->
/*global designerEvents, console */
(function () {
    "use strict";

    var task = designerEvents.api.taskproductdistributionline;
	task.Etapa = '';
    var listCustomer = [];
	task.tramite = '';
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function (entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
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

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function (entities, changedEventArgs) {
    };

    //IndexSizeActivity.Patrimony (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function (entities, changedEventArgs) {
        if (validateIndexSize(entities, changedEventArgs)) {
            changedEventArgs.commons.execServer = true;
        } else {
            changedEventArgs.commons.execServer = false;
        }
    };

    //IndexSizeActivity.PersonalNumber (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_PESL753 = function (entities, changedEventArgs) {
        if (validateIndexSize(entities, changedEventArgs)) {
            changedEventArgs.commons.execServer = true;
        } else {
            changedEventArgs.commons.execServer = false;
        }
    };

    //IndexSizeActivity.Sales (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_SALE147 = function (entities, changedEventArgs) {
        if (validateIndexSize(entities, changedEventArgs)) {
            changedEventArgs.commons.execServer = true;
        } else {
            changedEventArgs.commons.execServer = false;
        }
    };

    //LineHeader.GeograohicDestination (ComboBox) View: DistributionLineHeaderView
    task.loadCatalog.VA_VIWLNEHADE4804_ADSN982 = function (loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.LineHeader = true;
    };

    //LineHeader.CurrencyProposed (ComboBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_EPRO969 = function (entities, changedEventArgs) {
        if (entities.LineHeader.AmountProposed) {
            changedEventArgs.commons.execServer = true;
        } else {
            changedEventArgs.commons.execServer = false;
        }
    };

    //LineHeader.AmountProposed (TextInputBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_PROE708 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

    //DistributionLine.AmountPurposed (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_AONO671 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function (loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_RITT092 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

    //DistributionLine.Currency (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

    //LineHeader.Sector (ComboBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_SCTR177 = function (entities, changedEventArgs) {
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
            changedEventArgs.commons.messageHandler.showMessagesInformation($("#VA_VIWLNEHADE4804_SCTR177").data("kendoExtComboBox").text());
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
        }
    };

    //OriginalHeader.AttIDRequested (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_RQSD386 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        if (entities.OriginalHeader.IDRequested == null || entities.OriginalHeader.IDRequested == "") {
            changeEventArgs.commons.execServer = false; //el mensaje de err no baja al svr
        }
    };

    //LineHeader.EntryDate (DateField) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_NDTE084 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

    //LineHeader.Term (TextInputBox) View: HeaderLineView
    task.change.VA_VIWLNEHADE4804_TERM000 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_RATE281 = function (entities, changedEventArgs) {
        if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Term) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.LineHeader.AmountProposed) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Rate) )
        {
			changedEventArgs.commons.execServer = BUSIN.VALIDATE.IsGreaterThanZero(entities.ValidationQuotaVsAvailableBalance.Rate, changedEventArgs, false, true);
        }else{
            changedEventArgs.commons.execServer = false;
        }
    };

    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_TERM010 = function (entities, changedEventArgs) {
        if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Term) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.LineHeader.AmountProposed) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Rate) )
        {
            changedEventArgs.commons.execServer = BUSIN.VALIDATE.IsGreaterThanZero(entities.ValidationQuotaVsAvailableBalance.Term, changedEventArgs, false, true);
		}else{
			changedEventArgs.commons.execServer = false;
		}
    };
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //CmdSave (Button)
    task.executeCommand.CM_TAKRR10DVE80 = function (entities, executeCommandEventArgs) {
		if( task.Etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial) {//EN ETAPA DE ANALISIS DEL OFICIAL VALIDA QUE ESTE LLENO EL CAMPO 'FECHA-CIC'
			if(!FLCRE.UTILS.CUSTOMER.hasDateCIC(entities,executeCommandEventArgs,true)){
				executeCommandEventArgs.commons.execServer = false;
				return;
			}
		}
    };

    task.executeCommandCallback.CM_TAKRR10DVE80 = function (entities, executeCommandCallbackEventArgs) { //Compute (Button)
        BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success, executeCommandCallbackEventArgs.commons.api);
        var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
        if (parentApi != undefined && executeCommandCallbackEventArgs.success) {
            var parentVc = parentApi.vc;
            parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }

    };
    //**********************************************************
    //  Eventos de QUERY VIEW
    //**********************************************************
    //QueryView: GridSourceRevenueCustomer
    task.gridInitDetailTemplate.QV_RURCE2364_74 = function (entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
        var nav = gridInitDetailTemplateArgs.commons.api.navigation;
        var api = gridInitDetailTemplateArgs.commons.api;
        nav.customDialogParameters = {};
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
    task.gridRowInserting.QV_BOREG0798_55 = function (entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
        var count = 0;
        for (var i = 0; i < entities.DebtorGeneral.data().length; i++) {
            var row = entities.DebtorGeneral.data()[i];
            if (row.CustomerCode == gridRowInsertingEventArgs.rowData.CustomerCode) {
                count++;
            }
        }
        if (count >= 2) {
            gridRowInsertingEventArgs.cancel = true;
            gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_BOWREDYXT_24458');
            gridRowInsertingEventArgs.commons.execServer = false;
        }
    };

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function (entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function (entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerCode');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerName');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Role');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'TypeDocumentId');
        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Identification');
        var nav = gridABeforeEnterInLineRowEventArgs.commons.api.navigation;

        nav.label = cobis.translate('BUSIN.DLB_BUSIN_CUOMREARH_28245');
        nav.customAddress = {
            id: "findCustomer",
            url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ["/customer/services/find-customers-srv.js", "/customer/controllers/find-customers-ctrl.js"]
		}];
        nav.customDialogParameters = {};
        nav.openCustomModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId, null);
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

    //InsertingRow QueryView: GridDistributionLine
    task.gridRowInserting.QV_QERIS7170_82 = function (entities, gridRowInsertingEventArgs) {
        if ((gridRowInsertingEventArgs.rowData.CreditType != null && gridRowInsertingEventArgs.rowData.CreditType != "") && (gridRowInsertingEventArgs.rowData.Module != null && gridRowInsertingEventArgs.rowData.Module != "") && gridRowInsertingEventArgs.rowData.Currency != null &&
            gridRowInsertingEventArgs.rowData.AmountProposed != 0 && gridRowInsertingEventArgs.rowData.AmountLocalCurrency != 0 && gridRowInsertingEventArgs.rowData.Quote != 0) {
            gridRowInsertingEventArgs.commons.execServer = true;
        } else {
            gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_VALIDATEO_88187');
            gridRowInsertingEventArgs.commons.execServer = false;
            gridRowInsertingEventArgs.cancel = true;
        }
    };

    //DeleteRow QueryView: GridDistributionLine
    task.gridRowDeleting.QV_QERIS7170_82 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
    };

    //UpdateRow QueryView: GridDistributionLine
    task.gridRowUpdating.QV_QERIS7170_82 = function (entities, gridRowUpdatingEventArgs) {
        if ((gridRowUpdatingEventArgs.rowData.CreditType != null && gridRowUpdatingEventArgs.rowData.CreditType != "") && (gridRowUpdatingEventArgs.rowData.Module != null && gridRowUpdatingEventArgs.rowData.Module != "") && gridRowUpdatingEventArgs.rowData.Currency != null &&
            gridRowUpdatingEventArgs.rowData.AmountProposed != 0 && gridRowUpdatingEventArgs.rowData.AmountLocalCurrency != 0 && gridRowUpdatingEventArgs.rowData.Quote != 0) {
            //VALIDAR QUE MONTO LOCAL SEA MENOR QUE LA SUMATORIA DE LINEAS
            gridRowUpdatingEventArgs.commons.execServer = true;
        } else {
            gridRowUpdatingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_VALIDATEO_88187');
            gridRowUpdatingEventArgs.commons.execServer = false;
        }
    };



    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function (entities, gridExecuteCommandEventArgs) {
        var selectedRow = gridExecuteCommandEventArgs.commons.api.grid.getSelectedRows('QV_BOREG0798_55');
        if (selectedRow[0] == undefined) {
            gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_BRRORSLEC_35032');
        } else {
            if (selectedRow[0].Role == 'D') {
                gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_EOECIPLOR_93728');
            } else {
                gridExecuteCommandEventArgs.commons.api.grid.removeRowByDsgnrId('DebtorGeneral', selectedRow[0]);
            }
        }
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

    task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var row = args.model.DebtorGeneral.data()[0];
        row.set('CustomerCode', args.commons.api.vc.dialogParameters.CodeReceive);
        if (args.commons.api.vc.dialogParameters.commercialName !== '') {
            row.set('CustomerName', args.commons.api.vc.dialogParameters.commercialName);
        } else {
            row.set('CustomerName', args.commons.api.vc.dialogParameters.name);
        }
        row.set('Role', 'C');
        row.set('TypeDocumentId', args.commons.api.vc.dialogParameters.documentType);
        row.set('Identification', args.commons.api.vc.dialogParameters.documentId);
    };
    //CommandNew (Button) QueryView: GridSourceRevenueCustomer
    task.gridCommand.CEQV_201_QV_RURCE2364_74_651 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        var api = gridExecuteCommandEventArgs.commons.api;
        api.grid.addRow('SourceRevenueCustomer', {
            Type: 'Nuevo',
            Sector: ' ',
            SubSector: ' ',
            EconomicActivity: ' '
        });
        var dsData = api.vc.model['SourceRevenueCustomer'].data();
        var dsRow = dsData[dsData.length - 1];
        var uigrid = $('#' + 'QV_RURCE2364_74').data('kendoGrid');
        uigrid.expandRow($("[data-uid=\'" + dsRow.uid + "\']"));
    };


    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormDistributionLine
    task.initData.VC_TAKRR10_DIILN_979 = function (entities, initDataEventArgs) {
		BUSIN.SYSTEM.importScript('OtherCreditData.js');
		BUSIN.SYSTEM.importScript('CreditBureau.js');
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
        initDataEventArgs.commons.api.viewState.label("VA_VIWLNEHADE4804_SCTR177", "BUSIN.DLB_BUSIN_ECORCIVDA_03835");

        initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
        initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
        initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');

		//campo codigo actividad economica
        initDataEventArgs.commons.api.viewState.hide('VA_RIOTRDTAVI4904_EDSN666'); //se oculta Actividad destinar credito x busqueda
        initDataEventArgs.commons.api.viewState.show('VA_RIOTRDTAVI4904_RDTN715'); //se visualiza Actividad destinar credito combo
		//initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true);
		initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_RDTN715',true);

        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		task.tramite = parentParameters.Task.urlParams.TRAMITE;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
        initDataEventArgs.commons.execServer = true;

        // Deshabilitando validacion de campos requeridos en pestaña oculta Validacion de Cuota Vs. Saldo Disponible
        var api = initDataEventArgs.commons.api;
        api.viewState.disableValidation('VA_RIOTRDTAVI4912_MAMU147', VisualValidationTypeEnum.Required);
        api.viewState.disableValidation('VA_RIOTRDTAVI4912_RATE281', VisualValidationTypeEnum.Required);
        api.viewState.disableValidation('VA_RIOTRDTAVI4912_TERM010', VisualValidationTypeEnum.Required);

		if(!BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.urlParams.ETAPA)){
			task.Etapa = parentParameters.Task.urlParams.ETAPA;
		}else if(!BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.taskSubject) &&  parentParameters.Task.taskSubject==='ANALISIS DEL OFICIAL'){
			task.Etapa = FLCRE.CONSTANTS.Stage.AnalisisOficial;
		}
		entities.Context.RequestStage = task.Etapa;
    };
    task.initDataCallback.VC_TAKRR10_DIILN_979 = function(entities, initDataEventArgs) {
		if(initDataEventArgs.success) {
			if( task.Etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial) {
				initDataEventArgs.commons.api.grid.showColumn ('QV_BOREG0798_55', 'DateCIC');
			}
		}
	};
    //ViewContainer: FormDistributionLine
    task.render = function (entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
        if (entities.LineHeader.Sector === entities.IndexSizeActivity.ParameterFixedIncome) {
            entities.IndexSizeActivity.Patrimony = "";
            entities.IndexSizeActivity.PersonalNumber = "";
            entities.IndexSizeActivity.Sales = "";
            entities.IndexSizeActivity.IndexSizeActivity = "";
            renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_ATRN190");
            renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_SALE147");
            renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_PESL753");
            renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NEIY699");
            renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NULE410");
            renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_RCIE187");
        }
        renderEventArgs.commons.api.viewState.hide("GR_RIOTRDTAVI49_10"); //pestaña variable data
        renderEventArgs.commons.api.viewState.disable("VA_VIWLNEHADE4804_AAUN561"); // monto moneda local
        renderEventArgs.commons.api.viewState.disable("VA_HEDELNEVIE1304_OQUE778");
        renderEventArgs.commons.api.viewState.disable("VA_HEDELNEVIE1304_URQT805");
        renderEventArgs.commons.api.viewState.disable("VA_HEDELNEVIE1304_CRET710");
        renderEventArgs.commons.api.viewState.enable("VA_VIWLNEHADE4804_NDTE084"); //"VA_HEDELNEVIE1304_IALT942"); //fecha ingreso
        //metodo para habilitar desabilitar los campos

		// Cuando es la etapa de ALTA CON SIN GRAVAMEN
		if(task.Etapa === FLCRE.CONSTANTS.Stage.AltaCSGravamen){
			renderEventArgs.commons.api.viewState.show("VA_VIWLNEHADE4804_NBTE204"); //Numero de Testimonio
			renderEventArgs.commons.api.grid.hideToolBarButton('QV_QERIS7170_82', 'create'); //desabilitar el boton de la grilla de Distribucion de Linea
            renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); // Ocultar de deudores iNGRESO
            renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); // Ocultar de deudores Eliminar
			BUSIN.API.readOnlyAsync(renderEventArgs,['VA_VIWLNEHADE4804_ADSN982'],true,2000); //Para desabilitar destino geofrafico en explorer
			//Oculto la pestaña Otros datos Credito
			renderEventArgs.commons.api.viewState.hide('GR_RIOTRDTAVI49_04');
			renderEventArgs.commons.api.viewState.disable('GR_RIOTRDTAVI49_04');
		}

		// Cuando es la etapa de Analisis del Oficial
		if(task.Etapa === FLCRE.CONSTANTS.Stage.AnalisisOficial){
            renderEventArgs.commons.api.viewState.enable("VA_VIWLNEHADE4804_SCTR177"); //Se habilita porque Otros Datos del Credito no debe ir en esta etapa
			CREDITBUREAU.QUERYCENTRAL.validateLevelIndebtedness(entities, renderEventArgs, 'VA_RIOTRDTAVI4907_EDNE010' );
			//Oculto la pestaña Otros datos Credito
			renderEventArgs.commons.api.viewState.hide('GR_RIOTRDTAVI49_04');
			renderEventArgs.commons.api.viewState.disable('GR_RIOTRDTAVI49_04');
		}else{
            renderEventArgs.commons.api.viewState.disable("VA_VIWLNEHADE4804_SCTR177");
		}

        task.disableControls(entities.OriginalHeader, renderEventArgs.commons.api);
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

    task.disableControls = function (originalHeader, api) {
        if (originalHeader.OpNumberBank != undefined) {
            //desabilito controles
            api.viewState.disable('VC_TAKRR10_RDIRE_658');
            api.viewState.disable('VA_VIWLNEHADE4804_RTAY467');
            api.viewState.disable('VA_HEDELNEVIE1304_IALT942');
            api.viewState.addStyle('QV_QERIS7170_82', 'grupo-lectura'); //se quitan los botones de editar y eliminar de la grilla
            api.viewState.enable('VA_VIWLNEHADE4804_NDTE084'); //se habilita el campo fecha de ingreso
			api.viewState.enable('VA_VIWLNEHADE4804_NBTE204'); //////
            api.viewState.disable('VC_TAKRR10_ROFIL_332');
            api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');
            api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
            api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
        }
    };

}());

DebtorGeneral = function (idClient, name, role, idType, idNumber) {
    this.CustomerCode = idClient;
    this.CustomerName = name;
    this.Role = role;
    this.TypeDocumentId = idType;
    this.Identification = idNumber;
};

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