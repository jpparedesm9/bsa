<!-- Designer Generator v 5.0.0.1508 - release SPR 2015-08 30/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.creditlinedisbursementdataentry;

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_BENDT85_TISEY_946 = function(entities, initDataEventArgs) { //ViewContainer: FormCreditLineDisbursementDataEntry
		var parentVc = initDataEventArgs.commons.api.parentVc;

		entities.OriginalHeader.ApplicationNumber = parentVc.customDialogParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.OfficerName = cobis.userContext.getValue(cobis.constant.USER_FULLNAME);
		entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);

		var client = parentVc.model.Task;
		if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' && client.bussinessInformationStringOne !== '' ){
			entities.OriginalHeader.NumberLine = client.bussinessInformationStringOne;
		}
    };

	 task.initDataCallback.VC_BENDT85_TISEY_946 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.execServer = false;
	 };
    task.render = function(entities, renderEventArgs) { //ViewContainer: FormCreditLineDisbursementDataEntry
		BUSIN.API.GRID.hideFilter('QV_BOREG0798_55', renderEventArgs.commons.api);
		var viewState = renderEventArgs.commons.api.viewState;
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');

		var ctrs = ['VA_VIWLNEHADE4804_RTAY467','VA_VIWLNEHADE4804_COMT755','VA_VIWLNEHADE4804_PROE708','VA_VIWLNEHADE4804_EPRO969','VA_VIWLNEHADE4804_AAUN561',
				    'VA_VIWLNEHADE4804_NDTE084','VA_VIWLNEHADE4804_TERM000','VA_VIWLNEHADE4804_XPIA754','VA_VIWLNEHADE4804_OFIC643','VA_VIWLNEHADE4804_SCTR177'];
		BUSIN.API.hide(viewState,ctrs);
		viewState.show('VA_HEDRCRILIW9865_TERM240');
		viewState.enable('VA_HEDRCRILIW9865_TERM240');
    };

	//**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    task.executeCommand.CM_BENDT85CMA79 = function(entities, executeCommandEventArgs) { //CmdButonSave (Button)
		if( !task.validateQuota(entities.OriginalHeader, executeCommandEventArgs.commons) )
			executeCommandEventArgs.commons.execServer = false;
		if( !task.validateAmountRequested(entities.OriginalHeader, executeCommandEventArgs.commons) )
			executeCommandEventArgs.commons.execServer = false;
    };

	task.executeCommandCallback.CM_BENDT85CMA79 = function(entities, executeCommandCallbackEventArgs) {
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};

	 //SaveInfocred (Button)
    task.executeCommand.CM_BENDT85AER52 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };
	task.executeCommandCallback.CM_BENDT85AER52 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.openReentryWindowDebtor(entities.InfocredHeader,executeCommandEventArgs);
	};

	//Print (Button)
    task.executeCommand.CM_BENDT85PRN85 = function(entities, executeCommandEventArgs) {
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
    task.executeCommand.CM_BENDT85OIN92 = function(entities, executeCommandEventArgs) {
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };
	task.executeCommandCallback.CM_BENDT85OIN92 = function(entities, executeCommandCallbackEventArgs) {
		if(executeCommandCallbackEventArgs.success){
			FLCRE.UTILS.INFOCRED.getReportByCustomer(executeCommandCallbackEventArgs);
		}
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
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    task.change.VA_HEDRCRILIW9865_OQUE921 = function(entities, changedEventArgs) { //OriginalHeader.AmountRequested (TextInputBox) View: HeaderCreditLineView
        changedEventArgs.commons.execServer = false;
		task.validateAmountRequested(entities.OriginalHeader, changedEventArgs.commons);
    };
    task.change.VA_HEDRCRILIW9865_QUOA372 = function(entities, changedEventArgs) { //OriginalHeader.Quota (TextInputBox) View: HeaderCreditLineView
        changedEventArgs.commons.execServer = false;
		 if(entities.OriginalHeader.Quota===0){
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_GEDTTDCRO_41910'); //valida que la Cuota sea distinta de cero
		 }
		task.validateQuota(entities.OriginalHeader, changedEventArgs.commons);
    };
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) { //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
        changedEventArgs.commons.execServer = false;
    };
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) { //DebtorGeneral.Role (ComboBox) View: BorrowerView
        changedEventArgs.commons.execServer = false;
    };
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
     task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { //SectingDeudores QueryView: Borrowers
        gridRowSelectingEventArgs.commons.execServer = false;
    };
	task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) { //RowInserting QueryView: Borrowers
        gridRowInsertingEventArgs.commons.execServer = false;
    };
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) { //BeforeViewCreationCl QueryView: Borrowers
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };
	//BOTON NUEVO DEL GRID DE DEUDORES
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) { //BeforeEnterLine QueryView: Borrowers
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };
	//BOTON ELIMINAR DEL GRID DE DEUDORES
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) { //GridCommand (Button) QueryView: Borrowers
        gridExecuteCommandEventArgs.commons.execServer = false;
    };
	//**********************************************************
    //  FUNCIONES PERSONALIZADAS
    //**********************************************************
	task.validateQuota = function(OriginalHeader, commons) {
		if(OriginalHeader.Quota > OriginalHeader.AmountRequested ){
			commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_YETLSETDO_10126');
			return false;
		}
		return true;
    };
	task.validateAmountRequested = function(OriginalHeader, commons) {
		if(OriginalHeader.AmountRequested > OriginalHeader.AmountApproved ){
			commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MOAALDRON_83113');
			return false;
		}
		return true;
    };

}());