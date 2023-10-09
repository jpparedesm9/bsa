<!-- Designer Generator v 5.0.0.1508 - release SPR 2015-08 30/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.taskrevolvingcreditline;

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

    //Entity:
    //.Btn_Validate (Button) View: ApproveCreditRequest
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
    };

    //Entity: CustomerReference
    //CustomerReference.Result (CheckBox) View: CustomerReferenceView
    //task.VA_USTMRENCVW3903_0000448 = function() {};

    //Entity: DebtorGeneral
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Patrimony (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.PersonalNumber (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Sales (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.AmountPurposed (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.Currency (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

	task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

	task.loadCatalog.VA_RIOTRDTAVI4904_TATT517 = function(loadCatalogDataEventArgs) {
	    loadCatalogDataEventArgs.commons.execServer = false;
	};

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: LineHeader
    //LineHeader.CurrencyProposed (ComboBox) View: DistributionLineHeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VIWLNEHADE4804_EPRO969 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: LineHeader
    //LineHeader.EntryDate (DateField) View: DistributionLineHeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VIWLNEHADE4804_NDTE084 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: LineHeader
    //LineHeader.AmountProposed (TextInputBox) View: DistributionLineHeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VIWLNEHADE4804_PROE708 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: LineHeader
    //LineHeader.Sector (ComboBox) View: DistributionLineHeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VIWLNEHADE4804_SCTR177 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: LineHeader
    //LineHeader.Term (TextInputBox) View: DistributionLineHeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VIWLNEHADE4804_TERM000 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //OriginalHeader.InitialDate (DateField) View: HeaderLineView
    task.change.VA_HEDELNEVIE1304_IALT942 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

	//Entity: LineHeader
	task.loadCatalog.VA_VIWLNEHADE4804_ADSN982 = function(loadCatalogDataEventArgs) {
	    var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
	    serverParameters.LineHeader = true;
    }

    //CustomerReference.Result (CheckBox) View: CustomerReferenceView
  //  task..VA_USTMRENCVW3903_0000448 = function() {};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        // gridRowInsertingEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //UpdateRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //RowUpdating QueryView: GridVariableData
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_QUERV3248_81 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //DeleteRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        // gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //SELECTING QueryView: GridCustomerReference
    task.gridRowSelecting.QV_QURRF6164_42 = function(entities, gridRowSelectingEventArgs) {
        // gridRowSelectingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //SectingDeudores QueryView: Borrowers
    task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormRevolvingCreditLine
    task.initData.VC_LNRDT96_FRNDN_247 = function(entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
     	var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.UserL=userL;
		entities.myParameters ={
			isProrroga : initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.bussinessInformationStringTwo=='P'?true:false,
			lineNumber : initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.bussinessInformationStringOne
		}

		initDataEventArgs.commons.api.viewState.enable("VA_VIWLNEHADE4804_COMT755");

		var ctrs = ['VA_HEDELNEVIE1304_OQUE778','VA_HEDELNEVIE1304_URQT805','VA_HEDELNEVIE1304_CRET710','VA_VIWLNEHADE4804_PROE708',
					'VA_VIWLNEHADE4804_EPRO969','VA_VIWLNEHADE4804_AAUN561','VA_VIWLNEHADE4804_SCTR177','VA_VIWLNEHADE4804_RVIC022',
					'VA_VIWLNEHADE4804_ADSN982','VA_VIWLNEHADE4804_TERM000','VA_VIWLNEHADE4804_RTAY467','VA_VIWLNEHADE4804_COMT755'];
		BUSIN.API.disable(initDataEventArgs.commons.api.viewState,ctrs);

		//campo codigo actividad economica
		initDataEventArgs.commons.api.viewState.hide('VA_RIOTRDTAVI4904_RDTN715');
		initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true);
    };

	 task.initDataCallback.VC_LNRDT96_FRNDN_247 = function(entities, initDataEventArgs) {
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var ds = initDataEventArgs.commons.api.vc.model['CustomerReference'];
		var dsData = ds.data();
		var flag=0;

		for (var i = 0; i < dsData.length; i ++) {
			var dsRow = dsData[i];
			if(dsRow.Result ==='0'){
				flag=1;
				break;
			}
		}

		if(parentApi != undefined && flag===0){
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = 'YES';
		}
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
    };

    task.render = function(entities, renderEventArgs) { //ViewContainer: FormRevolvingCreditLine
		BUSIN.API.disableAsync(renderEventArgs,['VA_VIWLNEHADE4804_ADSN982'],1500);

		renderEventArgs.commons.api.viewState.hide('GR_RIOTRDTAVI49_07');
		renderEventArgs.commons.api.viewState.hide('GR_RIOTRDTAVI49_04');
		renderEventArgs.commons.api.viewState.hide('GR_RIOTRDTAVI49_09');
		renderEventArgs.commons.api.viewState.hide('GR_RIOTRDTAVI49_10');
		renderEventArgs.commons.api.viewState.hide('GR_RIOTRDTAVI49_11');

		BUSIN.API.GROUP.selectTab('GR_RIOTRDTAVI49_03', 1, renderEventArgs.commons.api);
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

}());