<!-- Designer Generator v 5.0.0.1510 - release SPR 2015-10 29/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskexpdisbursementform;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //LoanHeader.BalanceOperation (TextInputBox) View: DisbursementForms 
    task.change.VA_DISURMETFR5106_BAIO267 = function(entities, changedEventArgs) {
       changedEventArgs.commons.execServer = false;
		 var parentApi = changedEventArgs.commons.api.parentApi();
		 var parentVc = parentApi.vc;
		 
		 //Valida si saldo es 0 para habilitar boton continuar
		 if(entities.LoanHeader.BalanceOperation == 0){			
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		 }else{
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		 }
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 
    //QueryView: GridDisbursementDetail 
    task.gridInitDetailTemplate.QV_TSRSE1342_26 = function(entities, gridInitDetailTemplateArgs) {
         // gridInitDetailTemplateArgs.commons.execServer = false;
		 gridInitDetailTemplateArgs.commons.execServer = false;
		
		
		var nav = gridInitDetailTemplateArgs.commons.api.navigation;
        var api = gridInitDetailTemplateArgs.commons.api;                        
        nav.customDialogParameters = { 
			currency: entities.LoanHeader.Currency,
			balanceOperation: entities.LoanHeader.BalanceOperation,
			priceQuote: entities.LoanHeader.PriceQuote,
			operationBanck: entities.LoanHeader.Operation,
			clientId: entities.LoanHeader.CustomerId,
			arrayDisbursementDetail: entities.DisbursementDetail//aqui
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

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //delete QueryView: GridDisbursementDetail 
    task.gridRowDeleting.QV_TSRSE1342_26 = function(entities, gridRowDeletingEventArgs) {
         if(gridRowDeletingEventArgs.rowData.Currency == "" && gridRowDeletingEventArgs.rowData.DisbursementForm == "" && gridRowDeletingEventArgs.rowData.DisbursementValue == 0 && gridRowDeletingEventArgs.rowData.PriceQuote == 0){
			gridRowDeletingEventArgs.commons.execServer = false;
		}else{
			gridRowDeletingEventArgs.commons.execServer = true;
		}	 
    };
	
	task.gridRowDeletingCallback.QV_TSRSE1342_26 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
		if(gridRowDeletingEventArgs.success == true){
			entities.LoanHeader.BalanceOperation = entities.LoanHeader.BalanceOperation + gridRowDeletingEventArgs.rowData.AmountMOP;
		}
		var d=0;
   };

    //RowSelLiquidateValue QueryView: GridDetailLiquidateValues 
    task.gridRowSelecting.QV_TDLIA9011_50 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //NewForm (ImageButton) QueryView: GridDisbursementDetail 
    task.gridCommand.CEQV_201_QV_TSRSE1342_26_253 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
		var api = gridExecuteCommandEventArgs.commons.api, dsData, dsRow;
		
		/*Validando si se ha agregado un registro vacio al grid y eliminarlo*/
		var ds = gridExecuteCommandEventArgs.commons.api.vc.model['DisbursementDetail'];
		var flag = 0;
		var dsData = ds.data();
		for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];			
			if(dsRow.Currency == "" && dsRow.DisbursementForm == "" && dsRow.DisbursementValue == 0 && dsRow.PriceQuote == 0){
				//flag = 1;
				api.grid.removeRow('DisbursementDetail', i);
            /*if(dsRow.DisbursementForm == productDisbursement){
				flag = 1;
				break;*/
            };			
		};
		
		/*if(flag == 1){
			return;
		}else{			*/
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

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormExpDisbursement 
    task.initData.VC_SUMNF62_FXUSN_876 = function(entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters; 
		entities.LoanHeader.Operation = 701;//parentParameters.Task.processInstanceIdentifier;
		
		//Obteniendo cliente del inbox
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.LoanHeader.Customer = client.clientName;
		entities.LoanHeader.CustomerId = client.clientId;

		//entities.LoanHeader.Operation=253;
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_PTTP830");
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_CURR863");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UOBU373"); 
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_FFIE451"); 
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UOBU373");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UUNT712");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_USMR660");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_PIQO508");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_OMUT564");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_IIAT392");	 
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_IIAT392"); 
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_ATBS598");	
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_BAIO267");		
		
		
		//initDataEventArgs.commons.api.viewState.addStyle('QV_TSRSE1342_26', 'grupo-lectura');
		//DESEMBOLSO BAJO LINEA CREDITO
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' && 
		    client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' ){
			entities.LoanHeader.NumberLine = client.bussinessInformationStringOne;						
			BUSIN.API.show(initDataEventArgs.commons.api.viewState , ['VA_DISURMETFR5106_UERE335']);
			initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UERE335");
		}
		initDataEventArgs.commons.execServer = true;	
    };	
	
	//ViewContainer: FormExpDisbursement 
    task.render = function(entities, renderEventArgs) {
         renderEventArgs.commons.execServer = false;		 
		 //renderEventArgs.commons.api.vc.viewState.QV_TSRSE1342_26.toolbar.CEQV_201_QV_TSRSE1342_26_253.visible = false;

    };
	
	task.initDataCallback.VC_SUMNF62_FXUSN_876 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.execServer = false;
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		//Valida si saldo es 0 para habilitar boton continuar
		if(entities.LoanHeader.BalanceOperation == 0){			
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		 }else{
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		 }
	};

}());