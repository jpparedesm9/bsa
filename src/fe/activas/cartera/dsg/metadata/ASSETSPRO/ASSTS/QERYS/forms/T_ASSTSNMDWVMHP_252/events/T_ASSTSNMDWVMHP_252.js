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