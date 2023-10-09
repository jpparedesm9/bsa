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
