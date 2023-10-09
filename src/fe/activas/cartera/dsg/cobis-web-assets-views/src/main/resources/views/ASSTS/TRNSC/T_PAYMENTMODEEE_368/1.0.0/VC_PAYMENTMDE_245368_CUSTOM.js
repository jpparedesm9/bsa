/* variables locales de T_PAYMENTMODEEE_368*/
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

    
        var task = designerEvents.api.paymentmodeform;
    

    //"TaskId": "T_PAYMENTMODEEE_368"

task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode = resp.CodeReceive;
        var CustomerName = resp.name;
        //var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        //var CustomerName=  args.commons.api.vc.dialogParameters.name;
        //var identification= args.commons.api.vc.dialogParameters.documentId;
        args.model.PaymentForm.clientFullName = customerCode +" - "+ CustomerName;
        args.model.PaymentForm.clientId = customerCode;
    };

    //Entity: PaymentForm
    //PaymentForm.economicDestination (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.Spacer1695 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        
    };

//Entity: PaymentForm
    //PaymentForm.officeId (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.Spacer2237 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        
    };

//Entity: PaymentForm
    //PaymentForm.payFormId (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.Spacer2675 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        var api = changeEventArgs.commons.api;
        if(changeEventArgs.newValue=="CHOTBCOS"){
            api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = true;
        }else{
            api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = false;
        }
        entities.PaymentForm.accountNumber = "";
    };

//Start signature to callBack event to Spacer2675
    task.changeCallback.Spacer2675 = function(entities, changeEventArgs) {
        //here your code
    };

//Entity: PaymentForm
    //PaymentForm.accountNumber (TextInputButton) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_2481BBVZTGCBDCR_830216 = function( entities, changeEventArgs ) {
        //changeEventArgs.commons.execServer = true;
        if(changeEventArgs.newValue != ""){      
        changeEventArgs.commons.execServer = true;
     }else{
         changeEventArgs.commons.execServer = false;
        }
    };

//Entity: PaymentForm
    //PaymentForm.currencyId (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_4212YIFTVBCOPPD_140216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        entities.PaymentForm.currencyIdAux = entities.PaymentForm.currencyId;
    };

//Start signature to Callback event to VA_4212YIFTVBCOPPD_140216
task.changeCallback.VA_4212YIFTVBCOPPD_140216 = function(entities, changeCallbackEventArgs) {
//here your code
    if(changeCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().difference >=
         entities.LoanAdditionalInformation.amountToCancel){
         changeCallbackEventArgs.commons.api.vc.viewState.VA_VASIMPLELABELLL_582216.label = 
         cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152') + ": " +
         kendo.toString(entities.LoanAdditionalInformation.amountToCancel, 'c') + " " +
         entities.Loan.currencyName + " " +
         cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924') + ': ' +
         entities.LoanAdditionalInformation.quotation;
      }else{
         changeCallbackEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate('ASSTS.MSG_ASSTS_VALORDEEA_97215'));
         entities.PaymentForm.currencyId = changeEventArgs.oldValue;
         changeCallbackEventArgs.commons.execServer = true;
      }
};

//Entity: PaymentForm
    //PaymentForm.currencyIdAux (ComboBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_6057SWXKCQQHOIS_464216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        entities.PaymentForm.currencyFlagAux = '1';
        
    };

//Entity: PaymentForm
    //PaymentForm.clientFullName (TextInputButton) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_6386FQVBTKCYFWG_461216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var disClientId = changeEventArgs.commons.api.navigation.getCustomDialogParameters().loan.clientID;
        var newClientId = entities.PaymentForm.clientId;
        if(newClientId != disClientId && changeEventArgs.oldValue != null){
            changeEventArgs.commons.execServer = false;
        }
    };

//Entity: PaymentForm
    //PaymentForm.payAmount (TextInputBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_8983QPJHQZZOSML_321216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        //changeEventArgs.commons.serverParameters.PaymentForm = true;
        var api = changeEventArgs.commons.api;
        if(api.navigation.getCustomDialogParameters().difference >=
            entities.PaymentForm.payAmount){
            if(entities.LoanAdditionalInformation.quotation == undefined){
               entities.LoanAdditionalInformation.quotation=entities.Loan.codCurrency;
            }
            api.vc.viewState.VA_VASIMPLELABELLL_582216.label = 
            cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152')+": "+
            kendo.toString((entities.PaymentForm.payAmount*entities.LoanAdditionalInformation.quotation), 'c')+" "+
            entities.Loan.currencyName +
            cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924')+': '+
            entities.LoanAdditionalInformation.quotation;
        }else{
            api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = false;
            changeEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate('ASSTS.MSG_ASSTS_VALORDEEA_97215'));
            changeEventArgs.commons.execServer = true;
        }
    };

//Start signature to Callback event to VA_8983QPJHQZZOSML_321216
task.changeCallback.VA_8983QPJHQZZOSML_321216 = function(entities, changeCallbackEventArgs) {
//here your code
    if(changeEventArgs.commons.api.navigation.getCustomDialogParameters().difference <
            entities.PaymentForm.payAmount){
            console.log(changeEventArgs.commons.api.navigation.getCustomDialogParameters().difference);
        }
};

// (Button) 
    task.executeCommand.CM_TPAYMENT_NS7 = function(entities, executeCommandEventArgs) {
        var cm = executeCommandEventArgs.commons;
      if(cm.api.vc.viewState.Spacer1695.visible == false){
         entities.PaymentForm.economicDestination = null;
      }
        executeCommandEventArgs.commons.execServer = true;
    };

//Start signature to callBack event to CM_TPAYMENT_NS7
    task.executeCommandCallback.CM_TPAYMENT_NS7 = function(entities, executeCommandEventArgs) {
        //here your code
        var api = executeCommandEventArgs.commons.api;
      entities.PaymentForm.currencyName = api.vc.catalogs.VA_4212YIFTVBCOPPD_140216.get(entities.PaymentForm.currencyId);
      var dataGrid = {
         index: api.navigation.getCustomDialogParameters().rowIndex,
         mode: api.vc.mode,
         data:  entities.PaymentForm
      }
      api.navigation.closeModal(dataGrid);
    };

// (Button) 
    task.executeCommand.CM_TPAYMENT_TEC = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var isCancel = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(isCancel);
        
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PaymentModeForm
    task.initData.VC_PAYMENTMDE_245368 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
         entities.PaymentForm.currencyFlagAux = '0';
         var api = initDataEventArgs.commons.api;
         api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = false;
         api.vc.viewState.Spacer1695.visible = false;
         
         entities.Loan = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().loan;
         entities.LoanAdditionalInformation.dateToDisburse = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().dateToDisburse;
         entities.PaymentForm.payAmount = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().difference;

         initDataEventArgs.commons.api.vc.viewState.VA_VASIMPLELABELLL_582216.label = 
         cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152') + ": " +         
         kendo.toString(entities.PaymentForm.payAmount, 'c') + " " +
         entities.Loan.currencyName + " " +
         cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924')+': '+1;
        
    };

//Entity: PaymentForm
    //PaymentForm.payFormId (ComboBox) View: PaymentModeForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.Spacer2675 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        loadCatalogEventArgs.commons.serverParameters.PaymentForm = true;
    };

//Entity: PaymentForm
    //PaymentForm.currencyId (ComboBox) View: PaymentModeForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_4212YIFTVBCOPPD_140216 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.PaymentForm = true;
    };

//Entity: PaymentForm
    //PaymentForm.currencyIdAux (ComboBox) View: PaymentModeForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_6057SWXKCQQHOIS_464216 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.PaymentForm = true;
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: PaymentModeForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if (onCloseModalEventArgs.closedViewContainerId == "VC_BANKACCOMU_224777") {
            if (typeof onCloseModalEventArgs.result.account != "undefined") {
                entities.PaymentForm.accountNumber = onCloseModalEventArgs.result.account.trimRight();
                //entities.PaymentForm.note = onCloseModalEventArgs.result.accountName.trimRight();
            }
        }
    };

//Entity: PaymentForm
    //PaymentForm.accountNumber (TextInputButton) View: PaymentModeForm
    
    task.textInputButtonEvent.VA_2481BBVZTGCBDCR_830216 = function(textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        //if(textInputButtonEventArgs.model.PaymentForm.payFormCategory != ""){
        //Open Modal
           var nav = textInputButtonEventArgs.commons.api.navigation;
           nav.label = cobis.translate('ASSTS.LBL_ASSTS_CUENTASAT_41675'); //Cuentas 
           nav.address = {
               moduleId: 'ASSTS',
               subModuleId: 'TRNSC',
               taskId: 'T_BANKACCOUNTOA_777',
               taskVersion: '1.0.0',
               viewContainerId: 'VC_BANKACCOMU_224777'
           };
           nav.queryParameters = {
               mode: 1
           };
           nav.modalProperties = {
               size: 'md',
               callFromGrid: false
           };
           nav.customDialogParameters = {
               customerID: textInputButtonEventArgs.model.PaymentForm.clientId,
               payFormId:  textInputButtonEventArgs.model.PaymentForm.payFormId,            
               desOpeType: textInputButtonEventArgs.model.Loan.desOperationType,
               currencyId: textInputButtonEventArgs.model.PaymentForm.currencyId
           };
         //}
    };

//Entity: PaymentForm
    //PaymentForm.clientFullName (TextInputButton) View: PaymentModeForm
    
    task.textInputButtonEvent.VA_6386FQVBTKCYFWG_461216 = function(textInputButtonEventArgs ) {
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
      nav.customDialogParameters = {      };
    };

//Entity: PaymentForm
    //PaymentForm.accountNumber (TextInputButton) View: PaymentModeForm
    
    task.textInputButtonEventGrid.VA_2481BBVZTGCBDCR_830216 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Entity: PaymentForm
    //PaymentForm.clientFullName (TextInputButton) View: PaymentModeForm
    
    task.textInputButtonEventGrid.VA_6386FQVBTKCYFWG_461216 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PaymentModeForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
         entities.PaymentForm.clientFullName = entities.Loan.clientID +" - "+ entities.Loan.clientName;
         entities.PaymentForm.clientId = entities.Loan.clientID;
         
         entities.PaymentForm.currencyId = entities.Loan.codCurrency;
         entities.PaymentForm.payFormCategory = ""; 
    };



}));