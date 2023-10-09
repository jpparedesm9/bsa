<!-- Designer Generator v 5.0.0.1505 - release SPR 2015-05 20/03/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.guaranteessearch;
	var guareanteeDialogParameters;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //.SaerchButton (Button) View: GuaranteesSearch
    task.executeCommand.VA_WRRNTSEACH8507_0000044 = function(entities, executeCommandEventArgs) {
		entities.GuaranteeSearchCriteria.CorrelativeEnd =1;
		//if(entities.GuaranteeSearchCriteria.Office==undefined){
      //   executeCommandEventArgs.commons.execServer = false;
		// executeCommandEventArgs.commons.messageHandler.showMessagesInformation('Criterio de Oficina es Obligatorio');
		// }else{
		 executeCommandEventArgs.commons.execServer = true;
		// }
    };
	 task.executeCommandCallback.VA_WRRNTSEACH8507_0000044 = function(entities, executeCommandCallbackEventArgs) {
	  entities.Guarantees.page(1);
	//Ajusta el tamaño de las cabeceras al campo de la grilla
 	 	var columns = ['GuaranteeCode','GuaranteeType','Description','CloseOpen','GuarantorId','CustomerId','GuarantorName','Custody',
     	            'Office','OfficeName','Currency','CurrentValue','InitialValue','ValueAvailable','AppraisedValueDate','ExpiredWarranty','Status','UserCreation'];
     	BUSIN.API.GRID.addColumnsStyle('QV_QURAR0892_86', 'Grid-Column-Header',executeCommandCallbackEventArgs.commons.api,columns);
    };
     //.NextGuarantees (Button) View: GuaranteesSearch
    task.executeCommand.VA_WRRNTSEACH8507_0000435 = function(entities, executeCommandEventArgs) {
		entities.GuaranteeSearchCriteria.CorrelativeEnd =2;
         executeCommandEventArgs.commons.execServer = true;
    };
	task.executeCommandCallback.VA_WRRNTSEACH8507_0000435 = function(entities, executeCommandCallbackEventArgs) {
	  var page = Math.round(entities.Guarantees.data().length / entities.Guarantees.pageSize());
	  entities.Guarantees.page(page);
	  //Ajusta el tamaño de las cabeceras al campo de la grilla
	 	var columns = ['GuaranteeCode','GuaranteeType','Description','CloseOpen','GuarantorId','CustomerId','GuarantorName','Custody',
   	            'Office','OfficeName','Currency','CurrentValue','InitialValue','ValueAvailable','AppraisedValueDate','ExpiredWarranty','Status','UserCreation'];
   	  BUSIN.API.GRID.addColumnsStyle('QV_QURAR0892_86', 'Grid-Column-Header',executeCommandCallbackEventArgs.commons.api,columns);
    };

    //GuaranteeSearchCriteria.Officer (ComboBox) View: GuaranteesSearch
    task.loadCatalog.VA_WRRNTSEACH8505_OFIR555 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };

    //GuaranteeSearchCriteria.GuaranteeType (ComboBox) View: GuaranteesSearch
    task.loadCatalog.VA_WRRNTSEACH8505_RTTY100 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
    };

    //GuaranteeSearchCriteria.Customer (TextInputButton) View: GuaranteesSearch
    task.textInputButtonEvent.VA_WRRNTSEACH8505_CUOM537 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
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
										"/customer/controllers/find-customers-ctrl.js"]
		}];
		nav.customDialogParameters = {
		};
    };

    task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        //var CustomerName=  args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;        
        //args.model.GuaranteeSearchCriteria.Customer = customerCode +"-"+ CustomerName;
        args.model.GuaranteeSearchCriteria.Customer = customerCode;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Choose (Button)
    task.executeCommand.CM_GURNH31OOS11 = function(entities, executeCommandEventArgs) {
		var selectedRows = executeCommandEventArgs.commons.api.grid.getSelectedRows('QV_QURAR0892_86');
		if( BUSIN.VALIDATE.IsNull(selectedRows) || selectedRows.length===0 ){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_ELCNEUNAR_05370',null,5000);
			return;
		}else if (executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().maxRelation && selectedRows[0].relation ){
			if(selectedRows[0].relation<executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().maxRelation){			
				executeCommandEventArgs.commons.execServer = false;
				executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_LERELTSHI_68262',null,5000);
				return;
			}
		}
		
		executeCommandEventArgs.commons.execServer = true;
    };

    task.executeCommandCallback.CM_GURNH31OOS11 = function(entities, executeCommandCallbackEventArgs) {
		if(executeCommandCallbackEventArgs.success){
			//BANDERA QUE INDICA SI EL TIPO DE GARANTIA ES PERSONAL
		    var result = {parameterGuarantee: guareanteeDialogParameters }
			executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);
		}
     };

	 //**********************************************************
    //  Eventos de QUERY
    //**********************************************************
    //QueryGuarantee  Entity: Guarantees
    task.executeQuery.Q_QURARRNT_0892 = function(executeQueryEventArgs) {
        executeQueryEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormGuaranteesSearch
    task.initData.VC_GURNH31_OMREA_904 = function(entities, initDataEventArgs) {
         initDataEventArgs.commons.execServer = false;
       var api = initDataEventArgs.commons.api;
		 var customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
		 entities.WarrantieComext.currencyComext = customDialogParameters.operationComext;
       
       api.vc.viewState.VA_WRRNTSEACH8505_OFIR555.visible = false;
       api.vc.viewState.VA_WRRNTSEACH8505_NAOD344.visible = false;
       api.vc.viewState.VA_WARRANTYMONEYYY_531H85.visible = false;
       api.vc.viewState.VA_WRRNTSEACH8505_DAMS278.visible = false;
       api.vc.viewState.VA_WRRNTSEACH8505_DSIT654.visible = false;
       api.vc.viewState.VA_CHARACTERXARFCC_916H85.visible = false;
       api.vc.viewState.VA_AMOUNTJOGOYWOLN_543H85.visible = false;
       api.vc.viewState.VA_ADMISSIBILITYYY_972H85.visible = false;
       api.vc.viewState.VA_SHAREDYBHVSIQMI_498H85.visible = false;
       
       
       
    };
    
	task.gridRowSelecting.QV_QURAR0892_86 = function(entities, gridRowSelectingEventArgs) {
		var rowData = gridRowSelectingEventArgs.rowData;
	    guareanteeDialogParameters = rowData;
		entities.WarrantieComext.warrantieType = rowData.GuaranteeType;
		entities.WarrantieComext.currencyWarrantie = rowData.Currency;
        gridRowSelectingEventArgs.commons.execServer = false;
    };
    
    task.change.VA_ADDITIONALCRAEA_272H85 = function(  entities, changedEventArgs ) {
    changedEventArgs.commons.execServer = false;
    var api = changedEventArgs.commons.api;
        if (entities.WarrantieComext.additionalCriteria == true)
        {
            api.vc.viewState.VA_WRRNTSEACH8505_OFIR555.visible = true;
            api.vc.viewState.VA_WRRNTSEACH8505_NAOD344.visible = true;
            api.vc.viewState.VA_WARRANTYMONEYYY_531H85.visible = true;
            api.vc.viewState.VA_WRRNTSEACH8505_DAMS278.visible = true;
            api.vc.viewState.VA_WRRNTSEACH8505_DSIT654.visible = true;
            api.vc.viewState.VA_CHARACTERXARFCC_916H85.visible = true;
            api.vc.viewState.VA_AMOUNTJOGOYWOLN_543H85.visible = true;
            api.vc.viewState.VA_ADMISSIBILITYYY_972H85.visible = true;
            api.vc.viewState.VA_SHAREDYBHVSIQMI_498H85.visible = true;
        }else{
           api.vc.viewState.VA_WRRNTSEACH8505_OFIR555.visible = false;
           api.vc.viewState.VA_WRRNTSEACH8505_NAOD344.visible = false;
           api.vc.viewState.VA_WARRANTYMONEYYY_531H85.visible = false;
           api.vc.viewState.VA_WRRNTSEACH8505_DAMS278.visible = false;
           api.vc.viewState.VA_WRRNTSEACH8505_DSIT654.visible = false;
           api.vc.viewState.VA_CHARACTERXARFCC_916H85.visible = false;
           api.vc.viewState.VA_AMOUNTJOGOYWOLN_543H85.visible = false;
           api.vc.viewState.VA_ADMISSIBILITYYY_972H85.visible = false;
           api.vc.viewState.VA_SHAREDYBHVSIQMI_498H85.visible = false;  
           entities.GuaranteeSearchCriteria.warrantyMoney = ""           
           entities.GuaranteeSearchCriteria.Officer = ""           
           entities.GuaranteeSearchCriteria.character = ""           
           entities.GuaranteeSearchCriteria.amount = ""           
           entities.GuaranteeSearchCriteria.admissibility = ""           
           entities.GuaranteeSearchCriteria.shared = ""           
        }
        
    };

}());