
/* variables locales de T_PAYMENTSMANII_157*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_PAYMENTSTENLV_850*/

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

    
        var task = designerEvents.api.paymentsmain;
    

    var screenCall;
//"TaskId": "T_PAYMENTSMANII_157"
task.getQuotation = function(quotationList, currencyTypeSearch) {
        var currencyType = 0;
        var quotationValue = 1;
        
        for (var i = 0; i < quotationList._data.length - 1; i++) {
            currencyType = quotationList._data[i].currencyType;
            if (currencyTypeSearch == currencyType) {
                quotationValue = quotationList._data[i].value;
                break;
            }
        }
        return quotationValue;
    };

task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        var CustomerName=  args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;
        args.model.Payment.customer = customerCode +"-"+ CustomerName;
        args.model.Payment.customerID = customerCode;
    };

    	// (Button) 
    task.executeCommand.CM_PAYMENTS_NNS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //Open Modal
        var nav = executeCommandEventArgs.commons.api.navigation;
        nav.label = cobis.translate('ASSTS.LBL_ASSTS_PRIORIDAA_58251'); //Priodidades
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_PRIORITIESENY_489',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_PRIORITIOM_989489'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'md',
            callFromGrid: false
        };
        var priorities2 = angular.copy(entities.Priorities);
        nav.customDialogParameters = {
            bankNum: entities.Loan.loanBankID,
            priorities: priorities2
        }; 
        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
        
    };

	// (Button) 
    task.executeCommand.CM_PAYMENTS_SS1 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //Open Modal
        var nav = executeCommandEventArgs.commons.api.navigation;
        nav.label =  cobis.translate('ASSTS.LBL_ASSTS_SOBRANTSE_66830'); //Sobrantes
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_LEFTOVERPALDD_459',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_LEFTOVERPM_168459'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'md',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            creditType: entities.Loan.operationTypeID,
            customerCode: entities.Payment.customerID,
            leftOverPayment: entities.LeftOverPayment
        };

        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
        
    };

	// (Button) 
    task.executeCommand.CM_PAYMENTS_T3A = function(entities, executeCommandEventArgs) {
        var hasError = false;
        var msgResourceID = "";
        var condonationValue = 0.0;
        var valuesCount = 0;
        
        if (entities.Payment.value == null) 
            entities.Payment.value = 0;
        
        if (entities.Payment.retention == null)
            entities.Payment.retention = 0;
        
        if (entities.PaymentMethod.category == null)
            entities.PaymentMethod.category = "";
        
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            condonationValue = condonationValue + entities.CondonationDetail._data[i].valueToCondone ;
        }
        
        valuesCount = valuesCount + (entities.Payment.value > 0 ? 1 : 0);
        valuesCount = valuesCount + (condonationValue > 0 ? 1 : 0);
        valuesCount = valuesCount + (entities.LeftOverPayment.value > 0 ? 1 : 0);
        
        if (valuesCount > 1 ) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_CONDONACI_18738"; 
        }
        
        if (!hasError && entities.Payment.value <= 0 && condonationValue <= 0 && entities.LeftOverPayment.value <= 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18739"; 
        }
        
        if (!hasError && entities.Payment.value < 0 && entities.Payment.entireFee != 'S') {
            hasError = true;
            msgResourceID = "MSG_ASSTS_PAYMENTSA_18744";
        }
        
        if (!hasError && entities.Payment.date == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18740"; 
        }
        
        if (!hasError && entities.Payment.value && entities.Payment.currencyType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18741"; 
        }
        
        if (!hasError && entities.LeftOverPayment.value > 0 && entities.LeftOverPayment.currencyType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18748"; 
        }
        
        if (!hasError && entities.Payment.value > 0 && entities.Payment.paymentType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18742";
        }
        
        if (!hasError && entities.LeftOverPayment.value > 0 && entities.LeftOverPayment.paymentType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18747";
        }
        
        if(!hasError && entities.PaymentMethod.category.substring(0,2) == "CH" && entities.Payment.bank == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18745";
        }
        
        if(!hasError && entities.PaymentMethod.category.substring(0,2) == "CH" && (entities.Payment.numCheck == null || entities.Payment.numCheck == "")) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18746";
        }
        
        if (!hasError && (entities.Payment.reference == null || entities.Payment.reference == "") && (entities.Payment.value > 0 || entities.Payment.entireFee == 'S')) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18743"; 
        }
        
        if (!hasError && (entities.LeftOverPayment.reference == null || entities.LeftOverPayment.reference == "") && entities.LeftOverPayment.value > 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18749"; 
        }
        
       if (entities.Payment.finePrepayment > 0){
          if (entities.Payment.value >= entities.Payment.amount && entities.Payment.value != entities.Payment.amountPrepayment) {
              hasError = true;
              msgResourceID = "ASSTS.MSG_ASSTS_ERRORELRL_73200"; 
          }
          if (entities.Payment.value == entities.Payment.amountPrepayment){
               entities.Loan.newStatus = 'S';
          }else{
               entities.Loan.newStatus = 'N';
          }
        }      
        
        if (!hasError) {
            var quotationValue = 0.0;
            quotationValue = task.getQuotation(entities.QuotationCurrency, entities.Payment.operationCurrencyType)
            entities.Payment.quotationValue = quotationValue
            
            quotationValue = 0.0;
            quotationValue = task.getQuotation(entities.QuotationCurrency, entities.Payment.currencyType)
            entities.Payment.payQuotationValue = quotationValue
            
            quotationValue = 0.0;
            quotationValue = task.getQuotation(entities.QuotationCurrency, entities.LeftOverPayment.currencyType)
            entities.LeftOverPayment.leftoverQuotationValue = quotationValue;
            
        }
        
        if (hasError) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
            executeCommandEventArgs.commons.execServer = false;
        } else {
            //executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.execServer = true;
        }
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Start signature to Callback event to CM_PAYMENTS_T3A
task.executeCommandCallback.CM_PAYMENTS_T3A = function(entities, executeCommandCallbackEventArgs) {
    //here your code
    var messages = '';
    var unappliedValue = '';
    if (entities.LoanInstancia.tipo == 'G' && entities.Payment.unappliedPayments > 0) {
        unappliedValue = entities.Payment.unappliedAmount.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'); 
        messages = 'Existen ' + entities.Payment.unappliedPayments + ' pago(s) grupal(es) por un monto de ' + unappliedValue + ' pesos pendiente de aplicar. Desea continuar aplicando el pago?'
        cobis.getMessageManager().showMessagesConfirm(messages).then(function (resp) {
            switch (resp.buttonIndex) {
            case 0: //cancel
                console.log('se cancelo..');
                entities.Payment.continuePayment = null;
                break;
            case 1: //accept
                console.log('se acepto..');
                entities.Payment.continuePayment = 'S';
                executeCommandCallbackEventArgs.commons.api.vc.executeCommand('CM_TPAYMENT_Y_2', 'PaymentsMain', undefined, true, false, 'VC_PAYMENTSAN_916157', false);
                break;
            }
        });
    }
};

	// (Button) 
    task.executeCommand.CM_PAYMENTS_T7N = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //Open Modal
        var nav = executeCommandEventArgs.commons.api.navigation;

        nav.label = cobis.translate('ASSTS.LBL_ASSTS_NEGOCIANI_54038'); //Negociacion
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_NEGOTIATIOTML_700',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_NEGOTIATOO_775700'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'md',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            negotiation: entities.Negotiation
        };

        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
        
    };

	// (Button) 
    task.executeCommand.CM_TPAYMENT_MA5 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //Open Modal
        var nav = executeCommandEventArgs.commons.api.navigation;

        nav.label = cobis.translate('ASSTS.LBL_ASSTS_CONDONASE_22340'); //Condonaciones
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_CONDONATIOSNN_532',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_CONDONATON_778532'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'lg',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            bankNum: entities.Loan.loanBankID,
            condonationDetail2: entities.CondonationDetail 
        };  

        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	// (Button) 
    task.executeCommand.CM_TPAYMENT_Y_2 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PaymentsMain
    task.initData.VC_PAYMENTSAN_916157 = function (entities, initDataEventArgs){
        var commons = initDataEventArgs.commons;
        var api=initDataEventArgs.commons.api;
        var parameters=api.navigation.getCustomDialogParameters(); 
        entities.LoanInstancia = parameters.parameters.loanInstancia;
        //PRO
        screenCall = parameters.parameters.screenCall;
        //PRO
        initDataEventArgs.commons.api.viewState.hide("VA_NUMCHECKQLTBIOX_669141");
        initDataEventArgs.commons.api.viewState.hide("VA_TEXTINPUTBOXSJQ_831141");
        initDataEventArgs.commons.api.viewState.hide("VA_VASIMPLELABELLL_923141");
        entities.Payment.onLine = true;
        entities.Payment.value = 0;
        entities.Payment.retention = 0;
        entities.LeftOverPayment.value = 0
        commons.execServer = true; 
        
        var parentVc=api.parentVc;
        
        if(screenCall=='refinance'){
            parentVc.closeDialog();     
        }
    };

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: PaymentsMain
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
        var cancelModal = false;

        if (onCloseModalEventArgs.closedViewContainerId == "VC_LEFTOVERPM_168459") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.paymentType != "undefined") {
                entities.LeftOverPayment.paymentType = onCloseModalEventArgs.result.paymentType;
                entities.LeftOverPayment.value = onCloseModalEventArgs.result.value;
                entities.LeftOverPayment.currencyType = onCloseModalEventArgs.result.currencyType;
                entities.LeftOverPayment.reference = onCloseModalEventArgs.result.reference;
                entities.LeftOverPayment.note = onCloseModalEventArgs.result.note;
                entities.LeftOverPayment.leftoverQuotationValue = onCloseModalEventArgs.result.leftoverQuotationValue;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_PRIORITIOM_989489") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.data !== "undefined") {
                entities.Priorities = onCloseModalEventArgs.result.data;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_CONDONATON_778532") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.data !== "undefined") {
                entities.CondonationDetail = onCloseModalEventArgs.result.data;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_NEGOTIATOO_775700") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.paymentType !== "undefined") {
                entities.Negotiation.paymentType = onCloseModalEventArgs.result.paymentType;
                entities.Negotiation.interestType = onCloseModalEventArgs.result.interestType;
                entities.Negotiation.fullFee = onCloseModalEventArgs.result.fullFee;
                entities.Negotiation.additionalPayments = onCloseModalEventArgs.result.additionalPayments;
                entities.Payment.entireFee = onCloseModalEventArgs.result.fullFee ? 'S' : 'N';
                entities.Payment.advance = onCloseModalEventArgs.result.additionalPayments ? 'S' : 'N';
                onCloseModalEventArgs.commons.execServer = true;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_BANKACCOTT_940944") {
            if (typeof onCloseModalEventArgs.result.account != "undefined") {
                entities.Payment.reference = onCloseModalEventArgs.result.account.trimRight();
                entities.Payment.note = onCloseModalEventArgs.result.accountName.trimRight();
            }
        }
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PaymentsMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_PAYMENTSAN_916157","VC_ZNXEHASOGQ_840157",entities, renderEventArgs);  
        
        if(screenCall=='refinance'){
            renderEventArgs.commons.api.viewState.label('VA_VABUTTONORYJAMS_468612','Regresar');            
            
            var buttonChange=$('#VA_VABUTTONORYJAMS_468612');
            var spanIcon=buttonChange.find("span");
            spanIcon.removeClass("glyphicon-search");
            spanIcon.addClass("glyphicon-chevron-left");            
        }   
        
        renderEventArgs.commons.api.viewState.hide("CM_TPAYMENT_Y_2");
        if (entities.LoanInstancia.tipo == 'G') {
            renderEventArgs.commons.api.viewState.hide("CM_PAYMENTS_SS1");
            renderEventArgs.commons.api.viewState.hide("CM_PAYMENTS_T7N");
            renderEventArgs.commons.api.viewState.hide("CM_PAYMENTS_NNS");
            renderEventArgs.commons.api.viewState.hide("CM_TPAYMENT_MA5");
            renderEventArgs.commons.api.viewState.hide("VA_CHECKBOXIPQLEBS_550141");
        }
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
        try{
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.api.vc.closeDialog();
            var subModuleId = "CMMNS",
            taskId = "T_LOANSEARCHSWA_959",
            vcId = "VC_LOANSEARHC_144959",
            parameters = '', 
            label = "B\u00fasqueda de Pr\ufffdstamos";
            ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);
        }
        catch(err){
            ASSETS.Utils.managerException(err);
        }
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONWVITZRQ_108612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
         ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
    };

	//Entity: Loan
    //Loan.loanBankID (TextLink) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VASIMPLELABELLL_867612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
                    ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
    };

	//Entity: Payment
    //Payment.currencyType (ComboBox) View: PaymentsForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_CURRENCYSPEYFQA_285141 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        
    };

	//Entity: Payment
    //Payment.paymentType (ComboBox) View: PaymentsForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXCFY_310141 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;        
        //changeEventArgs.commons.serverParameters.Payment = true;
    };

	//Start signature to callBack event to VA_TEXTINPUTBOXCFY_310141
  task.changeCallback.VA_TEXTINPUTBOXCFY_310141 = function(entities, changeEventArgs) {
       entities.Payment.retention = entities.PaymentMethod.retention;
        entities.Payment.reference = ""
        entities.Payment.note = ""; 
        
        if(entities.PaymentMethod.category.substring(0,2) == "CH") {
            changeEventArgs.commons.api.viewState.show("VA_NUMCHECKQLTBIOX_669141");
            changeEventArgs.commons.api.viewState.show("VA_TEXTINPUTBOXSJQ_831141");
        }
        else
        {
            changeEventArgs.commons.api.viewState.hide("VA_NUMCHECKQLTBIOX_669141");
            changeEventArgs.commons.api.viewState.hide("VA_TEXTINPUTBOXSJQ_831141");
        }
    };

	//Entity: Payment
    //Payment.bank (ComboBox) View: PaymentsForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXSJQ_831141 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        
    };

	//gridCommand (Button) QueryView: QV_2540_50573
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_2540_50573_362 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.QuoteDetails = true;
        //Open Modal
            var nav = gridExecuteCommandEventArgs.commons.api.navigation;

            nav.label = cobis.translate('ASSTS.LBL_ASSTS_DETALLEAG_48048'); //Detalle del Pago
            nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_QUOTADETAISOY_745',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_QUOTADETAA_445745'
            };
            nav.queryParameters = {
            mode: 1
            };
            nav.modalProperties = {
            size: 'md',
            callFromGrid: false
            };

            nav.openModalWindow("CEQV_201QV_2540_50573_362", gridExecuteCommandEventArgs.modelRow);
    };

	//Entity: Payment
    //Payment.currencyType (ComboBox) View: PaymentsForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_CURRENCYSPEYFQA_285141 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.Payment = true;
    };

	//Entity: Payment
    //Payment.paymentType (ComboBox) View: PaymentsForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXCFY_310141 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;        
        loadCatalogEventArgs.commons.serverParameters.Loan = true;
    };

	//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: PaymentsForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXRMI_168141 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = false;
    
        //loadCatalogDataEventArgs.commons.serverParameters.CondonationDetail = true;
    };

	//Entity: Payment
    //Payment.bank (ComboBox) View: PaymentsForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXSJQ_831141 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.Payment = true;
    };

	//Entity: Payment
    //Payment.reference (TextInputButton) View: PaymentsForm
    
    task.textInputButtonEvent.VA_REFERENCECGUXXB_239141 = function(textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        
        //Open Modal
        var nav = textInputButtonEventArgs.commons.api.navigation;

        nav.label = cobis.translate('ASSTS.LBL_ASSTS_CUENTASAT_41675'); //Cuentas 
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_BANKACCOUNTIS_944',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_BANKACCOTT_940944'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'md',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            customerID: textInputButtonEventArgs.model.Payment.customerID,
            paymentType: textInputButtonEventArgs.model.Payment.paymentType
        };
    };

	//Entity: Payment
    //Payment.customer (TextInputButton) View: PaymentsForm
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXHQX_290141 = function(textInputButtonEventArgs ) {
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

	//Entity: Payment
    //Payment.reference (TextInputButton) View: PaymentsForm
    
    task.textInputButtonEventGrid.VA_REFERENCECGUXXB_239141 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

	//Entity: Payment
    //Payment.customer (TextInputButton) View: PaymentsForm
    
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXHQX_290141 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };



}));