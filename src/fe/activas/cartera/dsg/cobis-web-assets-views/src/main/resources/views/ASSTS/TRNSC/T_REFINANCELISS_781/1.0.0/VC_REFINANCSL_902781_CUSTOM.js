/* variables locales de T_REFINANCELISS_781*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

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

    
        var task = designerEvents.api.refinanceloansfilter;
    

    //"TaskId": "T_REFINANCELISS_781"

    //Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.additionalValue (TextInputBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ADDITIONALVAUUU_896515 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
            entities.RefinanceLoanFilter.capitalBalance = 0;
        entities.RefinanceLoanFilter.interestBalance = "";        
        entities.RefinanceLoanFilter.otherBalance = 0;
        entities.RefinanceLoanFilter.aditionalBalance = 0;
        var additionalValue = entities.RefinanceLoanFilter.additionalValue;
        var totalRefinance  = 0;
        
        for (var i = 0; i < entities.RefinanceLoans._data.length; i++) {
            entities.RefinanceLoanFilter.capitalBalance = entities.RefinanceLoanFilter.capitalBalance + entities.RefinanceLoans._data[i].capitalBalance
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].capitalBalance;            
            entities.RefinanceLoanFilter.otherBalance = entities.RefinanceLoanFilter.otherBalance + entities.RefinanceLoans._data[i].interestBalance;
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].interestBalance;
            entities.RefinanceLoanFilter.otherBalance = entities.RefinanceLoanFilter.otherBalance + entities.RefinanceLoans._data[i].defaultBalance
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].defaultBalance;
            entities.RefinanceLoanFilter.otherBalance = entities.RefinanceLoanFilter.otherBalance + entities.RefinanceLoans._data[i].otherConceptsBalance
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].otherConceptsBalance;
            
        }
        totalRefinance  = totalRefinance + additionalValue;
        totalRefinance = kendo.toString(totalRefinance, "n2"); 
        additionalValue = kendo.toString(additionalValue, "n2"); 
        entities.RefinanceLoanFilter.aditionalBalance = additionalValue;
        entities.RefinanceLoanFilter.totalRefinance = totalRefinance
        
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyType (ComboBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_CURRENCYTYPETLZ_990515 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        entities.RefinanceLoanFilter.currencyTypeAux = entities.RefinanceLoanFilter.currencyType;
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyTypeAux (ComboBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_CURRENCYTYPEUXU_869515 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var catalogData = changeEventArgs.commons.api.vc.catalogs.VA_CURRENCYTYPEUXU_869515._data;
        var currencySymbol = '';
        for (var i = 0; i <= catalogData.length - 1; i++) {
            if (catalogData[i].code == entities.RefinanceLoanFilter.currencyTypeAux) {
                currencySymbol = catalogData[i].value;
                break;
            }
        }
        entities.RefinanceLoanFilter.newLoanCurrency = currencySymbol;
        entities.RefinanceLoanFilter.payMethodCurrency = currencySymbol;
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.operationType (ComboBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OPERATIONTYPEEE_619515 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.refreshData (CheckBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFRESHDATALBDM_867515 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = true;
    
        //changedEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };

// (Button) 
    task.executeCommand.CM_TREFINAN_9NC = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var msgResourceID = "";
        var hasError = false;
        
        if (entities.RefinanceLoanFilter.additionalValue == null) 
            entities.RefinanceLoanFilter.additionalValue = 0;
            
        if (entities.RefinanceLoans._data.length == 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_NOEXISTRI_36661";
        }
        
        if (!hasError && (entities.RefinanceLoanFilter.operationType == null || entities.RefinanceLoanFilter.operationType == '')) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_ELCAMPOOR_72789";
        }
        
        if (!hasError && entities.RefinanceLoanFilter.totalRefinance <= 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_ELSALDOAU_44947";
        }
        
        if (!hasError && entities.RefinanceLoanFilter.additionalValue  < 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18739";
        }
        
        if (entities.RefinanceLoanFilter.additionalValue  > 0) {
            if (!hasError && (entities.RefinanceLoanFilter.addicionalPayMethod == null || entities.RefinanceLoanFilter.addicionalPayMethod == '')) {
                hasError = true;
                msgResourceID = "ASSTS.MSG_ASSTS_ELCAMPOLR_45229";
            }
            
            if (entities.RefinanceLoanFilter.addicionalPayMethod == 'NC_BCO_MN' || entities.RefinanceLoanFilter.addicionalPayMethod == 'NCAH'){
               if ( entities.RefinanceLoanFilter.account == null || entities.RefinanceLoanFilter.account == '' ){
                  hasError = true;
                  msgResourceID = "ASSTS.MSG_ASSTS_ELCAMPOLR_45230";   
               }               
            }
        }
                
        
        if (hasError) {           
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
        }else{
           executeCommandEventArgs.commons.execServer = true;
        }
    };

//Start signature to Callback event to CM_TREFINAN_9NC
task.executeCommandCallback.CM_TREFINAN_9NC = function(entities, executeCommandCallbackEventArgs) {
var viewState = executeCommandCallbackEventArgs.commons.api.viewState;        
     if (executeCommandCallbackEventArgs.success){         
         viewState.disable('CM_TREFINAN_9NC',true)
         viewState.disable('CM_TREFINAN_A4R',true);     
         viewState.show("VA_OPERATIONPZCOUQ_327515");         
         executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("ASSTS.LBL_ASSTS_SALDOOTOR_36723",true);
      }else{
         viewState.enable('CM_TREFINAN_9NC',false);
         viewState.enable('CM_TREFINAN_A4R',false);     
      }
};

// (Button) 
    task.executeCommand.CM_TREFINAN_A4R = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        var hasError = false;
        var msgResourceID = "";
        
        if (entities.RefinanceLoanFilter.clientID == null || entities.RefinanceLoanFilter.clientID == 0)  {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_DEDESELCA_14854"
        }
        if (!hasError && (entities.RefinanceLoanFilter.currencyType == null || entities.RefinanceLoanFilter.currencyType == '')) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_DEDESELNC_61580"
        }
        
        if (hasError) {
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
        }        
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RefinanceLoansFilter
    task.initData.VC_REFINANCSL_902781 = function (entities, initDataEventArgs){
        var viewState = initDataEventArgs.commons.api.viewState;
        viewState.hide("VA_OPERATIONPZCOUQ_327515");
        
        initDataEventArgs.commons.execServer = false;
        entities.RefinanceLoanFilter.totalRefinance = 0;
        entities.RefinanceLoanFilter.newLoanTerm = 0;
        entities.RefinanceLoanFilter.periodicity = 'MES(ES)';
        entities.RefinanceLoanFilter.newLoanCurrency = 'MX';
        entities.RefinanceLoanFilter.overDue = 'N/A';
        entities.RefinanceLoanFilter.capitalBalance = 0;
        entities.RefinanceLoanFilter.interestBalance = "";
        entities.RefinanceLoanFilter.arrearsBalance = 0;
        entities.RefinanceLoanFilter.otherBalance = 0;
        entities.RefinanceLoanFilter.aditionalBalance = 0;
        
        
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.addicionalPayMethod (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ADDICIONALPAYOH_649515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyType (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CURRENCYTYPETLZ_990515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyTypeAux (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CURRENCYTYPEUXU_869515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.operationType (ComboBox) View: RefinanceLoansFilter
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OPERATIONTYPEEE_619515 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.RefinanceLoanFilter = true;
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: RefinanceLoansFilter
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if(onCloseModalEventArgs.result.code !=null){
          entities.RefinanceLoanFilter.account = onCloseModalEventArgs.result.code.trim();
        }        
    };
    
    task.closeModalEvent.findCustomer = function (args) { 
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        var CustomerName=  args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;
        
        args.model.RefinanceLoanFilter.clientName  =  customerCode +"-"+ CustomerName;
        args.model.RefinanceLoanFilter.clientID  =  customerCode;
    };

task.textInputButtonEvent.VA_ACCOUNTYATVYIRL_740515 = function( textInputButtonEventArgs ) {
      textInputButtonEventArgs.commons.execServer = false;
      if (textInputButtonEventArgs.model.RefinanceLoanFilter.clientName != null && textInputButtonEventArgs.model.RefinanceLoanFilter.currencyType != null){
         var nav = textInputButtonEventArgs.commons.api.navigation;
			nav.address = {
				moduleId: "BUSIN",
				subModuleId: 'FLCRE',
				taskId: 'T_FLCRE_94_BYLET28',
				taskVersion: "1.0.0",
				viewContainerId: 'VC_BYLET28_DTBCT_453'
			};
			nav.queryParameters = { mode: textInputButtonEventArgs.commons.args.mode };			
         nav.label = cobis.translate('BUSIN.LBL_BUSIN_CUENTAARH_14595');
         nav.modalProperties = {
               size: 'lg'
         };
         nav.queryParameters = {
               mode: textInputButtonEventArgs.commons.constants.mode.Insert
         };
         var customerSearch = []
         customerSearch[0] = {Customer: textInputButtonEventArgs.model.RefinanceLoanFilter.clientName, CustomerId:textInputButtonEventArgs.model.RefinanceLoanFilter.clientID};
         nav.customDialogParameters = {
            customerSearch,
            warrantyGeneral:{currency:textInputButtonEventArgs.model.RefinanceLoanFilter.currencyType},
            warrantyType: "AHORRO",
            currencyCode: textInputButtonEventArgs.model.RefinanceLoanFilter.currencyType
         }; 
      }else{
         textInputButtonEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_CLIENTEWV_22562",true);
      }
    };

//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.clientName (TextInputButton) View: RefinanceLoansFilter
    
    task.textInputButtonEvent.VA_CLIENTNAMEBGXWU_198515 = function(textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        
        nav.label =cobis.translate('ASSTS.LBL_ASSTS_BSQUEDAEC_38534');
        nav.customAddress = {
                                   id: "findCustomer",
                                   url:"customer/templates/find-customers-tpl.html"
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

//gridRowDeleting QueryView: QV_3375_11342
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_3375_11342 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
        if (!entities.RefinanceLoanFilter.refreshData) {
            entities.RefinanceLoanFilter.refreshData = true;
        } else {
            entities.RefinanceLoanFilter.refreshData = false;
        }
    };



}));