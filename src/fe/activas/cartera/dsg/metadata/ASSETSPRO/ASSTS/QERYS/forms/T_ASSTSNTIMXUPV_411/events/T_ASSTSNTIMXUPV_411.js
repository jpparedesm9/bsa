//"TaskId": "T_ASSTSNTIMXUPV_411"
    function loadFindCustomer(nav,textInputName){
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

        var extension = gridRowCommandEventArgs.rowData.extension.trim();
        var groupId = gridRowCommandEventArgs.rowData.groupId;
        var processInstance = gridRowCommandEventArgs.rowData.processInstance;
        var customerId = gridRowCommandEventArgs.rowData.customerId;
        var folder = gridRowCommandEventArgs.rowData.folder;
        var formaMapeo = document.createElement("form");
        formaMapeo.method = "POST"; 
        formaMapeo.action = "/CTSProxy/services/cobis/web/customer/GetFileServlet";

        if(groupId > 0)	{
            var mapeoInput = document.createElement("input");
            mapeoInput.type = "hidden";
            mapeoInput.name = "groupId";
            mapeoInput.value = groupId;
            formaMapeo.appendChild(mapeoInput);				
            document.body.appendChild(formaMapeo);
        }

        if(processInstance > 0){
            var mapeoInput2 = document.createElement("input");
            mapeoInput2.type = "hidden";
            mapeoInput2.name = "processInstanceId";
            mapeoInput2.value = processInstance;
            formaMapeo.appendChild(mapeoInput2);				
            document.body.appendChild(formaMapeo);
        }
        
        if(customerId > 0){
            var mapeoInput3 = document.createElement("input");
            mapeoInput3.type = "hidden";
            mapeoInput3.name = "customerId";
            mapeoInput3.value = customerId;
            formaMapeo.appendChild(mapeoInput3);				
            document.body.appendChild(formaMapeo);
        }
            
        if(((groupId <= 0)||(groupId === null)||(groupId === undefined)) && ((customerId <= 0)||(customerId === null)||(customerId === undefined)) && (processInstance > 0)){
            var mapeoInput4 = document.createElement("input");
            mapeoInput4.type = "hidden";
            mapeoInput4.name = "fileName";
            mapeoInput4.value = extension; //Nombre del documento
            formaMapeo.appendChild(mapeoInput4);				
            document.body.appendChild(formaMapeo);
        } else{
            var mapeoInput4 = document.createElement("input");
            mapeoInput4.type = "hidden";
            mapeoInput4.name = "fileName";
            mapeoInput4.value = gridRowCommandEventArgs.rowData.documentId+"."+extension;
            formaMapeo.appendChild(mapeoInput4);				
            document.body.appendChild(formaMapeo);
        }
        
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