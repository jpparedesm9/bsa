/* variables locales de T_ASSTSNTIMXUPV_411*/
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

    
        var task = designerEvents.api.querydocuments;
    

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

    //gridAfterLeaveInLineRow QueryView: QV_5385_46042
//Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
task.gridAfterLeaveInLineRow.QV_5385_46042 = function (entities,gridAfterLeaveInLineRowEventArgs) {
    gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
    gridAfterLeaveInLineRowEventArgs.commons.api.grid.refresh('QV_5385_46042');
};

//gridBeforeEnterInLineRow QueryView: QV_5385_46042
//Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
task.gridBeforeEnterInLineRow.QV_5385_46042 = function (entities,gridBeforeEnterInLineRowEventArgs) {
    gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
    gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXSYD_837273');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_5385_46042', 'file');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_5385_46042', 'uploaded');
};

//showGridRowDetailIcon QueryView: QV_9888_36569
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_9888_36569 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments. (Button) View: QueryDocuments
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRLGUJMS_186273 = function(  entities, executeCommandEventArgs ) {

        executeCommandEventArgs.commons.execServer = false;
        /*var filtro = {
		loan:entities.HeaderQueryDocuments.loan,//prestamo
		procedure:entities.HeaderQueryDocuments.procedure,//tramite
		groupId:entities.HeaderQueryDocuments.groupId,//grupo
		clientId:entities.HeaderQueryDocuments.clientId//cliente
	   }
		executeCommandEventArgs.commons.api.grid.refresh("QV_9888_36569",filtro);*/
    };

//QueryDocumentsGridQuery Entity: 
    task.executeQuery.Q_DOCUMETD_9888 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;

//Start signature to Callback event to Q_DOCUMETD_9888
task.executeQueryCallback.Q_DOCUMETD_9888 = function(entities, executeQueryCallbackEventArgs) {
    //Limpiamos campos de busqueda luego de traer los resultados
    entities.HeaderQueryDocuments.groupName = null;
	entities.HeaderQueryDocuments.groupId = null;
	entities.HeaderQueryDocuments.clientName = null;
	entities.HeaderQueryDocuments.clientId = null;
	entities.HeaderQueryDocuments.loan = null;
	entities.HeaderQueryDocuments.procedure = null;
};

//DocumentCreditQuery Entity: 
    task.executeQuery.Q_DOCUMETN_5385 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

task.gridInitColumnTemplate.QV_5385_46042 = function (idColumn) {
        if(idColumn === 'uploaded'){
            var template = "<span";
            template +=  "#if(uploaded == 'N'){# class=\"fa fa-times\" #}#"
			template +=  "#if(uploaded == 'S'){# class=\"fa fa-check\" #}#"
			template +=  "#if(uploaded == null){# class=\"fa fa-times\" #}#"
			template +=  "></span>"
         return template;
        }
    };

task.gridInitEditColumnTemplate.QV_5385_46042 = function (idColumn) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Entity: QueryDocumentCredit
    //QueryDocumentCredit. (Button) View: QueryDocuments
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAD_737273 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };

//Entity: QueryDocumentCredit
    //QueryDocumentCredit. (Button) View: QueryDocuments
    
    task.gridRowCommand.VA_GRIDROWCOMMMDDD_584273 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        //Open Modal
        ASSETS.Navigation.openHistorical(gridRowCommandEventArgs.rowData, gridRowCommandEventArgs, 'VA_GRIDROWCOMMMDDD_584273');
        
    };

//Entity: QueryDocumentCredit
    //QueryDocumentCredit.file (FileUpload) View: QueryDocuments
    
    task.gridRowCommand.VA_TEXTINPUTBOXSYD_837273 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = true;
    
        //gridRowCommandEventArgs.commons.serverParameters.QueryDocumentCredit = true;
    };

//Start signature to Callback event to VA_TEXTINPUTBOXSYD_837273
task.gridRowCommandCallback.VA_TEXTINPUTBOXSYD_837273 = function(entities, gridRowCommandCallbackEventArgs) {
    gridRowCommandCallbackEventArgs.commons.execServer = false;
    if (gridRowCommandCallbackEventArgs.success){
        gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_5385_46042', 'file');
        gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
    }
};

//gridRowRendering QueryView: QV_5385_46042
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_5385_46042 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
	
    if (gridRowRenderingEventArgs.rowData.enableEditing != 'S')
    	gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_5385_46042','cmdEdition');

    //Funcionalidad para habilitar o deshabilitar el botón de descarga
	if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_737273','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_584273','disabled',false);
	}else{
      //cambiar esto has corregir error de uid en gridRowUpdating
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_737273','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_737273','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_584273','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_5385_46042',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_584273','disabled',false);
	}
};

//gridInitDetailTemplate QueryView: QV_9888_36569
        //
        task.gridInitDetailTemplate.QV_9888_36569 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            //gridInitDetailTemplate
            var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;

            nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'QERYS',
            taskId: 'T_ASSTSDVYDGJCT_107',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_DOCUMENTDT_406107'
            };
            nav.queryParameters = {
            mode: 8
            };
            //nav.customDialogParameters = {
            //variable: value
            //};

            nav.openDetailTemplate("QV_9888_36569", gridInitDetailTemplateEventArgs.modelRow);
        };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: QueryDocuments
task.initData.VC_DOCUMENTSS_852411 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    //initDataEventArgs.commons.api.grid.hideColumn('QV_5385_46042','cmdEdition');
	
	var filtro = {
		processInstance: initDataEventArgs.commons.api.parentVc.customDialogParameters.processInstance,
		groupId: initDataEventArgs.commons.api.parentVc.customDialogParameters.groupId,
		cycle: initDataEventArgs.commons.api.parentVc.customDialogParameters.cycle,
		loan: initDataEventArgs.commons.api.parentVc.customDialogParameters.loan
	}
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMETN_5385', filtro);
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMETD_9888', filtro);
    initDataEventArgs.commons.api.grid.hideColumn('QV_5385_46042', 'file');

};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: QueryDocuments
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if(onCloseModalEventArgs.result.params != undefined){
            if(onCloseModalEventArgs.result.params.controlName == "cliente"){
		    	entities.HeaderQueryDocuments.clientName = onCloseModalEventArgs.result.selectedData.name;
		    	entities.HeaderQueryDocuments.clientId=onCloseModalEventArgs.result.selectedData.code;
		    }
            if(onCloseModalEventArgs.result.params.controlName == "grupo"){
		    	entities.HeaderQueryDocuments.groupName = onCloseModalEventArgs.result.selectedData.name;
		    	entities.HeaderQueryDocuments.groupId = onCloseModalEventArgs.result.selectedData.code;
		    }
		}
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.clientName (TextInputButton) View: QueryDocuments
    
    task.textInputButtonEvent.VA_CLIENTNAMEKVNFS_105273 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"cliente");
    
        
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.groupName (TextInputButton) View: QueryDocuments
    
    task.textInputButtonEvent.VA_GROUPNAMESGBTSG_671273 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"grupo");
        
    };

//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.clientName (TextInputButton) View: QueryDocuments
    
    task.textInputButtonEventGrid.VA_CLIENTNAMEKVNFS_105273 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Entity: ScannedDocuments
    //ScannedDocuments.groupName (TextInputButton) View: QueryDocuments
    
    task.textInputButtonEventGrid.VA_GROUPNAMESGBTSG_671273 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//gridRowUpdating QueryView: QV_5385_46042
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_5385_46042 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            
        };



}));