
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

    
        var task = designerEvents.api.debitorderprocessinglog;
    

        task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            customerCode = args.commons.api.vc.dialogParameters.CodeReceive,
            CustomerName = args.commons.api.vc.dialogParameters.name,
            identification = args.commons.api.vc.dialogParameters.documentId,
            customerType = args.commons.api.vc.dialogParameters.customerType;

        args.model.DebitOrderProcessingLogFilter.clientId = customerCode;
    };

    //valida si arrastra el texto
    function validadeIfDragText(entities) {
        if (entities.DebitOrderProcessingLogFilter.loanNumber === null || entities.DebitOrderProcessingLogFilter.loanNumber === "" ||
            angular.isUndefined(entities.DebitOrderProcessingLogFilter.loanNumber)) {
            entities.DebitOrderProcessingLogFilter.loanNumber = $("#VA_TEXTINPUTBOXRBR_513643").val();
        }
        if (entities.DebitOrderProcessingLogFilter.accountNumberSantander === null || entities.DebitOrderProcessingLogFilter.accountNumberSantander === "" ||
            angular.isUndefined(entities.DebitOrderProcessingLogFilter.accountNumberSantander)) {
            entities.DebitOrderProcessingLogFilter.accountNumberSantander = $("#VA_TEXTINPUTBOXMRW_242643").val();
        }
        if (entities.DebitOrderProcessingLogFilter.clientId === null || entities.DebitOrderProcessingLogFilter.clientId === "" ||
            angular.isUndefined(entities.DebitOrderProcessingLogFilter.clientId)) {
            entities.DebitOrderProcessingLogFilter.clientId = $("#VA_TEXTINPUTBOXNGO_790643").val();
        }
    }

    //Entity: DebitOrderProcessingLogFilter
    //DebitOrderProcessingLogFilter.typeError (ComboBox) View: DebitOrderProcessingLog
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXYNP_541643 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: DebitOrderProcessingLogFilter
    //DebitOrderProcessingLogFilter.fromDate (DateField) View: DebitOrderProcessingLog

    task.customValidate.VA_DATEFIELDDOSHLK_541643 = function (entities, customValidateEventArgs) {
        var currentDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(customValidateEventArgs.currentValue),
            untilDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(entities.DebitOrderProcessingLogFilter.untilDate);
        //hay que validar con designer si es la mejor solucion cuando se arrastra el texto al control
        validadeIfDragText(entities);

        if (currentDate !== null && untilDate === null) {
            customValidateEventArgs.isValid = true;
            return;
        }


        if (currentDate === null && untilDate !== null) {
            customValidateEventArgs.errorMessage = 'ASSTS.LBL_ASSTS_INGRESEFF_23610';
            customValidateEventArgs.isValid = false;
            return;
        }

        customValidateEventArgs.isValid = true;

    };

//Entity: DebitOrderProcessingLogFilter
    //DebitOrderProcessingLogFilter.untilDate (DateField) View: DebitOrderProcessingLog

    task.customValidate.VA_DATEFIELDMYOWUX_624643 = function (entities, customValidateEventArgs) {
        var currentDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(customValidateEventArgs.currentValue),
            fromDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(entities.DebitOrderProcessingLogFilter.fromDate);

        if (currentDate !== null && fromDate === null) {
            customValidateEventArgs.isValid = true;
            return;
        }


        if (currentDate === null && fromDate !== null) {
            customValidateEventArgs.errorMessage = 'ASSTS.LBL_ASSTS_INGRESEFF_23610';
            customValidateEventArgs.isValid = false;
            return;
        }

        if (currentDate < fromDate) {
            customValidateEventArgs.errorMessage = 'ASSTS.MSG_ASSTS_LAFECHASH_16014';
            customValidateEventArgs.isValid = false;
            return;
        }

        if (currentDate > entities.DebitOrderProcessingLogFilter.processDate) {
            customValidateEventArgs.errorMessage = 'ASSTS.LBL_ASSTS_LAFECHAHR_40120';
            customValidateEventArgs.isValid = false;
            return;
        }

        customValidateEventArgs.isValid = true;

    };

//undefined Entity: 
    task.executeQuery.Q_DEBITOOI_1156 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: DebitOrderProcessingLog
task.initData.VC_DEBITORDOC_486608 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = true;    
};

//Entity: DebitOrderProcessingLogFilter
    //DebitOrderProcessingLogFilter.clientId (TextInputButton) View: DebitOrderProcessingLog

    task.textInputButtonEvent.VA_TEXTINPUTBOXNGO_790643 = function (textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDAEC_38534');
        nav.customAddress = {
            id: "findCustomer",
            url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ["/customer/services/find-customers-srv.js"
                                           , "/customer/controllers/find-customers-ctrl.js"]
        }];
    };



}));