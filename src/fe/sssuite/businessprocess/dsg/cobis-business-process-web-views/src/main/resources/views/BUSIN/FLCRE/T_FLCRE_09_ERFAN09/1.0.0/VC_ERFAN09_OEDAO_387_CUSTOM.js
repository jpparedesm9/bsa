<!-- Designer Generator v 5.1.0.1604 - release SPR 2016-04 04/03/2016 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.customerdataverification;
	var taskHeader = {};

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de cabecera.
    //  task.changeWithError.allGroup = true;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de grilla.
    //  task.changeWithError.allGrid = true;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Clarification QueryView: GridSourceRevenueCustomer 
    task.gridRowCommand.VA_RIOTRDTAVI4908_LRIN325 = function(entities, gridRowCommandEventArgs) {
          gridRowCommandEventArgs.commons.execServer = false;
        gridRowCommandEventArgs.commons.api.vc.serverParameters.SourceRevenueCustomer = true;
		var nav = gridRowCommandEventArgs.commons.api.navigation;
		nav.label =cobis.translate('BUSIN.DLB_BUSIN_TALAONAIV_74609');
        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_17_SEVNO59',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_SEVNO59_LSREU_678'
        };
        nav.customDialogParameters = {
            //detailSourceRevenue: entities['SourceRevenueCustomer']
			detailSourceRevenue:gridRowCommandEventArgs.rowData.detailClarification,
			detailSubActividadEconomica:gridRowCommandEventArgs.rowData.subActivityEconomic
        };

		nav.modalProperties = {
			//Hay 3 tamaños permitidos:  sm - pequeño, lg - grande, o si no se declara usa el mediano
			//size: 'sm',
			//opcionalmente se puede definir una altura
			//height: 350,
			//si es llamado desde un evento de grilla el valor es true
			callFromGrid: true
		};
		nav.openModalWindow('VA_RIOTRDTAVI4908_LRIN325', gridRowCommandEventArgs.rowData);
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Btn_Validate (Button) View: CreditOtherDataView
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_RIOTRDTAVI4912_0000847 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
         executeCommandEventArgs.commons.api.vc.serverParameters.ValidationQuotaVsAvailableBalance = true;
    };

    //Entity: FeeRate
    //FeeRate.Aceptar (Button) View: CreditOtherDataView
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_RIOTRDTAVI4913_0000660 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
         executeCommandEventArgs.commons.api.vc.serverParameters.FeeRate = true;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };    

    //Entity: CreditOtherData
    //CreditOtherData.ActivityDestinationCredit (ComboBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4904_TATT517 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.CreditOtherData = true;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Patrimony (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4909_ATRN190 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.IndexSizeActivity = true;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.PersonalNumber (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4909_PESL753 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.IndexSizeActivity = true;
    };

    //Entity: IndexSizeActivity
    //IndexSizeActivity.Sales (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4909_SALE147 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.IndexSizeActivity = true;
    };

    //Entity: DistributionLine
    //DistributionLine.AmountPurposed (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4911_AONO671 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.DistributionLine = true;
    };

    //Entity: DistributionLine
    //DistributionLine.Currency (ComboBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4911_CUCY652 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.DistributionLine = true;
    };

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4911_RITT092 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.DistributionLine = true;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.MaximumQuota (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4912_MAMU147 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.ValidationQuotaVsAvailableBalance = true;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Rate (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4912_RATE281 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.ValidationQuotaVsAvailableBalance = true;
    };

    //Entity: ValidationQuotaVsAvailableBalance
    //ValidationQuotaVsAvailableBalance.Term (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4912_TERM010 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.ValidationQuotaVsAvailableBalance = true;
    };

    //Entity: FeeRate
    //FeeRate.costCategory (ComboBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4913_CCGR378 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.FeeRate = true;
    };

    //Entity: FeeRate
    //FeeRate.percentageNew (TextInputBox) View: CreditOtherDataView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_RIOTRDTAVI4913_PRNT606 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.FeeRate = true;
    };

    //Entity: CustomerReference
    //CustomerReference.Result (CheckBox) View: CustomerReferenceView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_USTMRENCVW3903_0000448 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.CustomerReference = true;
    };    

    //Entity: CreditOtherData
    //CreditOtherData.CreditDestination (ComboBox) View: CreditOtherDataView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_RIOTRDTAVI4904_RDTN715 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.CreditOtherData = true;
    };

    //Entity: CreditOtherData
    //CreditOtherData.CreditPorpuse (ComboBox) View: CreditOtherDataView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_RIOTRDTAVI4904_RPPU470 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.CreditOtherData = true;
    };

    //Entity: CreditOtherData
    //CreditOtherData.ActivityDestinationCredit (ComboBox) View: CreditOtherDataView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_RIOTRDTAVI4904_TATT517 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.CreditOtherData = true;
    };

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: CreditOtherDataView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_RIOTRDTAVI4911_RITT092 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.DistributionLine = true;
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 


    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //InsertingRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos. 
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
         gridRowInsertingEventArgs.commons.api.vc.serverParameters.DistributionLine = true;
    };
	
    //UpdateRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
         gridRowUpdatingEventArgs.commons.execServer = false;
         gridRowUpdatingEventArgs.commons.api.vc.serverParameters.DistributionLine = true;
    };

    //RowUpdating QueryView: GridVariableData
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowUpdating.QV_QUERV3248_81 = function(entities, gridRowUpdatingEventArgs) {
         gridRowUpdatingEventArgs.commons.execServer = false;
         gridRowUpdatingEventArgs.commons.api.vc.serverParameters.VariableData = true;
    };

    //DeleteRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos. 
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = false;
         gridRowDeletingEventArgs.commons.api.vc.serverParameters.DistributionLine = true;
    };

    //SELECTING QueryView: GridCustomerReference
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_QURRF6164_42 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
         gridRowSelectingEventArgs.commons.api.vc.serverParameters.CustomerReference = true;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: customerDataValidationForm 
    task.initData.VC_ERFAN09_OEDAO_387 = function(entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
     	var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.UserL=userL;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;			
		entities.myParameters ={
			isProrroga : initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.bussinessInformationStringTwo=='P'?true:false,
			lineNumber : initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.bussinessInformationStringOne
		}
    };
	
	
	 task.initDataCallback.VC_ERFAN09_OEDAO_387 = function(entities, initDataEventArgs) {
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var api=initDataEventArgs.commons.api;
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
		if(entities.SourceRevenueCustomer.data().length==0){			
			var ctrsToHide = ['VC_ERFAN09_IVITY_872']
			BUSIN.API.hide(api.viewState,ctrsToHide);
		}	
		task.loadTaskHeader(entities,initDataEventArgs);		
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: customerDataValidationForm 
    task.render = function(entities, renderEventArgs) {
		var api = renderEventArgs.commons.api;				
    };
	
	

    //**********************************************************
    //  Eventos para Grupos
    //**********************************************************
    //Other Data (TabbedLayout)  View: CreditOtherDataView
    //Evento ChangeGroup: Evento change para pestañas, collapsible y accordion. 
    task.changeGroup.GR_RIOTRDTAVI49_03 = function(entities, changedGroupEventArgs) {
         changedGroupEventArgs.commons.execServer = false;
         changedGroupEventArgs.commons.api.vc.serverParameters.entityName = true;
        //if((changedGroupEventArgs.commons.item.id === 'GroupId') && (changedGroupEventArgs.commons.item.isOpen === true)){
        //console.log("Open by " + changedGroupEventArgs.commons.item.id);
        //}
    };
	
	task.loadTaskHeader=function(entities,eventArgs){
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.OriginalHeader;
		var plazo='';
		
		if(entities.OfficerAnalysis.Term==null||entities.OfficerAnalysis.Term==undefined){
			entities.OriginalHeader.Term=0;
			plazo='0';
		}else{
			entities.OriginalHeader.Term=entities.OfficerAnalysis.Term;
			plazo=entities.OriginalHeader.Term;
		}
		entities.OriginalHeader.CurrencyRequested=2;
		
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.IDRequested==null||originalh.IDRequested=='null' ? '--':originalh.IDRequested),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested ==null||originalh.AmountRequested =='null' ? 0:originalh.AmountRequested ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',plazo,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((originalh.OfficerName!=null)?originalh.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};
}());