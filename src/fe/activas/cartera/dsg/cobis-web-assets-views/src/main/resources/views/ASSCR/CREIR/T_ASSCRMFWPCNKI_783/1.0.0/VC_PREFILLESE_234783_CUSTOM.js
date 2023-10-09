/* variables locales de T_ASSCRMFWPCNKI_783*/
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

    
        var task = designerEvents.api.prefilledrequest;
    

    //"TaskId": "T_ASSCRMFWPCNKI_783"
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = resp.CodeReceive;
    var CustomerName = resp.name;
    var isGroup = resp.isGroup;
    args.model.PrefilledRequest.clientId = customerCode;
    args.model.PrefilledRequest.clientIdStr = customerCode;
    args.model.PrefilledRequest.isGroup = isGroup;
};


    // (Button) 
task.executeCommand.CM_TASSCRMF_I20 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    entities.PrefilledRequest.clientId = null;
    entities.PrefilledRequest.clientIdStr = null;
    entities.PrefilledRequest.groupRequest = 'N';
    entities.PrefilledRequest.renewalsRequest = 'N';
};

// (Button) 
task.executeCommand.CM_TASSCRMF_NWA = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;

    if (entities.PrefilledRequest.clientId == null && entities.PrefilledRequest.groupRequest == 'N' && entities.PrefilledRequest.renewalsRequest == 'N') {
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSCR.MSG_ASSCR_SELECCIIT_59694", true);
    } else if (entities.PrefilledRequest.clientId == null) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSCR.MSG_ASSCR_ELCDIGOOO_78756", true);
    } else if (entities.PrefilledRequest.groupRequest == 'N' && entities.PrefilledRequest.renewalsRequest == 'N') {
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSCR.MSG_ASSCR_TIPODESBO_87191", true);
    } else {
        var itemReporte = '';
        var reportTitle = '';
        var isGroup = '';
        var idTramite = 0;

        if (!entities.PrefilledRequest.isGroup) {
            isGroup = 'N'
        } else if (entities.PrefilledRequest.isGroup) {
            isGroup = 'S'
        }

        if (entities.PrefilledRequest.groupRequest != 'N') {
            itemReporte = "solicitudCreditoGrupalPrellenada";
            reportTitle = executeCommandEventArgs.commons.api.viewState.translate('ASSCR.LBL_ASSCR_SOLICITUU_72787');
            var args = [
            ['report.module', 'cartera'],
            ['report.name', itemReporte],
            ['idTramite', idTramite],
            ['clientID', entities.PrefilledRequest.clientId],
            ['isGroup', isGroup]];

            ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
        }
        if (entities.PrefilledRequest.renewalsRequest != 'N') {
            itemReporte = "solicitudCreditoRenovFinanPrellenada";
            reportTitle = executeCommandEventArgs.commons.api.viewState.translate('ASSCR.LBL_ASSCR_SOLICITCN_36303');
            var args = [
            ['report.module', 'cartera'],
            ['report.name', itemReporte],
            ['idTramite', idTramite],
            ['clientID', entities.PrefilledRequest.clientId],
            ['isGroup', isGroup]];

            ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
        }

    }

};

//Entity: PrefilledRequest
//PrefilledRequest.clientId (TextInputButton) View: prefilledRequest

task.textInputButtonEvent.VA_CLIENTIDPDVYIIU_934167 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSCR.LBL_ASSCR_BSQUEDAIE_90412');
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
    nav.customDialogParameters = {};
};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: prefilledRequest
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    document.getElementById('VA_CLIENTIDPDVYIIU_934167').readOnly = true;
};



}));