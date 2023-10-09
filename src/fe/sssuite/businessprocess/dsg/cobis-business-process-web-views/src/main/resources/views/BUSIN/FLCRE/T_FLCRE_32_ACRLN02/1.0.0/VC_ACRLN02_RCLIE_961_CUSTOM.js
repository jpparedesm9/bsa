<!-- Designer Generator v 5.0.0.1504 - release SPR 2015-04 06/03/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.taskcreditline;
	var listCustomer = [];
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

    //LineHeader.CurrencyProposed (ComboBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_EPRO969 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.EntryDate (DateField) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_NDTE084 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.AmountProposed (TextInputBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_PROE708 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.Sector (ComboBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_SCTR177 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.Term (TextInputBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_TERM000 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.GeograohicDestination (ComboBox) View: DistributionLineHeaderView
    task.loadCatalog.VA_VIWLNEHADE4804_ADSN982 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.LineHeader = true;
    };
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //CmdButonSave (Button)
    task.executeCommand.CM_ACRLN02TVE12 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };

	task.executeCommandCallback.CM_ACRLN02TVE12 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();

		if(parentApi != undefined && executeCommandCallbackEventArgs.success){
		  var parentVc = parentApi.vc;
		  parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}

	};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        // gridRowInsertingEventArgs.commons.execServer = false;

		gridRowInsertingEventArgs.commons.execServer = false;

        var count = 0;
        for (var i = 0; i < entities.DebtorGeneral.data().length; i++) {
            var row = entities.DebtorGeneral.data()[i];
            if(row.CustomerCode ==  gridRowInsertingEventArgs.rowData.CustomerCode){
                count++;
            }
        }
        if(count >= 2){
            gridRowInsertingEventArgs.cancel= true;
			gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_BOWREDYXT_24458');
            gridRowInsertingEventArgs.commons.execServer = false;
        }
    };

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;

		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerCode');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerName');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Role');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'TypeDocumentId');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Identification');
		//gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Qualification'); /*ACH*/
		var nav = gridABeforeEnterInLineRowEventArgs.commons.api.navigation;

		nav.label =cobis.translate('BUSIN.DLB_BUSIN_BUSUEDENS_08610');
		nav.customAddress = {
			id: "findCustomer",
			url: "customer/templates/find-customers-tpl.html"
		};
		nav.modalProperties = {
			size: 'lg'
		};
		nav.scripts = [{
			module: cobis.modules.CUSTOMER,
			files: ["/customer/services/find-customers-srv.js",
				 "/customer/controllers/find-customers-ctrl.js"]
		 }];

		nav.customDialogParameters = {
		};
		nav.openCustomModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId, null);
    };

    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;

		var selectedRow = gridExecuteCommandEventArgs.commons.api.grid.getSelectedRows('QV_BOREG0798_55');
		if(selectedRow[0] == undefined){
			gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_BRRORSLEC_35032');
		}else{
			if(selectedRow[0].Role ==  'D'){
			gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_EOECIPLOR_93728');
			}
			else{
				gridExecuteCommandEventArgs.commons.api.grid.removeRowByDsgnrId('DebtorGeneral',selectedRow[0]);
			}
		}
		gridExecuteCommandEventArgs.commons.execServer = false;
    };

	task.closeModalEvent.findCustomer = function (args) {
		var resp = args.commons.api.vc.dialogParameters;
		var row = args.model.DebtorGeneral.data()[0];

			row.set('CustomerCode',  args.commons.api.vc.dialogParameters.CodeReceive);
			if(args.commons.api.vc.dialogParameters.commercialName !== ''){
				row.set('CustomerName',  args.commons.api.vc.dialogParameters.commercialName);
			}
			else{
				row.set('CustomerName',  args.commons.api.vc.dialogParameters.name);
			}

			row.set('Role',  'C');
			row.set('TypeDocumentId', args.commons.api.vc.dialogParameters.documentType);
			row.set('Identification', args.commons.api.vc.dialogParameters.documentId);
			row.set('Qualification', args.commons.api.vc.dialogParameters.califCartera); /*ACH*/

	};

	 //CmdNewEvent (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_300 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;

		gridExecuteCommandEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerCode');
		gridExecuteCommandEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerName');
		gridExecuteCommandEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Role');
		gridExecuteCommandEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'TypeDocumentId');
		gridExecuteCommandEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Identification');
		var nav = gridExecuteCommandEventArgs.commons.api.navigation;

		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CUOMREARH_28245');
		nav.customAddress = {
			id: "findCustomer",
			url: "customer/templates/find-customers-tpl.html"
		};
		nav.modalProperties = {
			size: 'lg'
		};
		nav.scripts = [{
			module: cobis.modules.CUSTOMER,
			files: ["/customer/services/find-customers-srv.js",
				 "/customer/controllers/find-customers-ctrl.js"]
		 }];

		nav.customDialogParameters = {
		};
		nav.openCustomModalWindow(gridExecuteCommandEventArgs.commons.controlId, null);
    };
	 task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { //SectingDeudores QueryView: Borrowers
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormCreditLine
    task.initData.VC_ACRLN02_RCLIE_961 = function(entities, initDataEventArgs) {
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
		var ctrs = [];
		var viewState = initDataEventArgs.commons.api.viewState;
		ctrs = ['VA_VIWLNEHADE4804_RTAY467','VA_VIWLNEHADE4804_COMT755','VA_VIWLNEHADE4804_PROE708','VA_VIWLNEHADE4804_EPRO969','VA_VIWLNEHADE4804_AAUN561',
				'VA_VIWLNEHADE4804_NDTE084','VA_VIWLNEHADE4804_XPIA754','VA_VIWLNEHADE4804_OFIC643','VA_VIWLNEHADE4804_SCTR177'];
		BUSIN.API.hide(viewState,ctrs);

		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');
		//initDataEventArgs.commons.api.viewState.hide("VA_HEDELNEVIE1304_NQUE518");//plazo	-- ach
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.UserL=userL;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.clientId != 0 && client.clientId != undefined && client.clientId != ''){
			var client = initDataEventArgs.commons.api.parentVc.model.Task;
			var cust = new DebtorGeneral(client.clientId,client.clientName, 'D', '');
			listCustomer.push(cust);
			initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
			entities.OriginalHeader.ClientCode=client.clientId;
		}else{
			initDataEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_PNOTSBORW_04809');
			}

				//se muestra en ingreso de datos la frecuencia de pago y la cuota
			var viewState = initDataEventArgs.commons.api.viewState;
			ctrs = ['VA_ORIAHEADER8602_NQUE773','VA_ORIAHEADER8602_QUOA306'];
			//BUSIN.API.show(viewState,ctrs);

		initDataEventArgs.commons.execServer = true;
    };

	//ach
	//SaveInfocred (Button)
    task.executeCommand.CM_ACRLN02CDC89 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
	};
	task.executeCommandCallback.CM_ACRLN02CDC89 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.openReentryWindowDebtor(entities.InfocredHeader,executeCommandEventArgs);
	};

	    //Imprimir (Button)
	task.executeCommand.CM_ACRLN02CDI71 = function(entities, executeCommandEventArgs){
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
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_NMRREEUID_75532');
		   }
		}
		else {
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SAOUCENTD_07389');
		}
	};

	 //ReportInfocred (Button)
    task.executeCommand.CM_ACRLN02INO48 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
	};
	task.executeCommandCallback.CM_ACRLN02INO48 = function(entities, executeCommandCallbackEventArgs) {
		if(executeCommandCallbackEventArgs.success){
			FLCRE.UTILS.INFOCRED.getReportByCustomer(executeCommandCallbackEventArgs);
		}
	};
}());

DebtorGeneral = function (idClient, name, role, idType, idNumber){
    this.CustomerCode = idClient;
    this.CustomerName = name;
    this.Role = role;
	this.TypeDocumentId = idType;
    this.Identification = idNumber;
	};