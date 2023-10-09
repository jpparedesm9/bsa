<!-- Designer Generator v 5.0.0.1515 - release SPR 2015-15 07/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.tguaranteesticket;
	task.Source = '';
	task.Etapa = '';

	var listCustomer = [];

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

    //Entity: DebtorGeneral
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Patrimony (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.PersonalNumber (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Sales (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.AmountPurposed (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.Currency (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

	 //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6809_EEAR819 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;

    };

	//Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
		var grid = changedEventArgs.commons.api.grid;
		// Para HErencia de deudores y Codeudores cuando es con Linea de Credito.
		if(entities.HeaderGuaranteesTicket.CreditLineDistrib === null){			
			FLCRE.UTILS.CUSTOMER.deleteCoDebtor(entities.DebtorGeneral, changedEventArgs)
			grid.showToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
			grid.showToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
		}else{				
			grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
			grid.hideToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
		}
    };

	task.changeCallback.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
		var api = changedEventArgs.commons.api;
		if(changedEventArgs.success == false){
			api.viewState.disable('CM_KARAI97SVE03');
		}else{
			api.viewState.enable('CM_KARAI97SVE03');
		}
    };
	    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_IEWGUARNTK6806_LIES496 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;
		loadCatalogDataEventArgs.commons.execServer = true;

    };

	 //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CurrencyRequested (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_RRQE376 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

	task.changeCallback.VA_IEWGUARNTK6806_RRQE376 = function(entities, changedEventArgs) {
		var api = changedEventArgs.commons.api;
		if(changedEventArgs.success == false){
			api.viewState.disable('CM_KARAI97SVE03');
		}else{
			api.viewState.enable('CM_KARAI97SVE03');
		}
	}


	 //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.AmountRequested (TextInputBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_TREU555 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		var api = changedEventArgs.commons.api;
		if(entities.HeaderGuaranteesTicket.AmountRequested <= 0){
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_EVAONEOIE_91106');
			api.viewState.disable('CM_KARAI97SVE03');
		}else{
			api.viewState.enable('CM_KARAI97SVE03');
		}

    };

	  //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.RequestedTermInDays (TextInputBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_EUER032 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		var api = changedEventArgs.commons.api;
		/*if(entities.HeaderGuaranteesTicket.RequestedTermInDays <=0){
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_EVAONEOIE_91106');
			api.viewState.disable('CM_KARAI97SVE03');
		}else{
			api.viewState.enable('CM_KARAI97SVE03');
		}*/
    };

	  //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.DateFrom (DateField) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_ATRO527 = function(entities, changedEventArgs) {
		var api = changedEventArgs.commons.api;
		var from = entities.HeaderGuaranteesTicket.FromDate;
		var to = entities.HeaderGuaranteesTicket.ExpirationDate;

		if(Date.parse(from) > Date.parse(to)){
		   changedEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_FNOPENCEN_51790');
		   api.viewState.disable('CM_KARAI97SVE03');
		   entities.HeaderGuaranteesTicket.RequestedTermInDays = 0;
		   changedEventArgs.commons.execServer = false;
		}
		else{
		   if(Date.parse(to) != null){
				api.viewState.enable('CM_KARAI97SVE03');
				changedEventArgs.commons.execServer = true;
		   }

		}



    };
	task.changeCallback.VA_IEWGUARNTK6806_ATRO527 = function(entities, changedEventArgs) {
        var api = changedEventArgs.commons.api;
		if(changedEventArgs.success == false){
			api.viewState.disable('CM_KARAI97SVE03');

			if(entities.OriginalHeader.IDRequested== null || entities.OriginalHeader.IDRequested == undefined){
				entities.HeaderGuaranteesTicket.DateFrom = '';
				entities.HeaderGuaranteesTicket.ExpirationDate = '';
			}
		}else{
			api.viewState.enable('CM_KARAI97SVE03');
		}

    };

	  //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.ExpirationDate (DateField) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_POTE119 = function(entities, changedEventArgs) {
        //changedEventArgs.commons.execServer = true;
		var api = changedEventArgs.commons.api;
		var from = entities.HeaderGuaranteesTicket.FromDate;
		var to = entities.HeaderGuaranteesTicket.ExpirationDate;

		if(Date.parse(from) > Date.parse(to)){
		   changedEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_ENOEEHGES_25772');
		   api.viewState.disable('CM_KARAI97SVE03');
		   entities.HeaderGuaranteesTicket.RequestedTermInDays = 0;
		   changedEventArgs.commons.execServer = false;
		}
		else{
			 if(Date.parse(from) != null){
				api.viewState.enable('CM_KARAI97SVE03');
				changedEventArgs.commons.execServer = true;
			}
		}


    };
	 task.changeCallback.VA_IEWGUARNTK6806_POTE119 = function(entities, changedEventArgs) {
         var api = changedEventArgs.commons.api;
		if(changedEventArgs.success == false){
			api.viewState.disable('CM_KARAI97SVE03');
		}else{
			api.viewState.enable('CM_KARAI97SVE03');
		}
    };


    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

	 //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.WarrantyType (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_IEWGUARNTK6806_WNTP122 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;

    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CustomerAddress (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto.
	task.textInputButtonEvent.VA_IEWGUARNTK6807_TORR665 = function(textInputButtonEventArgs) {

        textInputButtonEventArgs.commons.execServer = false;

		var client = textInputButtonEventArgs.commons.api.parentVc.model.Task;

		task.Source = 'VA_IEWGUARNTK6807_TORR665';
		var nav = FLCRE.API.getApiNavigation(textInputButtonEventArgs,'T_FLCRE_33_TRESS53','VC_TRESS53_ADRES_308');
		//nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
		nav.modalProperties = {
	          size: 'lg'
		};
		//nav.queryParameters = { mode: textInputButtonEventArgs.commons.constants.mode.Update };
		nav.queryParameters = {
			mode: textInputButtonEventArgs.commons.constants.mode.Search
		};
		nav.customDialogParameters = {

			Cliente : client

		};
		//nav.openModalWindow(textInputButtonEventArgs.commons.controlId);
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto.
    // task.textInputButtonEvent.VA_IEWGUARNTK6809_EEAR819 = function(textInputButtonEventArgs) {
    //     textInputButtonEventArgs.commons.execServer = false;
    //};

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    task.textInputButtonEvent.VA_IEWGUARNTK6809_EEAR819 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
		task.Source = 'VA_IEWGUARNTK6809_EEAR819';
        var nav = textInputButtonEventArgs.commons.api.navigation;

		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CTMESERCH_53064');
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
										//"/customer/services/find-program-srv.js",
										"/customer/controllers/find-customers-ctrl.js"]
		}];

		nav.customDialogParameters = {

		};
    };
	task.closeModalEvent.findCustomer = function (args){
	if (task.Source === 'VA_IEWGUARNTK6809_EEAR819'){
		var resp = args.commons.api.vc.dialogParameters;
		var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
		var CustomerName=  args.commons.api.vc.dialogParameters.customerType ==='C'?args.commons.api.vc.dialogParameters.commercialName:args.commons.api.vc.dialogParameters.name;
		var identification= args.commons.api.vc.dialogParameters.documentId;
		//args.model.HeaderGuaranteesTicket.NameBeneficiary = customerCode +"-"+ CustomerName;
		args.model.HeaderGuaranteesTicket.BeneficiaryName  = customerCode +"-"+ CustomerName;
		args.model.HeaderGuaranteesTicket.BeneficiaryId  = customerCode;

	}else if(task.Source === 'QV_BOREG0798_55'){
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
		row.set('Qualification', args.commons.api.vc.dialogParameters.califCartera);
	}

    };
    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.AddressBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto.
	task.textInputButtonEvent.VA_IEWGUARNTK6809_SNCI435 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
		task.Source = 'VA_IEWGUARNTK6809_SNCI435';
		var nav = FLCRE.API.getApiNavigation(textInputButtonEventArgs,'T_FLCRE_33_TRESS53','VC_TRESS53_ADRES_308');
		//nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
		nav.modalProperties = {
	          size: 'lg'
		};
		nav.queryParameters = { mode: textInputButtonEventArgs.commons.constants.mode.Search
		};
		nav.customDialogParameters = {
		};
		//nav.openModalWindow(textInputButtonEventArgs.commons.controlId);
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Print (Button)
	task.executeCommand.CM_KARAI97PIT75 = function(entities, executeCommandEventArgs) {
	    executeCommandEventArgs.commons.execServer = false;
	    var debtor = FLCRE.UTILS.CUSTOMER.getDebtor(entities.DebtorGeneral.data());
	    if(debtor!=null){
	        if(entities.OriginalHeader.IDRequested!=null){
	            var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.TicketApplication],['idCustomer',debtor.CustomerCode],['idTramit',entities.OriginalHeader.IDRequested],['idProcess',entities.OriginalHeader.ApplicationNumber],['tipoCustomer',entities.HeaderGuaranteesTicket.CustomerType]];
	            var debtors = entities.DebtorGeneral.data();
	            var count = 0;
	            for (var i = 0; i < debtors.length; i++) {
	                if(debtors[i].Role == 'C'){
	                    count = count + 1;
	                    args.push(['cstCodeu'+count, debtors[i].CustomerCode]);
	                }
	            }
	            BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.TicketApplication,args);
	        } else {
	            executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_NMRREEUID_75532');
	        }
	    }
	    else {
	        executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SAOUCENTD_07389');
	    }
	};
    //Save (Button)
    task.executeCommand.CM_KARAI97SVE03 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };

	//Validacion de success del server para habilitacion de boton continuar
	task.executeCommandCallback.CM_KARAI97SVE03 = function(entities, executeCommandCallbackEventArgs) {
		if(executeCommandCallbackEventArgs.success===true && task.EtapaTramite == FLCRE.CONSTANTS.Stage.RevisedRecommendation){
			executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_KARAI97SVE03');
		}else{
			BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}
	};

	task.executeCommand.CM_KARAI97IED88 = function(entities, executeCommandEventArgs) { //SaveInfocred (Button)  - Guardar Reporte INFOCRED
        FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };
	task.executeCommandCallback.CM_KARAI97IED88 = function(entities, executeCommandCallbackEventArgs) {
		FLCRE.UTILS.INFOCRED.openReentryWindowDebtor(entities.InfocredHeader,executeCommandCallbackEventArgs);
	};

    task.executeCommand.CM_KARAI97ROR52 = function(entities, executeCommandEventArgs) { //ReportInfocred (Button) - Imprimir Reporte INFOCRED
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };
	task.executeCommandCallback.CM_KARAI97ROR52 = function(entities, executeCommandCallbackEventArgs) {
		if(executeCommandCallbackEventArgs.success){
			FLCRE.UTILS.INFOCRED.getReportByCustomer(executeCommandCallbackEventArgs);
		}
	};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //RowInserting QueryView: Borrowers
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
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
		   gridRowInsertingEventArgs.commons.execServer = false;
    };

    //InsertingRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente.
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        beforeOpenGridDialogEventArgs.commons.execServer = false;
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

    //FileDeleting QueryView: GridOtherWarranty
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_URYTH5890_66 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
    };

    //Selecting Other QueryView: GridOtherWarranty
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_URYTH5890_66 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

	 task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { //SectingDeudores QueryView: Borrowers
        gridRowSelectingEventArgs.commons.execServer = false;
    };
    //GridCommand (Button) QueryView: Borrowers
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(gridExecuteCommandEventArgs);
    };

	/*PARA EL LLAMADO A LA VISTA DE BUSQUEDA DE CLIENTES*/
	//GridCommandNew (Button) QueryView: Borrowers
    task.gridCommand.CEQV_201_QV_BOREG0798_55_657 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

	//BeforeEnterLine QueryView: Borrowers (llamada a pantalla busqueda de clientes)
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
		gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
		task.Source = 'QV_BOREG0798_55';

        gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerCode');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'CustomerName');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Role');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'TypeDocumentId');
		gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Identification');
		//gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Qualification');
		var nav = gridABeforeEnterInLineRowEventArgs.commons.api.navigation;

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
				 //"/customer/services/find-program-srv.js",
				 "/customer/controllers/find-customers-ctrl.js"]
		 }];

		nav.customDialogParameters = {
		};
		nav.openCustomModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId, null);
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: FGuaranteesTicket
    task.initData.VC_KARAI97_KPLAN_665 = function(entities, initDataEventArgs) {
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.HeaderGuaranteesTicket.CustomerId = client.clientId;
		entities.HeaderGuaranteesTicket.CustomerName = client.clientName;
		entities.HeaderGuaranteesTicket.ByAccountName = client.clientName;
		entities.HeaderGuaranteesTicket.CustomerType = client.clientType;

		entities.HeaderGuaranteesTicket.BeneficiaryName  = ' ';

		//Envio la variable de contexto para la oficina
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		//envio el usuario para recuperar la ciudad destino
		entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);
		//envio el usuario para recuperar la ciudad destino
		//entities.HeaderGuaranteesTicket.User=cobis.userContext.getValue(cobis.constant.USER_NAME);

		entities.OriginalHeader.ApplicationNumber = client.processInstanceIdentifier;
		initDataEventArgs.commons.execServer = true;

		//DATOS DEUDOR
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.clientId != null && typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== ''){
			var cust = new FLCRE.UTILS.CUSTOMER.getDebtorGeneral(client.clientId,client.clientName, 'D', '','');
			initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', [cust], true);
		}
		//Validación para identificar si el flujo fue iniciado desde una operacíon existente o una nueva
		if(parentParameters.Task.bussinessInformationStringOne != undefined && parentParameters.Task.bussinessInformationStringOne != null){
			//Flujo iniciado desde una operación existente
			//Deshabilito los campos
			var ctrl = ['VA_IEWGUARNTK6806_TREU555',//Monto Solicitado
						'VA_IEWGUARNTK6806_RRQE376',//Moneda Solicitada
						'VA_IEWGUARNTK6806_REWP949'//Nueva Operación renovación
						];
			BUSIN.API.disable(initDataEventArgs.commons.api.viewState, ctrl);
			//Se setea el campo de renovación original.
			entities.HeaderGuaranteesTicket.RenewOperation = parentParameters.Task.bussinessInformationStringOne;
		}else{
		//Se oculta el campo para renovació
			initDataEventArgs.commons.api.viewState.hide('VA_IEWGUARNTK6806_REWP949');
		}

		//campo codigo actividad economica
		initDataEventArgs.commons.api.viewState.hide('VA_RIOTRDTAVI4904_RDTN715');
		//initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_EDSN666',true); -- Comentado xq daba error
    };

	task.initDataCallback.VC_KARAI97_KPLAN_665 = function(entities, initDataEventArgs) {
		var api = initDataEventArgs.commons.api;
		if(initDataEventArgs.success == false){
			api.viewState.disable('CM_KARAI97SVE03');
		}else{
			api.viewState.enable('CM_KARAI97SVE03');
		}
	}

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: FGuaranteesTicket
    task.render = function(entities, renderEventArgs) {
        var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = renderEventArgs.commons.api.viewState;
		task.Etapa=parentParameters.Task.urlParams.Etapa;
		var api = renderEventArgs.commons.api;
		BUSIN.API.hide(viewState,['GR_RIOTRDTAVI49_11','GR_IEWGUARNTK68_12']);
		viewState.show('GR_RIOTRDTAVI49_12');

		//Ocultar la parte de Garantias y otros Datos
		if(task.Etapa == FLCRE.CONSTANTS.Stage.Entry){
			BUSIN.API.hide(viewState,['VC_KARAI97_GSNOB_349','VC_KARAI97_NNMBE_040','VA_IEWGUARNTK6810_ALNI891','VA_IEWGUARNTK6810_INTE642','VA_IEWGUARNTK6806_UMRO301']);
			BUSIN.API.show(viewState,['CM_KARAI97PIT75','VA_IEWGUARNTK6806_DAPS003']);
		}
		BUSIN.API.disable(viewState,['VA_IEWGUARNTK6807_TORR665','VA_IEWGUARNTK6806_EUER032','VA_IEWGUARNTK6806_DAPS003']);

		var viewState2 = viewState, template;
        var template = '<span><h4>#: value#</h4></span>' + '<span><b>Monto:</b> #: attributes[0] #</span> - '+
			'<span><b>Disponible:</b> #: attributes[1] #</span> - '+
			'<span><b>Moneda:</b> #: attributes[2] #</span>';
        viewState2.template('VA_IEWGUARNTK6806_LIES496', template);
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

	task.cleanFields = function(entities){
		entities.HeaderGuaranteesTicket.CurrencyRequested = '';
		entities.HeaderGuaranteesTicket.CreditLineDistrib = '';
		entities.HeaderGuaranteesTicket.WarrantyClass = '';
	};

}());
