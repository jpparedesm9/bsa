<!-- Designer Generator v 5.0.0.1509 - release SPR 2015-09 15/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.operationsearch;
    task.AddCustomerCode = false;
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //CustomerSearch.Customer (TextInputButton) View: CustomerSearchView
    task.executeCommand.VA_TOMERSHVIW6014_CSER255 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
    };

	//CustomerSearch.Search (Button) View: CustomerSearchView
    task.executeCommand.VA_TOMERSHVIW6014_CTRD054 = function(entities, executeCommandEventArgs) {
		
    	//Recupero Cliente
    	var customer = executeCommandEventArgs.commons.api.vc.model.CustomerSearch;
    	
    	//Recupero parametros desde la vc padre
		var customDialogParameters = executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters();
		if (customDialogParameters!=null) {
			entities.Operations =  customDialogParameters.operations;
		}
		
		//Envio a buscar las operaciones del cliente
		if(customer.CustomerId != null) {
			executeCommandEventArgs.commons.execServer = true;
		}else {
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OSEEOULIN_28612');
			executeCommandEventArgs.commons.execServer = false;
		}
    };

    //CustomerSearch.Customer (TextInputButton) View: CustomerSearchView
    task.textInputButtonEvent.VA_TOMERSHVIW6014_CSER255 = function(textInputButtonEventArgs) {
		textInputButtonEventArgs.commons.execServer = false;
		// var grid = textInputButtonEventArgs.commons.api.grid;
		// if(textInputButtonEventArgs.model.RefinancingOperations.data().length > 0){
		// grid.removeAllRows('RefinancingOperations');
		// }
		BUSIN.API.getNavigationFindCustomer(textInputButtonEventArgs.commons.api);
    };

	task.closeModalEvent.findCustomer = function (args) {
		var dialog = args.commons.api.vc.dialogParameters;
		var customer = args.commons.api.vc.model.CustomerSearch;
		customer.CustomerId = dialog.CodeReceive;
		if(dialog.commercialName !== ''){
			customer.Customer = dialog.commercialName;
		}
		else{
			customer.Customer = dialog.name;
		}
	};
	
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //select (Button)
    task.executeCommand.CM_OSRCH32SCT35 = function(entities, executeCommandEventArgs) {
    	
    	executeCommandEventArgs.commons.execServer = false;

    	//Entidades Temporales
    	entities.Operations ={};
    	entities.GeneralParameters = {};
    	entities.SelectedOperations = [];
    	entities.Debtors = [];
    	
    	executeCommandEventArgs.commons.serverParameters.Debtors = true;
    	executeCommandEventArgs.commons.serverParameters.Operations = true;
    	executeCommandEventArgs.commons.serverParameters.GeneralParameters = true;
    	executeCommandEventArgs.commons.serverParameters.SelectedOperations = true;
    	
    	//Recupero parametros desde la vc padre
		var customDialogParameters = executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters();
		if (customDialogParameters!=null) {
			entities.Operations =  customDialogParameters.operations;
			entities.GeneralParameters = customDialogParameters.generalParameters;
		}
    	
    	//Recupero las filas seleccionadas del grid y las almaceno en la entidad temporal
    	var rows = executeCommandEventArgs.commons.api.grid.getSelectedRows('QV_ITRIC1523_25');
    	if (rows!=null && rows.length>0) {
			for(var j = 0; j < rows.length; j++){
				rows[j].checkRule = false;
				entities.SelectedOperations.push(rows[j]);
			}
			executeCommandEventArgs.commons.execServer = true;
		}else {
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ELCNEUNAR_05370',null,5000);
		}
    };
    
     //select Callback (Button)
     task.executeCommandCallback.CM_OSRCH32SCT35 = function(entities, executeCommandCallbackEventArgs) {
    	 
    	 //Declaro las variables para enviar a la vista padre
    	 var operations = [];
    	 var debtors = [];
    	 
    	 //Almaceno en arreglo operations las operaciones que cumplieron y excepcionaron
    	 for (var i = 0; i < entities.SelectedOperations.length; i++) {
			if (entities.SelectedOperations[i].checkRule) {
				operations.push(entities.SelectedOperations[i]);
			}
    	 }
    	 
    	//Almaceno en arreglo debtors los deudores que el CustomerCode sea diferente de null
    	 for (var i = 0; i < entities.Debtors.length; i++) {
 			if (entities.Debtors[i].CustomerCode != null) {
 				entities.Debtors[i].TypeDocumentId = "03";
 				if (entities.Debtors[i].Identification.length==10) {
 					entities.Debtors[i].TypeDocumentId = "01";
				}else if (entities.Debtors[i].Identification.length==13) {
					entities.Debtors[i].TypeDocumentId = "02";
				}
 				debtors.push(entities.Debtors[i]);
 			}
     	 }
    	 
    	 //Creo el objeto que se va enviar  como respuesta
    	 var result ={operations : operations,
    			 	  debtors : debtors	}
    	 
		 executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);
    	 
     };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //SelectOperation QueryView: GridRefinancingOperations
    task.gridRowSelecting.QV_ITRIC1523_25 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

	 //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: operationSearch
    task.initData.VC_OSRCH32_AOEAR_233 = function(entities, initDataEventArgs) {
    	
    	//Entidad Temporal
    	entities.Operations = {} ;
    	
    	//Recupero datos enviado por parametros
    	var customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
    	
    	//Verifico si tiene el cliente
    	if (customDialogParameters != null && customDialogParameters.debtor != null) {
    		
        	var debtor =  customDialogParameters.debtor;
        	entities.Operations =  customDialogParameters.operations;
			var generalParameters = customDialogParameters.generalParameters;
        	
        	if(debtor != null && debtor.Role=="D") {
        		entities.CustomerSearch.CustomerId = debtor.CustomerCode;
        		entities.CustomerSearch.Customer = debtor.CustomerName;
				if (generalParameters.enableSearchClients != undefined && generalParameters.enableSearchClients == false){
					initDataEventArgs.commons.api.viewState.disable("VA_TOMERSHVIW6014_CSER255");
				}else{
					initDataEventArgs.commons.api.viewState.enable("VA_TOMERSHVIW6014_CSER255");
				}
        		initDataEventArgs.commons.execServer = true;
    		} else {
    			initDataEventArgs.commons.execServer = false;
    		}
		} else {
			initDataEventArgs.commons.execServer = false;
		}
    	
    };

    //ViewContainer: operationSearch
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
        var columns = ['IdOperation', 'RefinancingOption', 'IsBase', 'oficialOperation','Rate','InternalCustomerClassification','Payment','CreditType'];
		BUSIN.API.GRID.hideColumns('QV_ITRIC1523_25', columns, renderEventArgs.commons.api);
		
   	 	var columns = ['OperationBank','CurrencyOperation','Balance','LocalCurrencyBalance','OriginalAmount','LocalCurrencyAmount','CreditType','InternalCustomerClassification',
    	            'DateGranting','IdOperation','RefinancingOption','IsBase','Rate','ExpirationDate','State','TypeOperation'];
    	BUSIN.API.GRID.addColumnsStyle('QV_ITRIC1523_25', 'Grid-Column-Header',renderEventArgs.commons.api,columns);
    	
    	//Se define el tamaño de la columna
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'OperationBank', 110);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'CurrencyOperation', 100);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'Balance', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'LocalCurrencyBalance', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'OriginalAmount', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'LocalCurrencyAmount', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'CreditType', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'InternalCustomerClassification', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'DateGranting', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'IdOperation', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'RefinancingOption', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'IsBase', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'Rate', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'ExpirationDate', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'State', 90);
    	
    };

}());