/* variables locales de T_BMTRCNYSSKGHD_541*/
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

    
        var task = designerEvents.api.documentgrid;
    

    //"TaskId": "T_BMTRCNYSSKGHD_541"

task.download = function (entities, gridRowCommandEventArgs) {

    var extension = gridRowCommandEventArgs.rowData.extension.trim();
    var folder = gridRowCommandEventArgs.rowData.folder;
    var formaMapeo = document.createElement("form");
    formaMapeo.method = "POST";
    formaMapeo.action = "/CTSProxy/services/cobis/web/customer/GetFileServlet";

    if (gridRowCommandEventArgs.rowData.groupId > 0) {
        var mapeoInput = document.createElement("input");
        mapeoInput.type = "hidden";
        mapeoInput.name = "groupId";
        mapeoInput.value = gridRowCommandEventArgs.rowData.groupId;
        formaMapeo.appendChild(mapeoInput);
        document.body.appendChild(formaMapeo);
    }

    if (gridRowCommandEventArgs.rowData.processInstance > 0) {
        var mapeoInput2 = document.createElement("input");
        mapeoInput2.type = "hidden";
        mapeoInput2.name = "processInstanceId";
        mapeoInput2.value = gridRowCommandEventArgs.rowData.processInstance;
        formaMapeo.appendChild(mapeoInput2);
        document.body.appendChild(formaMapeo);
    }

    var mapeoInput3 = document.createElement("input");
    mapeoInput3.type = "hidden";
    mapeoInput3.name = "customerId";
    mapeoInput3.value = gridRowCommandEventArgs.rowData.customerId;
    formaMapeo.appendChild(mapeoInput3);
    document.body.appendChild(formaMapeo);

    var mapeoInput4 = document.createElement("input");
    mapeoInput4.type = "hidden";
    mapeoInput4.name = "fileName";
    mapeoInput4.value = gridRowCommandEventArgs.rowData.documentId + "." + extension;
    formaMapeo.appendChild(mapeoInput4);
    document.body.appendChild(formaMapeo);

    if (folder != null) {
        var mapeoInput5 = document.createElement("input");
        mapeoInput5.type = "hidden";
        mapeoInput5.name = "folder";
        mapeoInput5.value = folder;
        formaMapeo.appendChild(mapeoInput5);
        document.body.appendChild(formaMapeo);
    }

    formaMapeo.submit();

};


    //undefined Entity: 
task.executeQuery.Q_DOCUMENN_7504 = function (executeQueryEventArgs) {
    executeQueryEventArgs.commons.execServer = true;
    //executeQueryEventArgs.commons.serverParameters. = true;
};

//Start signature to Callback event to Q_DOCUMENN_7504
task.executeQueryCallback.Q_DOCUMENN_7504 = function (entities, executeQueryCallbackEventArgs) {
    //here your code
};


task.gridInitColumnTemplate.QV_7504_88001 = function (idColumn, gridInitColumnTemplateEventArgs) {
    if (idColumn === 'uploaded') {
        var template = "<span";
        template += "#if(uploaded == 'N'){# class=\"fa fa-times\" #}#"
        template += "#if(uploaded == 'S'){# class=\"fa fa-check\" #}#"
        template += "#if(uploaded == null){# class=\"fa fa-times\" #}#"
        template += "></span>"
        return template;
    }
};

task.gridInitEditColumnTemplate.QV_7504_88001 = function (idColumn, gridInitColumnTemplateEventArgs) {
    //if(idColumn === 'NombreColumna'){
    //  return "<span></span>";
    //}
    //if(idColumn === 'NombreColumna'){
    //  return  "<span data-bind='text:nombreColumna'><span>" ;
    //}
};

//Entity: Document
//Document. (Button) View: DocumentGrid

task.gridRowCommand.VA_GRIDROWCOMMMNAN_389731 = function (entities, gridRowCommandEventArgs) {
    gridRowCommandEventArgs.commons.execServer = false;
    task.download(entities, gridRowCommandEventArgs);
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: DocumentGrid
task.initData.VC_DOCUMENTDD_249541 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;

    var filtro = {
        customerId: initDataEventArgs.commons.api.parentVc.customDialogParameters.customerId
    }
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMENN_7504', filtro);
};



}));