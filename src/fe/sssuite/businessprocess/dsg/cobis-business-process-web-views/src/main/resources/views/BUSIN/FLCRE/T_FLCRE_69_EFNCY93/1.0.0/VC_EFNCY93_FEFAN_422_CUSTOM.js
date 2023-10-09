<!-- Designer Generator v 5.0.0.1509 - release SPR 2015-09 15/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.refinancingdataentry;
    task.EtapaTramite = '';
    task.TipoTramite = '';
    task.TypeProcessed = '';
    var listRefinancingOperations = [];
    var selectedOperation ;
    var flagChangeAmount =0;
    var flagSelectionOper = 0;
    var afterInitData = false;
	var nuevaLinea='';

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
	    var parentParameters = changedEventArgs.commons.api.parentVc.customDialogParameters;
		changedEventArgs.commons.execServer = false;
		OTHERCREDITDATA.changeActivity(entities, changedEventArgs,task.TypeProcessed);
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

    //.Btn_Validate (Button) View: CreditOtherDataView  --DCA
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
        var parentParameters = executeCommandEventArgs.commons.api.parentVc.customDialogParameters;
        var etapa   = null;
        var tramite = null;

           /*Para no dañar la primera validacion la segunda validacion
           solo se hizo en el custom para analisis de oficial en Refinaciamiento
           y desembolso Bajo LC */
		if(!BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.Etapa) && !BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.Tramite) ){
            etapa = parentParameters.Task.urlParams.Etapa;
            tramite = parentParameters.Task.urlParams.Tramite
        }
        if ((etapa===FLCRE.CONSTANTS.Stage.Analisis && (tramite ===FLCRE.CONSTANTS.RequestName.Refinancing))||((etapa==='ANALISIS_OFICIAL' && (tramite ==='DESEMBOLSO_LC')))){
            if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.MaximumQuota)){
                if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.SumQuota)){
                        var cuotaMaxima = entities.ValidationQuotaVsAvailableBalance.MaximumQuota ;
                        var sumatoria = entities.ValidationQuotaVsAvailableBalance.SumQuota;
                        if (cuotaMaxima>sumatoria){ //Caso ok
							BUSIN.INBOX.STATUS.nextStep(true,executeCommandEventArgs.commons.api);
                            executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_UCESLIDAO_73855');
                        }else{ //Mensaje validacion
							BUSIN.INBOX.STATUS.nextStep(false,executeCommandEventArgs.commons.api);
							executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MAXIMAFEE_23007');
                        }
                }else{ //Mensaje Sumatoria Cuota no debe ser vacio
                    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FEESSUMUB_60939');
                }
            }else{ //Mensaje  Cuota Maxima no debe ser vacio
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FEEMAXIMA_06284');
            }
            executeCommandEventArgs.commons.execServer = false;
        }else{ // realizar validacion inicial
            if(entities.ValidationQuotaVsAvailableBalance.Rate === "" || entities.ValidationQuotaVsAvailableBalance.Rate === null ||
                entities.ValidationQuotaVsAvailableBalance.Term === "" || entities.ValidationQuotaVsAvailableBalance.Term === null ||
                entities.ValidationQuotaVsAvailableBalance.MaximumQuota === "" || entities.ValidationQuotaVsAvailableBalance.MaximumQuota === null ||
                entities.ValidationQuotaVsAvailableBalance.MaximumQuotaLine === "" || entities.ValidationQuotaVsAvailableBalance.MaximumQuotaLine === null
			){
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_CCKEMTFEL_83493');
                executeCommandEventArgs.commons.execServer = false;
            }else{
                executeCommandEventArgs.commons.execServer = true;
            }
        }
    };

    task.executeCommandCallback.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandCallbackEventArgs) {
    };

    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: CreditOtherDataView  -- DCA
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
		BUSIN.VALIDATE.IsGreaterThanZero(entities.ValidationQuotaVsAvailableBalance.MaximumQuota, changedEventArgs, false, true);
    };

    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: ApproveCreditRequest --DCA
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
        if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Term) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.OriginalHeader.AmountRequested) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Rate) )
        {
			changedEventArgs.commons.execServer = BUSIN.VALIDATE.IsGreaterThanZero(entities.ValidationQuotaVsAvailableBalance.Rate, changedEventArgs, false, true);
        }else{
            changedEventArgs.commons.execServer = false;
        }
    };

    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: CreditOtherDataView   -- DCA
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
        if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Term) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.OriginalHeader.AmountRequested) &&
           !BUSIN.VALIDATE.IsNullOrEmpty(entities.ValidationQuotaVsAvailableBalance.Rate) )
        {
            changedEventArgs.commons.execServer = BUSIN.VALIDATE.IsGreaterThanZero(entities.ValidationQuotaVsAvailableBalance.Term, changedEventArgs, false, true);
		}else{
			changedEventArgs.commons.execServer = false;
		}
    };

    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
            changedEventArgs.commons.execServer = false;
        }
    };

    //OfficerAnalysis.City (ComboBox) View: OfficerAnalysisView
    task.loadCatalog.VA_OFICANSSEW2603_CITY183 = function(loadCatalogDataEventArgs) {
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
		serverParameters.OfficerAnalysis = true;
    };
    //OfficerAnalysis.AOProductType (ComboBox) View: OfficerAnalysisView
    task.change.VA_OFICANSSEW2603_POCT250 = function(entities, changedEventArgs) {
        if(task.EtapaTramite === "ANALISIS"){
            changedEventArgs.commons.execServer = true;
        }else{
            changedEventArgs.commons.execServer = false;
        }
		changedEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8602_URQT595.read();

    };
	//Entity: OriginalHeader
    //OriginalHeader.CurrencyRequested (ComboBox) View: HeaderView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8602_URQT595 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.OfficerAnalysis = true;
		loadCatalogDataEventArgs.commons.execServer = true;
    };
    task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {
        var commons1 = loadCatalogDataEventArgs.commons;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
            serverParameters.OriginalHeader = true;
			serverParameters.HeaderGuaranteesTicket = true;
			serverParameters.OfficerAnalysis = true;
			serverParameters.DebtorGeneral = true;
        commons1.execServer = false;
        if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
            commons1.execServer = true;
            commons1.api.ext.timeout(function(){
                if( commons1.api.vc.catalogs.VA_ORIAHEADER8602_EVAL957.data().length==0){
                    commons1.api.viewState.disable('VA_ORIAHEADER8602_EVAL957');
                }
            },3000);
        }
    };

    //OriginalHeader.AmountRequested (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_OQUE134 = function(entities, changedEventArgs) {
        if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
            changedEventArgs.commons.execServer = false;
        }else  if(task.isRefinancing() && task.isEntry()){
            if(BUSIN.VALIDATE.IsNullOrEmpty(changedEventArgs.newValue) || BUSIN.VALIDATE.IsNullOrEmpty( entities.OriginalHeader.CurrencyRequested) || !task.hasOperations(entities, changedEventArgs) ){
                changedEventArgs.commons.execServer = false;
            }
		}
    };

    //OriginalHeader.CurrencyRequested (ComboBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_URQT595 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
		if(task.isReprogramming() && (task.isEntry() || task.isAnalisis()) ) {
			changedEventArgs.commons.execServer = false;
		}
        if(task.isRefinancing() && task.isEntry()){
            if(changedEventArgs.newValue===null || changedEventArgs.newValue===''){
                changedEventArgs.commons.execServer = false;
                task.clearHeaderData(entities);
            }else if(!task.hasOperations(entities, changedEventArgs)){
                changedEventArgs.commons.execServer = false;
                task.clearHeaderData(entities);
            }
        }
    };

    //OfficerAnalysis.Sector (ComboBox) View: OfficerAnalysisView
    task.change.VA_OFICANSSEW2603_SCOR371 = function(entities, changedEventArgs) {
        if(task.EtapaTramite != "ANALISIS"){
            changedEventArgs.commons.execServer = false;
        }else{
            var ctrs = ['VA_RIOTRDTAVI4909_ATRN190','VA_RIOTRDTAVI4909_SALE147','VA_RIOTRDTAVI4909_PESL753','VA_RIOTRDTAVI4909_NEIY699','VA_RIOTRDTAVI4909_NULE410','VA_RIOTRDTAVI4909_RCIE187'];
            if(changedEventArgs.newValue===entities.IndexSizeActivity.ParameterFixedIncome){
                entities.IndexSizeActivity.Patrimony="";
                entities.IndexSizeActivity.PersonalNumber="";
                entities.IndexSizeActivity.Sales="";
                entities.IndexSizeActivity.IndexSizeActivity="";
                entities.IndexSizeActivity.AnnualSales="";
                entities.IndexSizeActivity.ProductiveAssets="";
				entities.IndexSizeActivity.sizeCompany = "";
                BUSIN.API.disable(changedEventArgs.commons.api.viewState,ctrs);
                changedEventArgs.commons.execServer = false;
            }else{
                entities.IndexSizeActivity.AnnualSales="";
                entities.IndexSizeActivity.ProductiveAssets="";
                BUSIN.API.enable(changedEventArgs.commons.api.viewState,ctrs);
                if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
                    entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
                    changedEventArgs.commons.execServer = true;
                }else{
                    changedEventArgs.commons.execServer = false;
                }
            }
        }
    };

    //IndexSizeActivity.Patrimony (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
        if(task.EtapaTramite != "ANALISIS"){
            changedEventArgs.commons.execServer = false;
        }else{
            if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
                entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
                changedEventArgs.commons.execServer = true;
            }else{
                    changedEventArgs.commons.execServer = false;
            }
        }
    };

    //IndexSizeActivity.PersonalNumber (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
        if(task.EtapaTramite != "ANALISIS"){
            changedEventArgs.commons.execServer = false;
        }else{
            if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
            entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
                changedEventArgs.commons.execServer = true;
            }else{
                changedEventArgs.commons.execServer = false;
            }
        }
    };

    //IndexSizeActivity.Sales (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
        if((entities.IndexSizeActivity.Patrimony != null && entities.IndexSizeActivity.Patrimony != "" )&& (entities.IndexSizeActivity.PersonalNumber != null &&
            entities.IndexSizeActivity.PersonalNumber != "") && (entities.IndexSizeActivity.Sales != null && entities.IndexSizeActivity.Sales != "")){
            changedEventArgs.commons.execServer = true;
        }else{
            changedEventArgs.commons.execServer = false;
        }
    };

    //OriginalHeader.CityCredit (TextInputBox) View: HeaderView
    task.loadCatalog.VA_ORIAHEADER8602_CIDI260 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;
    };

    //OriginalHeader.Quota (TextInputBox) View: HeaderView
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
	    if(entities.OriginalHeader.Quota===0){
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_GEDTTDCRO_41910');
		}
    };

    //DistributionLine.AmountPurposed (TextInputBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.Currency (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

	 //Entity: OriginalHeader
    //OriginalHeader.CreditLineValid (ComboBox) View: HeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8602_EVAL957 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		var grid = changedEventArgs.commons.api.grid;
		nuevaLinea=changedEventArgs.newValue;
		var arregloLinea=changedEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8602_EVAL957.data();
		//Se valida que el Monto Disponible de la Línea no sea menor que el Monto Refinanciado
		if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
			for (var i = 0; i < arregloLinea.length; i++) {
				if(arregloLinea[i].code==nuevaLinea){
					var montoDisponible=arregloLinea[i].attributes[1];
					if (montoDisponible<entities.OriginalHeader.AmountRequested){
						changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_MNDERNNDO_09799');
					}else {
						changedEventArgs.commons.execServer = true;
					}
				}
			}
			// Para HErencia de deudores y Codeudores cuando es con Linea de Credito.
			if(entities.OriginalHeader.CreditLineValid === null){
				FLCRE.UTILS.CUSTOMER.deleteCoDebtorSourceRevenue(entities.DebtorGeneral, entities.SourceRevenueCustomer, changedEventArgs)
				FLCRE.UTILS.CUSTOMER.deleteCoDebtor(entities.DebtorGeneral, changedEventArgs)
				grid.showToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
				grid.showToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
			}else{				
				grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
				grid.hideToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
			}
		}		
    };

    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        if(task.EtapaTramite != "ANALISIS"){
            loadCatalogDataEventArgs.commons.execServer = true;
        }else {
            loadCatalogDataEventArgs.commons.execServer = false;
        }
    };



    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Print (Button)
    task.executeCommand.CM_EFNCY93RNT78 = function(entities, executeCommandEventArgs) {
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
            //Mensaje de que no existe aun el tramite
            executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_NMRREEUID_75532');
           }
        }
        else {
            //Mensaje de no tener deudor
            executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SAOUCENTD_07389');
        }
    };

    //Save (Button)
    task.executeCommand.CM_EFNCY93SAE70 = function(entities, executeCommandEventArgs) {

		if( task.isAnalisis() ) {//EN ETAPA DE ANALISIS DEL OFICIAL VALIDA QUE ESTE LLENO EL CAMPO 'FECHA-CIC'
			if(!FLCRE.UTILS.CUSTOMER.hasDateCIC(entities,executeCommandEventArgs,true)){
				executeCommandEventArgs.commons.execServer = false;
				return;
			}
		}

        if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
            //VALIDA SI TIENE OPERACIONES A EXPROMISIONAR
            if(!task.hasOperations(entities, executeCommandEventArgs)){
                executeCommandEventArgs.commons.execServer = false;
            }
            //VALIDA SI TIENE OPERACION BASE
            if(!task.hasBaseOperations(entities, executeCommandEventArgs)){
                executeCommandEventArgs.commons.execServer = false;
            }
            //VALIDA SI TIENE DEUDORES
            if(!FLCRE.UTILS.CUSTOMER.hasDebtors(entities, executeCommandEventArgs, true)){
                executeCommandEventArgs.commons.execServer = false;
            }
            //VALIDA SI TIENE UN SOLO DEUDOR PRINCIPAL
            if(!FLCRE.UTILS.CUSTOMER.hasOnlyOneDebtor(entities, executeCommandEventArgs, true)){
                executeCommandEventArgs.commons.execServer = false;
            }

            var errors = executeCommandEventArgs.commons.api.errors,
            integerError = errors.validateInput('VA_VALIATOVEW9843_TEU1070');

        }
		//Se valida en el boton guardar que el Monto Disponible de la Línea no sea menor que el Monto Refinanciado
		if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
			var arregloLinea=executeCommandEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8602_EVAL957.data();
			if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
				for (var i = 0; i < arregloLinea.length; i++) {
					if(arregloLinea[i].code==nuevaLinea){
						var montoDisponible=arregloLinea[i].attributes[1];
						if (montoDisponible<entities.OriginalHeader.AmountRequested){
							executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_MNDERNNDO_09799');
							executeCommandEventArgs.commons.execServer = false;
						}else{
							 executeCommandEventArgs.commons.execServer = true;
						}
					}
				}
			}
		}
    };
    task.executeCommandCallback.CM_EFNCY93SAE70 = function(entities, executeCommandEventArgs) {
		var viewState = executeCommandEventArgs.commons.api.viewState;
		//Del grupo que contiene los tabs se selecciona el primero, en el Analisis del Oficial del Refinaciamiento
		BUSIN.API.GROUP.selectTab('GR_RIOTRDTAVI49_03',0, executeCommandEventArgs.commons.api);
		BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
    };

    //Hide (Button)
    task.executeCommand.CM_EFNCY93HID35 = function(entities, executeCommandEventArgs) {
        if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
            if(!task.hasOperations(entities, executeCommandEventArgs)){
                executeCommandEventArgs.commons.execServer = false;
            }
        }
    };


    task.executeCommand.CM_EFNCY93ARE03 = function(entities, executeCommandEventArgs) { //SaveInfocred (Button)  - Guardar Reporte INFOCRED
        FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };
	task.executeCommandCallback.CM_EFNCY93ARE03 = function(entities, executeCommandCallbackEventArgs) {
		FLCRE.UTILS.INFOCRED.openReentryWindowDebtor(entities.InfocredHeader,executeCommandCallbackEventArgs);
	};

    task.executeCommand.CM_EFNCY93TIR32 = function(entities, executeCommandEventArgs) { //ReportInfocred (Button) - Imprimir Reporte INFOCRED
		FLCRE.UTILS.INFOCRED.getDataForProcess(entities.InfocredHeader, entities.OriginalHeader.IDRequested, executeCommandEventArgs);
    };
	task.executeCommandCallback.CM_EFNCY93TIR32 = function(entities, executeCommandCallbackEventArgs) {
		if(executeCommandCallbackEventArgs.success){
			FLCRE.UTILS.INFOCRED.getReportByCustomer(executeCommandCallbackEventArgs);
		}
	};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************

    //Rowinserting QueryView: GridRefinancingOperations
    task.gridRowInserting.QV_ITRIC1523_63 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
         if(afterInitData){
            var criteria = { field: "IsBase", operator:"eq" ,value: true} ;
            var selectedRow =  gridRowInsertingEventArgs.commons.api.grid.selectRow("QV_ITRIC1523_63",criteria);
            gridRowInsertingEventArgs.commons.api.grid.expandRow("QV_ITRIC1523_63", selectedRow);
         }
    };

    task.gridRowInsertingCallback.QV_ITRIC1523_63 = function(entities, gridRowInsertingEventArgs) {
       gridRowInsertingEventArgs.commons.execServer = false;
    };

    //rowUpdating QueryView: GridRefinancingOperations
    task.gridRowUpdating.QV_ITRIC1523_63 = function(entities, gridRowUpdatingEventArgs) {
         gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //SelectOperation QueryView: GridRefinancingOperations
    task.gridRowSelecting.QV_ITRIC1523_63 = function(entities, gridRowSelectingEventArgs) {
        if(flagSelectionOper===1){
            flagSelectionOper=0;
            gridRowSelectingEventArgs.commons.execServer = true;
        }else{
            gridRowSelectingEventArgs.commons.execServer = false;
        }
    };

    //DeleteOperation QueryView: GridRefinancingOperations
    task.gridRowDeleting.QV_ITRIC1523_63 = function(entities, gridRowDeletingEventArgs) {
        if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
            gridRowDeletingEventArgs.commons.execServer = false;
            task.clearHeaderData(entities);
            gridRowDeletingEventArgs.commons.api.vc.executeCommand('CM_EFNCY93HID35','Hide', undefined, false, false, 'VC_EFNCY93_FEFAN_422', false);
        }else{
            if (entities.OriginalHeader.IDRequested == null || entities.OriginalHeader.IDRequested == undefined){
                gridRowDeletingEventArgs.commons.execServer = false;
            }else{
                gridRowDeletingEventArgs.commons.execServer = true;
            }
        }
    };
	 task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { //SectingDeudores QueryView: Borrowers
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW - DistributionLine
    //**********************************************************

    //InsertingRow QueryView: GridDistributionLine
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {
        // gridRowInsertingEventArgs.commons.execServer = false;
    };
    //UpdateRow QueryView: GridDistributionLine
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
        // gridRowUpdatingEventArgs.commons.execServer = false;
    };
    //DeleteRow QueryView: GridDistributionLine
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
        // gridRowDeletingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW - Borrowers
    //**********************************************************
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) { //RowInserting QueryView: Borrowers
        gridRowInsertingEventArgs.commons.execServer = false;
        FLCRE.UTILS.CUSTOMER.removeEmptyDebtorByCode(entities,gridRowInsertingEventArgs,0);
		if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
			if((afterInitData===true) && (gridRowInsertingEventArgs.rowData.Role==='D')){
				var debtors = entities.DebtorGeneral.data();
				for (var i = 0; i < debtors.length; i++) {
					if( (debtors[i].Role === 'D') && (debtors[i].CustomerCode!=gridRowInsertingEventArgs.rowData.CustomerCode)){
						gridRowInsertingEventArgs.cancel = true;
						gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LLUOUNUCO_20908',null,5000);
						return;
					}
				}
			}
		}
    };

    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) { //BeforeViewCreationCl QueryView: Borrowers
        //beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) { //BeforeEnterLine QueryView: Borrowers
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        var deleteNewRow = !(task.isReprogramming() && (task.isEntry() || task.isAnalisis()));
        FLCRE.UTILS.CUSTOMER.openFindCustomer(entities,gridABeforeEnterInLineRowEventArgs,{},deleteNewRow);
    };

    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) { //GridCommand (Button) QueryView: Borrowers
        gridExecuteCommandEventArgs.commons.execServer = false;
		var debtors = gridExecuteCommandEventArgs.commons.api.grid.getSelectedRows('QV_BOREG0798_55');
		//JES - Validar que no se pueda eliminar el deudor principal de las operaciones seleccionadas. Si se requiere eliminar el deudor entonces se deberá eliminar primero la operación.
		if(task.isReprogramming() && (task.isEntry() || task.isAnalisis()) && !BUSIN.VALIDATE.IsNull(debtors)){
			var ops = entities.RefinancingOperations.data();
			for (var i = 0; i < ops.length; i++) {
				for (var j = 0; j < debtors.length; j++) {
					if(ops[i].oficialOperation===debtors[j].CustomerCode){
						gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_EDRDRIROR_70966',null,5000);
						return;
					}
				}
			}
		}
		var validateType = !(task.isReprogramming() && (task.isEntry() || task.isAnalisis()));
		FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(gridExecuteCommandEventArgs,false);
    };

	task.gridInitColumnTemplate.QV_BOREG0798_55 = function(idColumn) { //QueryView: Borrowers
		 if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC();
		}
	};
	task.change.VA_BORRWRVIEW2783_DTCC540 = function(entities, changedEventArgs) {//Change - Fecha CIC
		changedEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.setDateCIC(changedEventArgs);
	};
    //**********************************************************
    //  Eventos para PopUps
    //**********************************************************
    task.closeModalEvent.findCustomer = function (args) {
        args.commons.api.grid.enabledColumn('QV_BOREG0798_55', 'Role');
        var addHasNew = !(task.isReprogramming() && (task.isEntry() || task.isAnalisis()));
        FLCRE.UTILS.CUSTOMER.addDebtorFromSearch(args,'C',addHasNew);
    };

    task.closeModalEvent.VC_OSRCH32_AOEAR_233 = function (args) {
        alert('PASO DATOS');
    };

    //DeleteCommand (Button) QueryView: GridRefinancingOperations
    task.gridCommand.CEQV_201_QV_ITRIC1523_63_978 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        var selectedRow = gridExecuteCommandEventArgs.commons.api.grid.getSelectedRows('QV_ITRIC1523_63');
        if( selectedRow!=null && selectedRow.length>0 ){
            for (var i = 0; i < selectedRow.length; i ++) {
                if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
                    task.clearHeaderData(entities);
                    task.clearHeaderDataByBase(entities);
                    gridExecuteCommandEventArgs.commons.api.grid.removeRowByDsgnrId('RefinancingOperations',selectedRow[i]);
                } else{
                    if(selectedRow[i].IsBase){//no se puede borrar la operacion base
                        gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_SPEINAROB_03175',null,6000);
                    } else{
                        gridExecuteCommandEventArgs.commons.api.grid.removeRowByDsgnrId('RefinancingOperations',selectedRow[i]);
                    }
                }
            }
        } else {
            gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ELCNEUNAR_05370');
        }
    };

    //cmdNew (Button) QueryView: GridRefinancingOperations
    task.gridCommand.CEQV_201_QV_ITRIC1523_63_992 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        var nav = FLCRE.API.getApiNavigation(gridExecuteCommandEventArgs,'T_FLCRE_21_OSRCH32','VC_OSRCH32_AOEAR_233');
        nav.label = cobis.translate('BUSIN.DLB_BUSIN_BQEEERCIE_19389');
        nav.modalProperties = { size: 'lg' };
        nav.queryParameters = { mode: gridExecuteCommandEventArgs.commons.constants.mode.Insert };

        //Etapa de Ingreso y de Analisis del Oficial
        if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())){
            nav.customDialogParameters = { operations: entities.RefinancingOperations.data() , AddCustomerCode:true,debtors: entities.DebtorGeneral.data(), TypeProcess:entities.OriginalHeader.TypeRequest, Expromision:entities.OriginalHeader.Expromission};
        }else{
            if( entities.RefinancingOperations.data().length>=1){
                nav.customDialogParameters = { operations: entities.RefinancingOperations.data() , debtors: entities.DebtorGeneral.data() , TypeOperation: entities.OfficerAnalysis.ProductType, TypeObject: entities.CreditOtherData.CreditPorpuse , SectorCredit: entities.OfficerAnalysis.SerctorNeg,
                TypeProcess:entities.OriginalHeader.TypeRequest, Expromision:entities.OriginalHeader.Expromission};
            }else{
                nav.customDialogParameters = { operations: entities.RefinancingOperations.data() , debtors: entities.DebtorGeneral.data() };
            }
        }
        nav.openModalWindow(gridExecuteCommandEventArgs.commons.controlId);
    };

    //BeforeInserting QueryView: GridRefinancingOperations
    task.gridBeforeEnterInLineRow.QV_ITRIC1523_63 = function(entities, gridABeforeEnterInLineRowEventArgs) {
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
         var nav = FLCRE.API.getApiNavigation(gridABeforeEnterInLineRowEventArgs,'T_FLCRE_21_OSRCH32','VC_OSRCH32_AOEAR_233');
        nav.label = cobis.translate('BUSIN.DLB_BUSIN_BQEEERCIE_19389');
        nav.modalProperties = { size: 'lg' };
        nav.queryParameters = { mode: gridABeforeEnterInLineRowEventArgs.commons.constants.mode.Insert };
        if( entities.RefinancingOperations.data().length>=1){
            nav.customDialogParameters = { operations: entities.RefinancingOperations.data() , debtors: entities.DebtorGeneral.data() , TypeOperation: entities.OfficerAnalysis.ProductType, TypeObject : entities.CreditOtherData.CreditPorpuse};
        }else{
            nav.customDialogParameters = { operations: entities.RefinancingOperations.data() , debtors: entities.DebtorGeneral.data() };
        }
        nav.openModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId);
    };

    task.closeModalEvent.VC_OSRCH32_AOEAR_233 = function (args) { //RESULTADO DE BUSQUEDA DE OPERACIONES
        var operationSelected = args.result;
        var ent = args.commons.api.vc.model;
        operationSelected[0].RefinancingOption ="C";

        var objects  = [];
        var countOper =0;
        for (var i = 0; i < ent.RefinancingOperations.data().length; i++) {
            var obj = ent.RefinancingOperations.data()[i];
            if(obj.OperationBank!=""){
                objects.push(obj);
            }
            if(obj.IsBase){
                countOper= countOper+1;
            }
        }
        operationSelected[0].RefinancingOption ="C";

        if(countOper ===0){
            operationSelected[0].IsBase =true;
        }
        objects = objects.concat(operationSelected);
        args.commons.api.grid.addAllRows('RefinancingOperations', objects, true);

        if((task.isReprogramming() && (task.isEntry() || task.isAnalisis())) ||
            (task.isEntry() && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing)){
            task.clearHeaderData(args.model);
            args.commons.api.vc.executeCommand('CM_EFNCY93HID35','Hide', undefined, false, false, 'VC_EFNCY93_FEFAN_422', false);
        }else{
            flagSelectionOper = 1;
        }
         var criteria = { field: "IsBase", operator:"eq" ,value: true} ;
         var selectedRow =  args.commons.api.grid.selectRow("QV_ITRIC1523_63",criteria);
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: formRefinancing
    task.initData.VC_EFNCY93_FEFAN_422 = function(entities, initDataEventArgs) {
		BUSIN.SYSTEM.importScript('OtherCreditData.js');
		BUSIN.SYSTEM.importScript('CreditBureau.js');
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
        var viewState = initDataEventArgs.commons.api.viewState;
        viewState.label("VA_ORIAHEADER8602_CRET312", "BUSIN.DLB_BUSIN_REASONMLS_18269");
        initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
        initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
        initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
        entities.OriginalHeader.Office=cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);

		//campo codigo actividad economica
		viewState.hide('VA_RIOTRDTAVI4904_EDSN666'); //se oculta Actividad destinar credito x busqueda
		viewState.readOnly('VA_RIOTRDTAVI4904_RDTN715',true); //se visualiza Actividad destinar credito combo

        if(parentParameters.Task.urlParams.Etapa != null && parentParameters.Task.urlParams.Etapa !== undefined){
            entities.OriginalHeader.stageflux = parentParameters.Task.urlParams.Etapa;
            task.EtapaTramite = parentParameters.Task.urlParams.Etapa;
        }
        if(parentParameters.Task.urlParams.Tramite != null && parentParameters.Task.urlParams.Tramite !== undefined){
            task.TypeProcessed = parentParameters.Task.urlParams.Tramite;
            if(parentParameters.Task.urlParams.Tramite === FLCRE.CONSTANTS.RequestName.Reprogramming){
                entities.OriginalHeader.TypeRequest = FLCRE.CONSTANTS.Tramite.Refinanciamiento;
            }
        }

        if(parentParameters.Task.bussinessInformationStringOne !== undefined &&parentParameters.Task.bussinessInformationStringOne !== '' && parentParameters.Task.bussinessInformationStringOne !== null){
            //debe venir la operacion en la variable bussinessInformationStringOne
            if(task.TypeProcessed != FLCRE.CONSTANTS.RequestName.Reprogramming){
                var refinancingOp = new RefinancingOperations(parentParameters.Task.bussinessInformationStringOne);
                listRefinancingOperations.push(refinancingOp);
                initDataEventArgs.commons.api.grid.addAllRows('RefinancingOperations', listRefinancingOperations, true);
            }
        }

        //ABU indifico que es reprogramacion
        if(parentParameters.Task.urlParams.tipo !== undefined && parentParameters.Task.urlParams.tipo !== null){
            entities.OriginalHeader.Type = parentParameters.Task.urlParams.tipo;
            task.TipoTramite = parentParameters.Task.urlParams.tipo;
        }
        if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
            entities.OriginalHeader.Type = FLCRE.CONSTANTS.Tramite.Refinanciamiento;
        }
        var client = initDataEventArgs.commons.api.parentVc.model.Task;
        if (client.clientId != null && typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== ''){
            var cust = new FLCRE.UTILS.CUSTOMER.getDebtorGeneral(client.clientId, client.clientName, 'D', '', '');
            initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', [cust], true);
        }
        BUSIN.API.hide(viewState,['GR_RIOTRDTAVI49_12','CM_EFNCY93HID35']);
		//campo actividad economica
		initDataEventArgs.commons.api.viewState.readOnly('VA_RIOTRDTAVI4904_RDTN715', true);
		entities.Context.RequestStage = task.EtapaTramite;
    };

    task.initDataCallback.VC_EFNCY93_FEFAN_422 = function(entities, initDataEventArgs) {
        var grid = initDataEventArgs.commons.api.grid;
        var ds = initDataEventArgs.commons.api.vc.model['RefinancingOperations'];
        grid.showColumn('QV_ITRIC1523_63', 'IsBase');
        grid.showColumn('QV_ITRIC1523_63', 'OperationQualification');
        grid.showColumn('QV_ITRIC1523_63', 'PayoutPercentage');
        grid.hideColumn('QV_ITRIC1523_63', 'oficialOperation');
        grid.hideColumn('QV_ITRIC1523_63', 'IdOperation');
        grid.hideColumn('QV_ITRIC1523_63', 'CreditType');
        grid.hideColumn('QV_ITRIC1523_63', 'InternalCustomerClassification');

        initDataEventArgs.commons.api.viewState.addStyle('QV_ITRIC1523_63', 'grupo-lectura');
        grid.hideToolBarButton('QV_ITRIC1523_63', 'create');

        if(task.isReprogramming() && (task.isEntry() || task.isAnalisis())) {
            if(!task.hasOperations(entities, initDataEventArgs)){
                task.clearHeaderData(entities)
                return;
            }
        }
		//EN ETAPA DE ANALISIS DEL OFICIAL SE PONE VISIBLE EL CAMPO FECHA-CIC
        if(task.isAnalisis()) {
			grid.showColumn ('QV_BOREG0798_55', 'DateCIC');
		}
        afterInitData =true;
    };

    //ViewContainer: formRefinancing
    task.render = function(entities, renderEventArgs) {
        var viewState = renderEventArgs.commons.api.viewState;
        var grid = renderEventArgs.commons.api.grid;
        //se cambia de posicion
        var ctrs = ['VA_ORIAHEADER8602_NQUE773','VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_CRET312','GR_RIOTRDTAVI49_12','VA_OFICANSSEW2605_BINO138','GR_RIOTRDTAVI49_15'];
        BUSIN.API.hide(viewState,ctrs);
        viewState.disable('GR_RIOTRDTAVI49_12'); //DCA

        if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Analisis){
            BUSIN.API.disable(viewState,['VA_ORIAHEADER8602_URQT595','VA_ORIAHEADER8602_AONN156','VA_RIOTRDTAVI4912_MAMU147']);//RLA VA_RIOTRDTAVI4912_MAMU147
            ctrs = ['VA_OFICANSSEW2603_SAMN032','VA_OFICANSSEW2603_UNDU035','VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_TENY472','VA_OFICANSSEW2603_TERM877','VA_RIOTRDTAVI4912_RATE281','VA_RIOTRDTAVI4912_TERM010','VA_RIOTRDTAVI4912_IULI202'];
            BUSIN.API.hide(viewState,ctrs);

            ctrs = ['VA_RIOTRDTAVI4912_UMUA249'];//RLA
            BUSIN.API.show(viewState,ctrs);

            if(entities.OfficerAnalysis.Sector===entities.IndexSizeActivity.ParameterFixedIncome){
                entities.IndexSizeActivity.Patrimony="";
                entities.IndexSizeActivity.PersonalNumber="";
                entities.IndexSizeActivity.Sales="";
                entities.IndexSizeActivity.IndexSizeActivity="";
                ctrs = ['VA_RIOTRDTAVI4909_ATRN190','VA_RIOTRDTAVI4909_SALE147','VA_RIOTRDTAVI4909_PESL753',
                        'VA_RIOTRDTAVI4909_NEIY699','VA_RIOTRDTAVI4909_NULE410','VA_RIOTRDTAVI4909_RCIE187'];
                BUSIN.API.disable(viewState,ctrs);
            }
			CREDITBUREAU.QUERYCENTRAL.validateLevelIndebtedness(entities, renderEventArgs, 'VA_RIOTRDTAVI4907_EDNE010');
        }else{
            ctrs = ['GR_RIOTRDTAVI49_07','GR_RIOTRDTAVI49_09','GR_RIOTRDTAVI49_10','VA_RIOTRDTAVI4907_OTHC416',
                    'VA_RIOTRDTAVI4907_MICE804','VA_OFICANSSEW2603_SAMN032',
                    'VA_OFICANSSEW2603_UNDU035','VA_OFICANSSEW2603_SURE913','VA_OFICANSSEW2603_TENY472','VA_OFICANSSEW2603_TERM877'];
            BUSIN.API.hide(viewState,ctrs);
            //se muestra en ingreso de datos la frecuencia de pago y la cuota
            ctrs = ['VA_ORIAHEADER8602_NQUE773','VA_ORIAHEADER8602_QUOA306'];
            BUSIN.API.show(viewState,ctrs);

            viewState.disableValidation('VA_RIOTRDTAVI4909_ATRN190',VisualValidationTypeEnum.Required);
            viewState.disableValidation('VA_RIOTRDTAVI4909_SALE147',VisualValidationTypeEnum.Required);
            viewState.disableValidation('VA_RIOTRDTAVI4909_PESL753',VisualValidationTypeEnum.Required);
            viewState.disableValidation('VA_RIOTRDTAVI4909_NULE410',VisualValidationTypeEnum.Required);
            viewState.disableValidation('VA_RIOTRDTAVI4909_RCIE187',VisualValidationTypeEnum.Required);
        }
        ctrs = ['GR_RIOTRDTAVI49_11','VA_OFICANSSEW2603_APIB151','VA_OFICANSSEW2603_FFCE753'];
        BUSIN.API.hide(viewState,ctrs);
        ctrs = ['VA_OFICANSSEW2603_POCT250','VA_OFICANSSEW2603_SCOR371','VA_OFICANSSEW2603_PONE992','VA_OFICANSSEW2603_CITY183','VA_OFICANSSEW2603_CRTN299'];
        BUSIN.API.enable(viewState,ctrs);

        if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Analisis){
            ctrs = ['VA_ORIAHEADER8602_IALT328','VA_RIOTRDTAVI4904_RPPU470'];
            //Ocultando botones de Operaciones
            grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');//boton eliminar
            grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');//boton eliminar
            grid.hideToolBarButton('QV_ITRIC1523_63', 'create');//boton nuevo
            //Ocultando botones de Deudores
            grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
            grid.hideToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
			viewState.hide('VA_OFICANSSEW2603_CRTN299');  // HOY TIPO DE CREDITO
			var ctrsD = ['VA_OFICANSSEW2603_SCOR371'];
			BUSIN.API.disable(viewState,ctrsD);
        }else{
			ctrs = ['VA_ORIAHEADER8602_IALT328','VA_RIOTRDTAVI4904_RPPU470','VA_OFICANSSEW2603_ORNG078']; //sector del credito
        }
        BUSIN.API.disable(viewState,ctrs);

        grid.resizeGridColumn('QV_ITRIC1523_63', 'OperationBank', 170);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'RefinancingOption', 170);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'CurrencyOperation', 80);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'Balance', 70);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'LocalCurrencyBalance', 70);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'OriginalAmount', 70);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'LocalCurrencyAmount', 70);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'CreditType', 140);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'InternalCustomerClassification', 170);
        grid.resizeGridColumn('QV_ITRIC1523_63', 'DateGranting', 120);

        //Si estoy en el flujo de reprogramacion se debe cambiar la etiqueta de operaciones a refinanciar por operaciones a reprogramar
        if(task.TipoTramite === FLCRE.CONSTANTS.Tramite.Reprogramacion && task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry ) {
            //focus en la segunda pestania del tab
            BUSIN.API.enable(viewState,['VA_RIOTRDTAVI4904_RDTN715','VA_RIOTRDTAVI4904_RPPU470']);
            BUSIN.API.GROUP.selectTab('GR_RIOTRDTAVI49_03', 1, renderEventArgs.commons.api);
			viewState.disable('VA_RIOTRDTAVI4904_EDSN666');
        }
        if(task.isEntry() && task.isReprogramming()){
			ctrs = ['VA_OFICANSSEW2603_POCT250','VA_RIOTRDTAVI4904_RPPU470','VA_OFICANSSEW2603_CRTN299','VA_ORIAHEADER8602_OQUE134','VA_RIOTRDTAVI4904_TATT517',
					'VA_RIOTRDTAVI4904_RDTN715','VA_RIOTRDTAVI4904_DSNS029','VA_ORIAHEADER8602_URQT595','VA_RIOTRDTAVI4904_EDSN666'];
            BUSIN.API.disable(viewState,ctrs );
            viewState.hide('VA_OFICANSSEW2603_SCOR371');
            viewState.enable('VA_RIOTRDTAVI4904_OUED020'); // se habilita la Fuente de Financiamiento
            viewState.enable('VA_OFICANSSEW2605_BINO138'); // se habilita Observación de la reprogramación
			viewState.show('VA_OFICANSSEW2605_BINO138'); // se muestra Observación de la reprogramación

			var ctrs1 = ['VA_ORIAHEADER8602_TERM237','VA_ORIAHEADER8602_CRET312'];
		    BUSIN.API.show(viewState,ctrs1);
		    BUSIN.API.enable(viewState,ctrs1);
			 viewState.label("VA_ORIAHEADER8602_CRET312", "BUSIN.DLB_BUSIN_RUDETATON_39242");  //se muestra el campo Destino solicitado
        }
        if(task.isAnalisis() && task.isReprogramming()){
			ctrs = ['VA_ORIAHEADER8602_OQUE134','VA_OFICANSSEW2603_CRTN299','VA_OFICANSSEW2603_POCT250','VA_OFICANSSEW2603_PONE992','VA_OFICANSSEW2603_CITY183',
					'VA_OFICANSSEW2603_ORNG078','VA_RIOTRDTAVI4904_TATT517','VA_RIOTRDTAVI4904_RDTN715','VA_RIOTRDTAVI4904_DSNS029','VA_ORIAHEADER8602_URQT595',
					'VA_RIOTRDTAVI4904_EDSN666'];
            BUSIN.API.disable(viewState,ctrs);//se desahabilita campos Provincia,CIudad y Sector del Credito
            grid.showToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');
            grid.showToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992'); //Muestra el Boton Nuevo en Reprogramacion
            grid.showToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
            grid.showToolBarButton('QV_BOREG0798_55', 'create');
            BUSIN.API.readOnlyAsync(renderEventArgs,['VA_OFICANSSEW2603_CITY183'],true,2000); //Ciudad
			viewState.show('VA_RIOTRDTAVI4907_EDNE010');
        }
        if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
            ctrs = ['VA_ORIAHEADER8602_EVAL957','VA_ORIAHEADER8602_CRET312'];
            BUSIN.API.show(viewState,ctrs);
			BUSIN.API.enableAsync(renderEventArgs,ctrs,1200);
            viewState.hide('VA_OFICANSSEW2603_SCOR371');
            viewState.disable('VA_OFICANSSEW2603_CRTN299');

            var viewState = renderEventArgs.commons.api.viewState, template;
            var template = '<span><h4>#: value#</h4></span>' + '<span><b>Monto:</b> #: attributes[0] #</span> - '+ '<span><b>Disponible:</b> #: attributes[1] #</span> - '+'<span><b>Moneda:</b> #: attributes[2] #</span>';
            viewState.template('VA_ORIAHEADER8602_EVAL957', template);
            BUSIN.API.GROUP.selectTab('GR_RIOTRDTAVI49_03',1, renderEventArgs.commons.api);

		    viewState.show('VA_ORIAHEADER8602_TERM237');
		    viewState.enable('VA_ORIAHEADER8602_TERM237');
			viewState.label("VA_ORIAHEADER8602_CRET312", "BUSIN.DLB_BUSIN_RUDETATON_39242");
        }
        if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Analisis && task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing){
            ctrs = ['VA_ORIAHEADER8602_EVAL957','GR_RIOTRDTAVI49_12','VA_ORIAHEADER8602_OQUE134','VA_ORIAHEADER8602_RUCE927','VA_ORIAHEADER8602_GCUN722'];
            BUSIN.API.show(viewState,ctrs);
            BUSIN.API.disable(viewState,ctrs);
			viewState.readOnly('VA_ORIAHEADER8602_RUCE927', false);
			viewState.readOnly('VA_ORIAHEADER8602_GCUN722', false);

            viewState.show('GR_RIOTRDTAVI49_11'); // Pestaña Distribucion de Linea, Moneda -- ady

			//Pestania de Distribución de Líneas oculta para cuando refinanciamiento no es de linea -- 	ACH
			if(entities.OriginalHeader.CreditLineValid != null){
			    BUSIN.API.show(viewState,['GR_RIOTRDTAVI49_11']);
				viewState.enable('GR_RIOTRDTAVI49_12');
			}else{
			    BUSIN.API.hide(viewState,['GR_RIOTRDTAVI49_11']);
				BUSIN.API.hide(viewState,['GR_RIOTRDTAVI49_12']);
				BUSIN.API.disable(viewState,['GR_RIOTRDTAVI49_12'])
			}

            /*Deshabilitando validacion de campos requeridos en pestaña oculta Validacion de Cuota Vs. Saldo Disponible*/
            viewState.disableValidation('VA_RIOTRDTAVI4912_MAMU147',VisualValidationTypeEnum.Required);
            BUSIN.API.setDisabled(viewState,entities.LineHeader.Rotary=='S',['VA_RIOTRDTAVI4912_TERM010']);
			viewState.readOnly('VA_OFICANSSEW2603_ORNG078',true); //desabilita el obligatorio y la edición del campo sector del credito
			
			var ctrs1 = ['VA_RIOTRDTAVI4904_RPPU470'];
		    BUSIN.API.enable(viewState,ctrs1); // ACHP
        }
		OTHERCREDITDATA.disableElements(entities, renderEventArgs,task.TypeProcessed); // para deshabilitar si viene el sector vacio
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
    //**********************************************************
    //  Metodos privados
    //**********************************************************
    task.clearHeaderData = function(entities) {
        flagSelectionOper = 0;
        entities.OriginalHeader.AmountRequested = null;
        entities.OriginalHeader.CurrencyRequested = null;
    };
    task.clearHeaderDataByBase = function(entities) {
        entities.OfficerAnalysis.SerctorNeg = null;
        entities.OfficerAnalysis.CreditLine = null;
        entities.CreditOtherData.CreditPorpuse = null;
        entities.CreditOtherData.CreditDestination=null;
        entities.CreditOtherData.ActivityDestinationCredit=null;
        entities.CreditOtherData.DescriptionDestinationRequested=null;

    };
    task.hasOperations = function(entities, eventArgs) { //VALIDA SI TIENE OPERACIONES A EXPROMISIONAR
        var notOperations = (entities.RefinancingOperations==null || entities.RefinancingOperations.data().length==0);
        if(notOperations){
            eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ANRSRAPRA_09435');
        }
        return !notOperations;
    };
    task.hasBaseOperations = function(entities, eventArgs) { //VALIDA SI TIENE OPERACION BASE
        var rowSelected = false;
        if(entities.RefinancingOperations!=null && entities.RefinancingOperations.data().length>0){
            var regs = entities.RefinancingOperations.data();
            for (var i = 0; i < regs.length; i++) {
                if(regs[i].IsBase)
                    rowSelected = true;
            }
            if(!rowSelected){
                eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ECRPRAPOS_64241',null,2000);
            }
        }
        return rowSelected;
    };
    task.isReprogramming = function() { return task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Reprogramming;};
    task.isRefinancing = function() { return task.TypeProcessed === FLCRE.CONSTANTS.RequestName.Refinancing;};
    task.isEntry = function() { return task.EtapaTramite === FLCRE.CONSTANTS.Stage.Entry;};
    task.isAnalisis = function() { return task.EtapaTramite === FLCRE.CONSTANTS.Stage.Analisis;};

}());

RefinancingOperations = function(IdOperation){
    this.IdOperation = IdOperation;
}


