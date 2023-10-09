
/* variables locales de T_CSTMRNSVOOQTG_525*/


/* variables locales de T_LEGALPERSOENE_749*/

/* variables locales de T_CSTMRAUGMCYDF_966*/

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

    
        var task = designerEvents.api.scanneddocuments;
    

    //"TaskId": "T_CSTMRNSVOOQTG_525"
var taskHeader = {};
var typeRequest = ''; //caso#162288
var mode = ''; //caso#162288
var activeChangeIniDocs = false; //caso153311

task.loadTaskHeader = function (entities, eventArgs) {
    var client = eventArgs.commons.api.parentVc.model.Task;
    var originalh = entities.OriginalHeader;

    // Titulo de la cabecera (title)
    LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);

    // Subtitulos de la cabecera       
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.iDRequested == null || originalh.iDRequested == '0' ? '--' : originalh.iDRequested), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', (entities.OriginalHeader.category == null ? ' ' : entities.OriginalHeader.category), 0) //SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', LATFO.CONVERT.CURRENCY.Format((originalh.amountRequested == null || originalh.amountRequested == 'null' ? 0 : originalh.amountRequested), 2), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', LATFO.CONVERT.CURRENCY.Format((originalh.amountAproved == null || originalh.amountAproved == 'null' ? 0 : originalh.amountAproved), 2), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.OriginalHeader.term, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.GeneralData.paymentFrecuencyName, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', (entities.OriginalHeader.productType == null ? ' ' : entities.OriginalHeader.productType) + " " + (entities.OriginalHeader.subType == null ? ' ' : entities.OriginalHeader.subType), 1); //SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.GeneralData.vinculado, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.GeneralData.sectorNeg, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', (entities.Context.flag1 == null ? '--' : entities.Context.flag1), 1);
    // Actualizo el grupo de designer
    LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_LEGALPEARR_339688');
};


    	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ScannedDocuments
task.initData.VC_SCANNEDDMO_244525 = function (entities, initDataEventArgs) {
    var parentParameters = initDataEventArgs.commons.api.parentVc.model;
    entities.OriginalHeader.applicationNumber = parentParameters.Task.processInstanceIdentifier;
    entities.OriginalHeader.productType = parentParameters.Task.bussinessInformationStringTwo;
    entities.GeneralData.clientId = parentParameters.Task.clientId
    var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;

    typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
    mode = customDialogParameters.Task.urlParams.MODE;

    //initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    initDataEventArgs.commons.serverParameters.GeneralData = true;
    initDataEventArgs.commons.serverParameters.OriginalHeader = true;
    initDataEventArgs.commons.serverParameters.Context = true;
    initDataEventArgs.commons.api.viewState.hide('G_SCANNEDDSD_789611');

};

	//Start signature to Callback event to VC_SCANNEDDMO_244525
task.initDataCallback.VC_SCANNEDDMO_244525 = function (entities, initDataCallbackEventArgs) {
    task.loadTaskHeader(entities, initDataCallbackEventArgs);
};


	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: ScannedDocuments
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    var parentParameters = renderEventArgs.commons.api.parentVc.model;
    var customerId = (parentParameters.Task.clientId != null) ? parseInt(parentParameters.Task.clientId) : 0;

    var customDialogParameters = renderEventArgs.commons.api.vc.parentVc.customDialogParameters;
    var typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;

    if (typeRequest == 'COLECTIVOS') {
        parentParameters.InboxContainerPage.HiddenInCompleted = "YES";
    }

    //Filtro para llenado de executeQuery
    var filtro = {
        customerId: customerId,
        processInstance: parentParameters.Task.processInstanceIdentifier,
        typeRequest: typeRequest
    }
    renderEventArgs.commons.api.grid.refresh('QV_7463_28553', filtro);
};

	//gridAfterLeaveInLineRow QueryView: QV_7463_28553
        //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
        task.gridAfterLeaveInLineRow.QV_7463_28553 = function (entities,gridAfterLeaveInLineRowEventArgs) {
            gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'uploaded');
        };

	//gridBeforeEnterInLineRow QueryView: QV_7463_28553
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_7463_28553 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXTFB_124611');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'file');
	    gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'uploaded');
        };

	// (Button) 
    task.executeCommand.VA_VABUTTONILJIEMT_921611 = function(  entities, executeCommandEventArgs ) {
       console.log('Ingresa');

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters. = true;
    };

	//Start signature to Callback event to VA_VABUTTONILJIEMT_921611
task.executeCommandCallback.VA_VABUTTONILJIEMT_921611 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    console.log('Ingresa a collback')
        if(entities.DocumentsUpload.uploads){
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Los documentos fueron completados', true);
        } else {
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('Faltan documentos por subir', true);
        }
};

	//ScannedDocumentsDetQuery Entity: 
    task.executeQuery.Q_SCANNELD_7463 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//Start signature to Callback event to Q_SCANNELD_7463
task.executeQueryCallback.Q_SCANNELD_7463 = function(entities, executeQueryCallbackEventArgs) {
    if (executeQueryCallbackEventArgs.success) {
        var action = true;
        if(entities.ScannedDocumentsDetail.data().length != 0){
            for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                if(entities.ScannedDocumentsDetail.data()[i].uploaded === false){
                    action = false;
                }
            }
        }
        if (action === true){
            executeQueryCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_STR');
            executeQueryCallbackEventArgs.commons.api.viewState.enable('CM_TPROSPEC_STR');
        }
    }
	
	// Inicio Caso153311
    if(activeChangeIniDocs){
		activeChange = true
	    activeChangeIniDocs = false
	}// Fin Caso153311
	
    //Click tab inicial
	if(angular.isDefined(cargaInicial) && cargaInicial && angular.isDefined(activeChange) && activeChange){
		executeQueryCallbackEventArgs.commons.api.vc.clickTab(executeQueryCallbackEventArgs,'VC_DDRWXFYTSU_498680', 'VC_KXWIBTYNCU_272226', true);
		$("#VC_KXWIBTYNCU_272226_tab").prop("class","active");
		$("#VC_HVDQINWTYF_467680_tab").removeClass("active");
		cargaInicial = false;
	}
    
};


	task.gridInitColumnTemplate.QV_7463_28553 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'uploaded'){
            var template = "<span";
            template +=  "#if(uploaded == 'N'){# class=\"fa fa-times\" #}#"
			template +=  "#if(uploaded == 'S'){# class=\"fa fa-check\" #}#"
			template +=  "#if(uploaded == null){# class=\"fa fa-times\" #}#"
			template +=  "></span>"
         return template;
        }
    
};

	task.gridInitEditColumnTemplate.QV_7463_28553 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

	//Entity: ScannedDocumentsDetail
    //ScannedDocumentsDetail. (Button) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMNDD_972611 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
        var extension = gridRowCommandEventArgs.rowData.extension.trim();
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
		
		formaMapeo.submit();
  
    };

	//Entity: ScannedDocumentsDetail
    //ScannedDocumentsDetail.file (FileUpload) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_TEXTINPUTBOXTFB_124611 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = true;
    };

	//Start signature to Callback event to VA_TEXTINPUTBOXTFB_124611
task.gridRowCommandCallback.VA_TEXTINPUTBOXTFB_124611 = function(entities, gridRowCommandCallbackEventArgs) {
gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
	   }
};

	//gridRowRendering QueryView: QV_7463_28553
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7463_28553 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    gridRowRenderingEventArgs.commons.api.viewState.enable('G_SCANNEDCIM_218611');

	if (typeRequest != CSTMR.CONSTANTS.TypeRequest.NORMAL){ //caso#162288
        gridRowRenderingEventArgs.commons.api.viewState.hide('VA_VABUTTONILJIEMT_921611');	
	}
	
    //Funcionalidad para habilitar o deshabilitar el botÃ³n de descarga
    if (gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null) {
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
    } else {
        //cambiar esto has corregir error de uid en gridRowUpdating
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
        gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611', 'disabled', false);
    }
    //Ocultar y desocultar columnas
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'customerName');
    gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_7463_28553', 'uploaded');
    if (angular.isDefined(gridRowRenderingEventArgs.commons.api.vc.parentVc)) {
        //aprobacion de prestamo
        //gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'cmdEdition');
    }
    
    if(mode == 'Q'){ //caso#162288                
        var ds = entities.ScannedDocumentsDetail.data();
        for (var i = 0; i < ds.length; i++) {   
            var dsRow = ds[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', dsRow, 'edit');            
        }
    }

};

	//gridRowUpdating QueryView: QV_7463_28553
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_7463_28553 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            gridRowUpdatingEventArgs.rowData.extension = gridRowUpdatingEventArgs.rowData.file.substring((gridRowUpdatingEventArgs.rowData.file).lastIndexOf(".")+1);
			gridRowUpdatingEventArgs.rowData.file = "";
            //Descomentar esto cuando en el gridRowUpdatingEventArgs este llegando el uid
            /*if(gridRowUpdatingEventArgs.rowData.uploaded == 'S'){
				gridRowUpdatingEventArgs.commons.api.grid.removeCellStyle('QV_7463_28553',gridRowUpdatingEventArgs.rowData,'VA_GRIDROWCOMMMNDD_972611','disabled',true);
			}*/
            var action = true;
            if(entities.ScannedDocumentsDetail.data().length != 0){
                for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                    if(entities.ScannedDocumentsDetail.data()[i].uploaded === 'N'){
                        action = false;
                    }
                }
            }
            if (action === true){
                gridRowUpdatingEventArgs.commons.api.viewState.show('CM_TPROSPEC_STR');
                gridRowUpdatingEventArgs.commons.api.viewState.enable('CM_TPROSPEC_STR');
            }
        };



}));