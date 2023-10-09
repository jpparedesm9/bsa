//"TaskId": "T_ASSTSDVYDGJCT_107"

task.download = function (entities, gridRowCommandEventArgs) {
    
    var extension = gridRowCommandEventArgs.rowData.extension.trim();
    var folder = gridRowCommandEventArgs.rowData.folder;
    var formaMapeo = document.createElement("form");
    formaMapeo.method = "POST"; 
    formaMapeo.action = "/CTSProxy/services/cobis/web/customer/GetFileServlet";

    if(gridRowCommandEventArgs.rowData.groupId > 0)	{
        var mapeoInput = document.createElement("input");
        mapeoInput.type = "hidden";
        mapeoInput.name = "groupId";
        mapeoInput.value = gridRowCommandEventArgs.rowData.groupId;
        formaMapeo.appendChild(mapeoInput);				
        document.body.appendChild(formaMapeo);
    }

    if(gridRowCommandEventArgs.rowData.processInstance > 0){
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
    mapeoInput4.value = gridRowCommandEventArgs.rowData.documentId+"."+extension;
    formaMapeo.appendChild(mapeoInput4);				
    document.body.appendChild(formaMapeo);
    
    if(folder != null){
        var mapeoInput5 = document.createElement("input");
        mapeoInput5.type = "hidden";
        mapeoInput5.name = "folder";
        mapeoInput5.value = folder;
        formaMapeo.appendChild(mapeoInput5);				
        document.body.appendChild(formaMapeo);
    }
    
    formaMapeo.submit();
    
};