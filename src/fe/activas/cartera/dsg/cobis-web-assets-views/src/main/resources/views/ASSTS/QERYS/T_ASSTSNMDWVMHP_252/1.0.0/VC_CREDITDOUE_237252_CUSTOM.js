/* variables locales de T_ASSTSNMDWVMHP_252*/
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

    
        var task = designerEvents.api.querydocumentshistory;
    

    //"TaskId": "T_ASSTSNMDWVMHP_252"
task.downloadHistorical = function (entities, gridRowCommandEventArgs) {

    var archivoId = gridRowCommandEventArgs.rowData.documentId.trim();
    var extension = gridRowCommandEventArgs.rowData.extension.trim();
    var groupId = gridRowCommandEventArgs.rowData.groupId;
    var processInstance = gridRowCommandEventArgs.rowData.processInstance;
    var customerId = gridRowCommandEventArgs.rowData.customerId;
    var version = gridRowCommandEventArgs.rowData.documentVersion;
    var folder = gridRowCommandEventArgs.rowData.folder;
    var formaMapeo = document.createElement("form");
    formaMapeo.method = "POST"; 
    formaMapeo.action = "/CTSProxy/services/cobis/web/customer/GetFileHistoricalServlet";   


    if (folder == "Inbox") {
        //Carpeta, Instancia Proceso, nombre documento con extension
        task.addInput(formaMapeo, "folder", folder);
        task.addInput(formaMapeo, "processInstanceId", processInstance);
        task.addInput(formaMapeo, "fileName", extension);
        task.addInput(formaMapeo, "version", version);
        formaMapeo.submit();

    } else if (folder == "Customer") {
        extension = archivoId + '.' + extension;
        
        if (processInstance == null || processInstance == undefined || processInstance == 0) {
            //Carpeta, Id del cliente, nombre documento con extension
            task.addInput(formaMapeo, "folder", folder);
            task.addInput(formaMapeo, "customerId", customerId);
            task.addInput(formaMapeo, "fileName", extension);
            task.addInput(formaMapeo, "version", version);
            formaMapeo.submit();
        } else {
            //Carpeta, Id del cliente, nombre documento con extension e instancia de proceso
            task.addInput(formaMapeo, "folder", folder);
            if (groupId != null) {
                task.addInput(formaMapeo, "groupId", groupId);
            }
            task.addInput(formaMapeo, "processInstanceId", processInstance);
            task.addInput(formaMapeo, "customerId", customerId);
            task.addInput(formaMapeo, "fileName", extension);
            task.addInput(formaMapeo, "version", version);
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

    //DocumentHistoryQuery Entity: 
    task.executeQuery.Q_DOCUMEHR_9834 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;;

//Entity: QueryDocumentHistory
    //QueryDocumentHistory. (Button) View: QueryDocumentsHistory
    
    task.gridRowCommand.VA_GRIDROWCOMMMDNA_321376 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.downloadHistorical(entities, gridRowCommandEventArgs);
    };

//gridRowRendering QueryView: QV_9834_40050
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_9834_40050 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            
        };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QueryDocumentsCredit
    task.initData.VC_CREDITDOUE_237252 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.grid.hideColumn('QV_9834_40050','cmdEdition');
		var filtro = {
            processInstance: initDataEventArgs.commons.api.parentVc.customDialogParameters.processInstance,
            customerId: initDataEventArgs.commons.api.parentVc.customDialogParameters.customerId,
            groupId: initDataEventArgs.commons.api.parentVc.customDialogParameters.groupId,
            description: initDataEventArgs.commons.api.parentVc.customDialogParameters.description,
            documentId: initDataEventArgs.commons.api.parentVc.customDialogParameters.documentId,
            extension: initDataEventArgs.commons.api.parentVc.customDialogParameters.extension,
            folder: initDataEventArgs.commons.api.parentVc.customDialogParameters.folder
		}
		initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMEHR_9834', filtro);
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: QueryDocumentsCredit
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
    };



}));