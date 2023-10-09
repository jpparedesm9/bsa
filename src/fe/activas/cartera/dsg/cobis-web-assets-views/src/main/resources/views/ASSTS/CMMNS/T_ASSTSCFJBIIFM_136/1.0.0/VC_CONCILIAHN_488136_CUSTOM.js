/* variables locales de T_ASSTSCFJBIIFM_136*/
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

    
        var task = designerEvents.api.conciliationsearchform;
    

    //"TaskId": "T_ASSTSCFJBIIFM_136"

task.textInputButtonEvent.VA_CUSTOMERCODEVGG_397314 = function (textInputButtonEventArgs) {
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



    // (Button) 
task.executeCommand.CM_TASSTSCF_6AJ = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;

    var nav = executeCommandEventArgs.commons.api.navigation;
    nav.label = 'Carga de Archivo';
    nav.customAddress = {
        id: "assetsUpload",
        url: "/ASSTS/CMMNS/UPLOADFILE/upload-file.html",
        useMinification: false
    };
    nav.modalProperties = {
        size: 'md'
    };
    nav.scripts = [{
        module: "assetsUpload",
        files: ["/ASSTS/CMMNS/UPLOADFILE/services/upload-file-srv.js"
                                           , "/ASSTS/CMMNS/UPLOADFILE/controllers/upload-file-ctrl.js"]
        }];
    nav.openCustomModalWindow('assetsUpload');
};

//ConciliationSearchQuery Entity: 
task.executeQuery.Q_CONCILOA_9564 = function (executeQueryEventArgs) {
    executeQueryEventArgs.commons.execServer = true;
    executeQueryEventArgs.parameters.customerCode = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode;
    if (executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode == null) {
        executeQueryEventArgs.parameters.customerType = null;
    } else if (typeof executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode == 'string' && executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode.trim() == "") {
        executeQueryEventArgs.parameters.customerType = null;
    } else {
        executeQueryEventArgs.parameters.customerType = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerType;
    }
    executeQueryEventArgs.parameters.amount = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.amount;
    executeQueryEventArgs.parameters.dateFrom = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.dateFrom;
    executeQueryEventArgs.parameters.type = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.type;
    executeQueryEventArgs.parameters.notConciliationReason = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.notConciliationReason;
    executeQueryEventArgs.parameters.conciliationStatus = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.conciliationStatus;
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ConciliationSearchForm
    task.initData.VC_CONCILIAHN_488136 = function (entities, initDataEventArgs){
        cobis.showMessageWindow.loading(true);
        initDataEventArgs.commons.execServer = false;
        entities.ConciliationSearchFilter.customerType = 'P'; //Persona Natural por defecto
        entities.ConciliationSearchFilter.conciliationStatus = 'T';//Estado Conciliación: Todos por defecto
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ConciliationSearchForm
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
        onCloseModalEventArgs.commons.execServer = false;
    if (onCloseModalEventArgs.closedViewContainerId == "findCustomer") {
        var resp = onCloseModalEventArgs.result.selectedData;
        var title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';

        if (resp != null) {
            entities.ConciliationSearchFilter.customerCode = resp.code;
            entities.ConciliationSearchFilter.customerType = resp.customerType;

            switch (resp.customerType) {
            case 'P':
                title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
                break;
            case 'C':
                title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
                break;
            case 'S':
                title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
                break;
            case 'G':
                title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
                break;
            }
        }

        onCloseModalEventArgs.commons.api.viewState.label("VA_CUSTOMERCODEVGG_397314", title);
    } else {
        var grid = onCloseModalEventArgs.commons.api.grid;
        grid.refresh('QV_9564_85454');
    }

};

//Entity: ConciliationSearchFilter
    //ConciliationSearchFilter.customerCode (TextInputButton) View: ConciliationSearchForm
    
    task.textInputButtonEventGrid.VA_CUSTOMERCODEVGG_397314 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//gridRowSelecting QueryView: QV_9564_85454
//Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
task.gridRowSelecting.QV_9564_85454 = function (entities, gridRowSelectingEventArgs) {
    gridRowSelectingEventArgs.commons.execServer = false;

    var conciliationSearch = gridRowSelectingEventArgs.rowData;

    if (conciliationSearch != null && conciliationSearch.conciliate == 'N' && (conciliationSearch.notConciliationReason == 'NE' || conciliationSearch.notConciliationReason == 'NR')) {
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        nav.address = {
            moduleId: "ASSTS",
            subModuleId: "TRNSC",
            taskId: "T_ASSTSODKKUGLX_678",
            viewContainerId: "VC_MANUALCOLT_571678",
            taskVersion: "1.0.0"
        };


        nav.label = cobis.translate('ASSTS.LBL_ASSTS_CONCILINA_99171');
        nav.modalProperties = {
            size: 'md'
        };
        nav.customDialogParameters = {
            conciliationSearch: conciliationSearch,
        };
        nav.openModalWindow(gridRowSelectingEventArgs.commons.controlId);
    }


};



}));