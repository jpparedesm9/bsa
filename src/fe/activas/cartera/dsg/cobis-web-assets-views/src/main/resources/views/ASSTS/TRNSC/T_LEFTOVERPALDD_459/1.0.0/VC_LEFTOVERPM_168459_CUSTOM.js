/* variables locales de T_LEFTOVERPALDD_459*/
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

    
        var task = designerEvents.api.leftoverpaymentsmodal;
    

    //"TaskId": "T_LEFTOVERPALDD_459"
var customerCode;

    //Entity: LeftOverPayment
    //LeftOverPayment.currencyType (ComboBox) View: LeftoverPaymentsModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXSZZ_277369 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        
    };

// (Button) 
    task.executeCommand.CM_TLEFTOVE_V_5 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
    };

// (Button) 
    task.executeCommand.CM_TLEFTOVE__3S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(entities.LeftOverPayment);
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LeftoverPaymentsModal
    task.initData.VC_LEFTOVERPM_168459 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        var dialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        
        entities.LeftOverPayment.paymentType = dialogParameters.leftOverPayment.paymentType;
        entities.LeftOverPayment.value = dialogParameters.leftOverPayment.value;
        entities.LeftOverPayment.currencyType = dialogParameters.leftOverPayment.currencyType;
        entities.LeftOverPayment.reference = dialogParameters.leftOverPayment.reference;
        entities.LeftOverPayment.note = dialogParameters.leftOverPayment.note;
        
        customerCode = dialogParameters.customerCode;
        
    };

//Entity: LeftOverPayment
    //LeftOverPayment.paymentType (ComboBox) View: LeftoverPaymentsModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXAQZ_901369 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.LeftOverPayment = true;
    };

//Entity: LeftOverPayment
    //LeftOverPayment.currencyType (ComboBox) View: LeftoverPaymentsModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXSZZ_277369 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.LeftOverPayment = true;
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: LeftoverPaymentsModal
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if (onCloseModalEventArgs.closedViewContainerId == "VC_BANKACCOTT_940944") {
            if (typeof onCloseModalEventArgs.result.account != "undefined") {
                entities.LeftOverPayment.reference = onCloseModalEventArgs.result.account.trimRight();
                entities.LeftOverPayment.note = onCloseModalEventArgs.result.accountName.trimRight();
            }
        }
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
    };

//Entity: LeftOverPayment
    //LeftOverPayment.reference (TextInputButton) View: LeftoverPaymentsModal
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXJMX_394369 = function(textInputButtonEventArgs ) {
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
            customerID: customerCode,
            paymentType: textInputButtonEventArgs.model.LeftOverPayment.paymentType
        };
    };



}));