/* variables locales de T_ASSTSIFBOZBRX_821*/
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

    
        var task = designerEvents.api.querydocumentsbyfilter;
    

    //"TaskId": "T_ASSTSIFBOZBRX_821"
function loadFindCustomer(nav, textInputName) {
    nav.label = 'B\u00FAsqueda de Clientes';
    nav.customAddress = {
        id: 'findCustomer',
        url: '/customer/templates/find-customers-tpl.html'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER,
        files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                                                                              }];
    nav.customDialogParameters = {
        mode: "findCustomer",
        controlName: textInputName
    };
    nav.modalProperties = {
        size: 'lg'
    };
};

task.download = function (entities, gridRowCommandEventArgs) {


    var extension = gridRowCommandEventArgs.rowData.extension == null ? "" : gridRowCommandEventArgs.rowData.extension.trim();
    if (gridRowCommandEventArgs.rowData.clientType == "S" || gridRowCommandEventArgs.rowData.clientType == "G") {
        var groupId = gridRowCommandEventArgs.rowData.clientId;
    } else {
        var customerId = gridRowCommandEventArgs.rowData.clientId;
    }
    var processInstance = gridRowCommandEventArgs.rowData.processId;
    var documentName = (gridRowCommandEventArgs.rowData.documentName == null ? "" : gridRowCommandEventArgs.rowData.documentName.trim()) + "." + extension;
    var folder = gridRowCommandEventArgs.rowData.folder;
    var formaMapeo = document.createElement("form");
    groupId = groupId == null ? gridRowCommandEventArgs.rowData.groupId : groupId;
    formaMapeo.method = "POST";
    formaMapeo.action = "/CTSProxy/services/cobis/web/customer/GetFileServlet";


    if (folder == "Inbox") {
        //Carpeta, Instancia Proceso, nombre documento con extension
        task.addInput(formaMapeo, "folder", folder);
        task.addInput(formaMapeo, "processInstanceId", processInstance);
        task.addInput(formaMapeo, "fileName", documentName);
        formaMapeo.submit();

    } else if (folder == "Customer") {

        if (processInstance == null || processInstance == undefined || processInstance == 0) {
            //Carpeta, Id del cliente, nombre documento con extension
            task.addInput(formaMapeo, "folder", folder);
            task.addInput(formaMapeo, "customerId", customerId);
            task.addInput(formaMapeo, "fileName", documentName);
            formaMapeo.submit();
        } else {
            //Carpeta, Id del cliente, nombre documento con extension e instancia de proceso
            task.addInput(formaMapeo, "folder", folder);
            if (groupId != null) {
                task.addInput(formaMapeo, "groupId", groupId);
            }
            task.addInput(formaMapeo, "processInstanceId", processInstance);
            task.addInput(formaMapeo, "customerId", customerId);
            task.addInput(formaMapeo, "fileName", documentName);
            formaMapeo.submit();
        }

    }


};
task.addInput = function (formaMapeo, name, value) {
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = name;
    input.value = value;
    formaMapeo.appendChild(input);
    document.body.appendChild(formaMapeo);
    return formaMapeo;
};


    //ResultQueryByFilterQuery Entity: 
task.executeQuery.Q_RESULTYR_9784 = function (executeQueryEventArgs) {

    if ((executeQueryEventArgs.parameters.clientId == null || executeQueryEventArgs.parameters.clientId == "") && (executeQueryEventArgs.parameters.codDocumentType == null || executeQueryEventArgs.parameters.codDocumentType == "") && (executeQueryEventArgs.parameters.loanNumber == null || executeQueryEventArgs.parameters.loanNumber == "") && (executeQueryEventArgs.parameters.procedureNumber == null || executeQueryEventArgs.parameters.procedureNumber == "")) {        
        executeQueryEventArgs.commons.messageHandler.showTranslateMessagesError('ASSTS.MSG_ASSTS_NOSEHALLA_81795');	
        executeQueryEventArgs.commons.execServer = false;
    } else {
        if (executeQueryEventArgs.parameters.clientId != null && executeQueryEventArgs.parameters.clientType == null) {
            executeQueryEventArgs.parameters.clientType = 'P';
        }
        if (executeQueryEventArgs.parameters.clientId == null && executeQueryEventArgs.parameters.clientType != null) {
            executeQueryEventArgs.parameters.clientType = null;
        }
        executeQueryEventArgs.commons.execServer = true;
    }

};

//Entity: ResultQueryByFilter
//ResultQueryByFilter. (Button) View: QueryDocumentsByFilter

task.gridRowCommand.VA_GRIDROWCOMMMNAD_831698 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = false;
    task.download(entities, gridRowCommandEventArgs);

};

//Entity: ResultQueryByFilter
//ResultQueryByFilter. (Button) View: QueryDocumentsByFilter

task.gridRowCommand.VA_GRIDROWCOMMMNNA_455698 = function (entities, gridRowCommandEventArgs) {
    gridRowCommandEventArgs.commons.execServer = false;
    var entity = {};
    entity.processInstance = gridRowCommandEventArgs.rowData.processId == null ? 0 : gridRowCommandEventArgs.rowData.processId;
    entity.customerId = gridRowCommandEventArgs.rowData.clientId == null ? 0 : gridRowCommandEventArgs.rowData.clientId;
    entity.groupId = gridRowCommandEventArgs.rowData.groupId == null ? 0 : gridRowCommandEventArgs.rowData.groupId;
    entity.description = gridRowCommandEventArgs.rowData.documentType == null ? "" : gridRowCommandEventArgs.rowData.documentType.trim();
    entity.documentId = gridRowCommandEventArgs.rowData.codDocumentType == null ? "" : gridRowCommandEventArgs.rowData.codDocumentType.trim();
    entity.extension = (gridRowCommandEventArgs.rowData.documentName == null ? "" : gridRowCommandEventArgs.rowData.documentName.trim()) + "." + (gridRowCommandEventArgs.rowData.extension == null ? "" : gridRowCommandEventArgs.rowData.extension.trim());
    entity.folder = gridRowCommandEventArgs.rowData.folder;
    ASSETS.Navigation.openHistorical(entity, gridRowCommandEventArgs, 'VA_GRIDROWCOMMMNNA_455698');

};

//Entity: HeaderQueryDocuments
//HeaderQueryDocuments.documentType (ComboBox) View: QueryDocumentsByFilter
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_DOCUMENTTYPEVHQ_629698 = function (loadCatalogDataEventArgs) {

    loadCatalogDataEventArgs.commons.execServer = true;

    //loadCatalogDataEventArgs.commons.serverParameters.HeaderQueryDocuments = true;
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: QueryDocumentsByFilter
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;
    if (onCloseModalEventArgs.result.params != undefined) {
        entities.HeaderQueryDocuments.clientName = onCloseModalEventArgs.result.selectedData.name;
        entities.HeaderQueryDocuments.clientId = onCloseModalEventArgs.result.selectedData.code;
        entities.HeaderQueryDocuments.clientType = onCloseModalEventArgs.result.selectedData.customerType;

        if (entities.HeaderQueryDocuments.clientType == 'S' || entities.HeaderQueryDocuments.clientType == 'G') {
            onCloseModalEventArgs.commons.api.viewState.label("VA_CLIENTIDBZOEDEE_140698", "ASSTS.LBL_ASSTS_GRUPOOBAY_84995");
        } else {
            onCloseModalEventArgs.commons.api.viewState.label("VA_CLIENTIDBZOEDEE_140698", "ASSTS.LBL_ASSTS_CLIENTEWV_22561");
        }
    }

};

//Entity: HeaderQueryDocuments
//HeaderQueryDocuments.clientId (TextInputButton) View: QueryDocumentsByFilter

task.textInputButtonEvent.VA_CLIENTIDBZOEDEE_140698 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    loadFindCustomer(nav, "cliente");

};

//Entity: HeaderQueryDocuments
//HeaderQueryDocuments.clientId (TextInputButton) View: QueryDocumentsByFilter

task.textInputButtonEventGrid.VA_CLIENTIDBZOEDEE_140698 = function (textInputButtonEventGridEventArgs) {

    textInputButtonEventGridEventArgs.commons.execServer = false;


};



}));