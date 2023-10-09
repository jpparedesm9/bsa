/*global designerEvents, console */
(function () {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola
    //  console.log("executeCommand");

    //  Para enviar mensaje use
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************

    var task = designerEvents.api.taskdisbursementform;

//"TaskId": "T_FLCRE_76_SDEEF25"
task.EtapaTramite = '';
task.Etapa = '';
var taskHeader = {};
task.creditType=undefined;
var typeRequest = '';

task.hideModeQuery = function(args) {
		
		//Variables
		var api = args.commons.api;
		var detailLiquidateValuesDs = api.vc.model['DisbursementDetail'].data();

		//Deshabilito los botones
		args.commons.api.grid.hideToolBarButton('QV_TSRSE1342_26', 'CEQV_201_QV_TSRSE1342_26_253');
		BUSIN.API.GRID.hideCommandColumns('QV_TSRSE1342_26',detailLiquidateValuesDs,api,'delete');
		
		//Set del campo HiddenInCompleted para poder continuar la tarea
		args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			
	};

task.loadTaskHeader=function(entities,eventArgs){
		
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.LoanHeader;
		var contextAux = entities.Context;
						
		//Titulo de la cabecera (title)
		if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
			LATFO.INBOX.addTaskHeader(taskHeader,'title', client.clientId +" - "+ client.clientName);
		}else{
			LATFO.INBOX.addTaskHeader(taskHeader,'title', client.clientName);		
		}
    
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.Operation==null||originalh.Operation=='null' ? '--':originalh.Operation),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);		
		if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
			LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((contextAux.amountRequested == null|| contextAux.amountRequested == 'null' ? 0 : contextAux.amountRequested), 2), 0);
		}else{
			LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null|| originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);  
		}
		LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', BUSIN.CONVERT.CURRENCY.Format((originalh.ProposedAmount == null|| originalh.ProposedAmount == 'null' ? 0 : originalh.ProposedAmount), 2), 0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',entities.generalData.Term,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((entities.generalData.officerName!="--")?entities.generalData.officerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
	//	LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);
		if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
			LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', contextAux.cycleNumber, 1);
		}
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};


	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: taskDisbursementForm
    task.initData.VC_SDEEF25_BREOM_121 = function(entities, initDataEventArgs) {	
        entities.LoanHeader.OfficeId = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.LoanHeader.ProcessNumber = parentParameters.Task.processInstanceIdentifier;
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		//Obteniendo cliente del inbox
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";		
		entities.generalData.officerName = "";
		entities.LoanHeader.Customer = client.clientName;
		entities.LoanHeader.CustomerId = client.clientId;
		typeRequest = parentParameters.Task.urlParams.SOLICITUD;

		//DESEMBOLSO BAJO LINEA CREDITO
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' &&
		    client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' ){
			entities.LoanHeader.NumberLine = client.bussinessInformationStringOne;						
		}
		initDataEventArgs.commons.execServer = true;
		
		if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
		}
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
			task.Etapa = parentParameters.Task.urlParams.ETAPA;
		}
        
         task.creditType=initDataEventArgs.commons.api.navigation.getCustomDialogParameters().Task.urlParams.SOLICITUD;
    
    };

	
//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: taskDisbursementForm
    task.initDataCallback.VC_SDEEF25_BREOM_121 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.execServer = false;
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		
		if(initDataEventArgs.success===true){
			if(entities.LoanHeader.BalanceOperation == 0){ //Valida si saldo es 0 para habilitar boton continuar
				BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
				//initDataEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitDisbursement.commitDisbursement';
			}
		}else{
			initDataEventArgs.commons.api.grid.hideToolBarButton('QV_TSRSE1342_26', 'CEQV_201_QV_TSRSE1342_26_253');//boton nuevo
			BUSIN.INBOX.STATUS.nextStep(false,initDataEventArgs.commons.api);
		}



		task.loadTaskHeader(entities,initDataEventArgs);
	};

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: taskDisbursementForm
    task.render = function(entities, renderEventArgs) {
		
		var viewState = renderEventArgs.commons.api.viewState;
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		
		//BANDERA QUE INDICA SI LAS 'FORMAS DE DESEMBOLSO' MARCADAS CON UN 'CODIGO' SE PUEDEN ELIMINAR O NO
		if(entities.LoanHeader.LockDelete===true) {
			var rows = entities.DisbursementDetail.data();
			for (var i = 0; i < rows.length; i++) {
                if(rows[i].DisbursementForm === entities.LoanHeader.LockCode) {
					renderEventArgs.commons.api.grid.hideGridRowCommand('QV_TSRSE1342_26', rows[i], 'delete');
				}
            }
		}
		
		if (parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == 'Q') {
    		task.hideModeQuery(renderEventArgs);
    	}
		
	};

	//Entity: LoanHeader
    //LoanHeader.BalanceOperation (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
        task.change.VA_DISURMETFR5106_BAIO644 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
		var parentApi = changedEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;

		//Valida si saldo es 0 para habilitar boton continuar
		if(entities.LoanHeader.BalanceOperation == 0){
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			//changedEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitDisbursement.commitDisbursement';
		}else{
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		}
    };

	//showGridRowDetailIcon QueryView: GridDisbursementDetail
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_TSRSE1342_26 = function (entities, showGridRowDetailIconEventArgs){
		var result=false;
		var row = showGridRowDetailIconEventArgs.rowData;
		if(row.Currency == "" && row.DisbursementForm == "" && row.DisbursementValue == 0 && row.PriceQuote == 0){
			result=true;
		}else{
			result=false;
		}
		return result;
	};

	//gridCommand (Button) QueryView: GridDisbursementDetail
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_TSRSE1342_26_253 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
		var api = gridExecuteCommandEventArgs.commons.api, dsData, dsRow;

		/*Validando si se ha agregado un registro vacio al grid y eliminarlo*/
		var ds = gridExecuteCommandEventArgs.commons.api.vc.model['DisbursementDetail'];
		
		var dsData = ds.data();
		for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
			if(dsRow.Currency == "" && dsRow.DisbursementForm == "" && dsRow.DisbursementValue == 0 && dsRow.PriceQuote == 0){	
				api.grid.removeRow('DisbursementDetail', i);            
            };
		};		
		if(entities.LoanHeader.BalanceOperation == 0){
			gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_YAOTIBURE_04675');
		}else{
			api.grid.addRow('DisbursementDetail',{DisbursementForm: '', Currency: '', DisbursementValue: 0, ValueMl: 0, PriceQuote: 0,DisbursementFormId:''});

			dsData = api.vc.model['DisbursementDetail'].data();
			dsRow = dsData[dsData.length-1];

			var uigrid = $('#' + 'QV_TSRSE1342_26').data('kendoGrid');
			uigrid.expandRow($("[data-uid=\'" + dsRow.uid + "\']"));
		}
		gridExecuteCommandEventArgs.commons.execServer = false;
    };

	//gridInitDetailTemplate QueryView: GridDisbursementDetail
        //
        task.gridInitDetailTemplate.QV_TSRSE1342_26 = function(entities, gridInitDetailTemplateArgs) {        
		 gridInitDetailTemplateArgs.commons.execServer = false;
		 
		var nav = gridInitDetailTemplateArgs.commons.api.navigation;
        var api = gridInitDetailTemplateArgs.commons.api;
        nav.customDialogParameters = {
			currency: entities.LoanHeader.Currency,
			balanceOperation: entities.LoanHeader.BalanceOperation,
			priceQuote: entities.LoanHeader.PriceQuote,			
			operationBanck: entities.LoanHeader.OperationBanck,
			clientId: entities.LoanHeader.CustomerId,
			arrayDisbursementDetail: entities.DisbursementDetail,//aqui
            creditType:task.creditType //Tipo de credito de acuerdo al flujo (GRUPAL,INTERCICLO,NORMAL)
        };
        nav.address = {
           moduleId: 'BUSIN',
           subModuleId: 'FLCRE',
           taskId: 'T_FLCRE_83_AUSMM61',
           taskVersion: '1.0.0',
           viewContainerId: 'VC_AUSMM61_MDSIC_473'
           };
        nav.openDetailTemplate('QV_TSRSE1342_26', gridInitDetailTemplateArgs.modelRow);
    };

	//gridRowDeleting QueryView: GridDisbursementDetail
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_TSRSE1342_26 = function(entities, gridRowDeletingEventArgs) {
		if(gridRowDeletingEventArgs.rowData.Currency == "" && gridRowDeletingEventArgs.rowData.DisbursementForm == "" && gridRowDeletingEventArgs.rowData.DisbursementValue == 0 && gridRowDeletingEventArgs.rowData.PriceQuote == 0){
			gridRowDeletingEventArgs.commons.execServer = false;
		}else{
			gridRowDeletingEventArgs.commons.execServer = true;
		}
    };

	//Start signature to callBack event to QV_TSRSE1342_26
    task.gridRowDeletingCallback.QV_TSRSE1342_26 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
		if(gridRowDeletingEventArgs.success == true){
			entities.LoanHeader.BalanceOperation = entities.LoanHeader.BalanceOperation + gridRowDeletingEventArgs.rowData.AmountMOP;
		}
		var d=0;
   };

	//gridRowSelecting QueryView: GridDetailLiquidateValues
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_TDLIA9011_50 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
   };


}());