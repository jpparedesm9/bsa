<!-- Designer Generator v 5.0.0.1508 - release SPR 2015-08 30/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.taskvalidationquotavsavailablebalance;

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

    //.Btn_Validate (Button) View: CreditOtherDataView
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
        var toValidate = entities.ValidationQuotaVsAvailableBalance;
        var toEvaluate = entities.PaymentCapacityHeader;
		if(BUSIN.VALIDATE.IsNullOrEmpty(toValidate.Rate) || BUSIN.VALIDATE.IsNullOrEmpty(toValidate.Term) ||
		   BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuota) || BUSIN.VALIDATE.IsNullOrEmpty(toValidate.MaximumQuotaLine) )
        {
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_CCKEMTFEL_83493');
            executeCommandEventArgs.commons.execServer = false;
			return;
        }
		//REALIZA LA VALIDACION DE 'CUOTA MAXIMA' Y 'CUOTA MAXIMA LINEA'
        if(!BUSIN.VALIDATE.IsNull(toEvaluate) && FINANCIALANALYSIS.hasValidItems(entities)){
			if(FINANCIALANALYSIS.isItemsFull(entities,executeCommandEventArgs,true)){
				executeCommandEventArgs.commons.execServer = true;
			}else{
				return;
			}
        }
    };

    task.executeCommandCallback.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
        BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
        if(executeCommandEventArgs.success){
            executeCommandEventArgs.commons.api.viewState.enable('CM_SVVAL50DIO73');
        }else{
            executeCommandEventArgs.commons.api.viewState.disable('CM_SVVAL50DIO73');
        }
		FINANCIALANALYSIS.formatPaymentCapacityTable(entities, executeCommandEventArgs, 'CM_SVVAL50DIO73');
    };

    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //LineHeader.CurrencyProposed (ComboBox) View: DistributionLineHeaderView
    task.change.VA_VIWLNEHADE4804_EPRO969 = function(entities, changedEventArgs) {
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

    //IndexSizeActivity.Patrimony (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //IndexSizeActivity.PersonalNumber (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //IndexSizeActivity.Sales (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //OriginalHeader.InitialDate (DateField) View: HeaderLineView
    task.change.VA_HEDELNEVIE1304_IALT942 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.AmountPurposed (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };

    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
    };

    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
		BUSIN.VALIDATE.IsGreaterThanZero(entities.ValidationQuotaVsAvailableBalance.MaximumQuota, changedEventArgs, false, true);
    };

    //Entity: LineHeader
    task.loadCatalog.VA_VIWLNEHADE4804_ADSN982 = function(loadCatalogDataEventArgs) {
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.LineHeader = true;
    }

    task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { //SectingDeudores QueryView: Borrowers
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //BtnSave (Button)
    task.executeCommand.CM_SVVAL50DIO73 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };
    task.executeCommandCallback.CM_SVVAL50DIO73 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //Botones en Distribucion de Linea
        task.disableButtonGrid(executeCommandEventArgs);
    };
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
    };

    //InsertingRow QueryView: GridDistributionLine
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //UpdateRow QueryView: GridDistributionLine
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //DeleteRow QueryView: GridDistributionLine
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormValidationQuotaVsAvailableBalance
    task.initData.VC_SVVAL50_FTBLA_532 = function(entities, initDataEventArgs) {
		BUSIN.SYSTEM.importScript('FinancialAnalysis.js');
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;//478;
        initDataEventArgs.commons.execServer = true;
        //campo codigo actividad economica
        initDataEventArgs.commons.api.viewState.hide('VA_RIOTRDTAVI4904_RDTN715');
        initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true);
		
		
    };

    task.initDataCallback.VC_SVVAL50_FTBLA_532 = function(entities, initDataCallbackEventArgs) {
        initDataCallbackEventArgs.commons.execServer = false;
        var parentParameters = initDataCallbackEventArgs.commons.api.parentVc.customDialogParameters;
        var viewState = initDataCallbackEventArgs.commons.api.viewState;

        /*Habilitacion de pestaña Validacion Cuota Vs. Saldo Disponible*/
        viewState.show('GR_RIOTRDTAVI49_12');
        viewState.focus('GR_RIOTRDTAVI49_12');

        /*Bloqueo de campos*/
        var ctrs = ['VA_HEDELNEVIE1304_URQT805','VA_HEDELNEVIE1304_OQUE778','VA_HEDELNEVIE1304_CRET710','VA_VIWLNEHADE4804_RTAY467',
                'VA_VIWLNEHADE4804_COMT755','VA_VIWLNEHADE4804_PROE708','VA_VIWLNEHADE4804_EPRO969','VA_VIWLNEHADE4804_AAUN561',
                'VA_VIWLNEHADE4804_SCTR177','VA_VIWLNEHADE4804_RVIC022','VA_VIWLNEHADE4804_ADSN982','VA_VIWLNEHADE4804_TERM000',
                'VA_RIOTRDTAVI4904_TATT517','VA_RIOTRDTAVI4904_RPPU470','VA_RIOTRDTAVI4904_RDTN715','VA_RIOTRDTAVI4904_EDSN666','VA_RIOTRDTAVI4904_OUED020', //Otros Datos de Credito
                'VA_RIOTRDTAVI4904_DSNS029',
                'VA_RIOTRDTAVI4909_ATRN190','VA_RIOTRDTAVI4909_SALE147','VA_RIOTRDTAVI4909_PESL753','VA_RIOTRDTAVI4909_NULE410', //Otros Indice Tamaño Actividad
                'VA_RIOTRDTAVI4909_RCIE187','VA_VIWLNEHADE4804_XPIA754'];
        BUSIN.API.disable(viewState,ctrs);

        //Botones Deudores
        initDataCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');//'CEQV_201_QV_TSRSE1342_26_253');
        initDataCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
        //Boton Distribucion de linea
        initDataCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');//'CEQV_201_QV_TSRSE1342_26_253');
        //Botones en Distribucion de Linea
        task.disableButtonGrid(initDataCallbackEventArgs)

        /*Validacion de Rotary para pestaña de Cuota Vs. Saldo Disponible*/
        if(entities.LineHeader.Rotary == "S"){
            viewState.disable("VA_RIOTRDTAVI4912_TERM010");
        }

		//Oculto la pestaña Otros Datos CreditOtherData
		viewState.hide("GR_RIOTRDTAVI49_04");
		viewState.disable("GR_RIOTRDTAVI49_04");

        if (parentParameters.Task.urlParams.ETAPA === FLCRE.CONSTANTS.Stage.QuotaVsBalanceAvailable && parentParameters.Task.urlParams.TRAMITE === FLCRE.CONSTANTS.RequestName.GuaranteesTicket){
            // Habilitar Campos para Garantias Bancarias.
            var ctrs = ['VA_HEDELNEVIE1304_NMLN229','VA_HEDELNEVIE1304_NRAK149','VA_HEDELNEVIE1304_UTIN581','VA_HEDELNEVIE1304_USRL557','GR_RIOTRDTAVI49_04','VA_VIWLNEHADE4804_XPIA754'];
            BUSIN.API.show(viewState,ctrs);
            BUSIN.API.disable(viewState,ctrs);

        }
        if(!initDataCallbackEventArgs.success){
            viewState.disable('VA_RIOTRDTAVI4912_0000847');
        }
    };

    task.render = function(entities, renderEventArgs) {
        BUSIN.API.disableAsync(renderEventArgs,['VA_VIWLNEHADE4804_ADSN982','VA_RIOTRDTAVI4904_RDTN715'],2500);
		//Deshabilita - Tasa y Cuota Maxima Linea
        BUSIN.API.disable(renderEventArgs.commons.api.viewState,['CM_SVVAL50DIO73','VA_RIOTRDTAVI4912_RATE281','VA_RIOTRDTAVI4912_IULI202']);
		BUSIN.API.hide(renderEventArgs.commons.api.viewState,['GR_RIOTRDTAVI49_10']);
		FINANCIALANALYSIS.formatPaymentCapacityTable(entities, renderEventArgs, 'CM_SVVAL50DIO73');
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
    task.disableButtonGrid = function(eventArgs){
        var ds = eventArgs.commons.api.vc.model['DistributionLine'];
        var dsData = ds.data();
        for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
            eventArgs.commons.api.grid.hideGridRowCommand('QV_QERIS7170_82', dsRow, 'edit');
            eventArgs.commons.api.grid.hideGridRowCommand('QV_QERIS7170_82', dsRow, 'delete');
        }
    };

}());