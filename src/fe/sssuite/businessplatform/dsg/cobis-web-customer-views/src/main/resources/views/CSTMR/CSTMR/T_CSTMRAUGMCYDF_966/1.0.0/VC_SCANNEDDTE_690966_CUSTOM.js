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

    
        var task = designerEvents.api.scanneddocumentsdetail;
    

    //"TaskId": "T_CSTMRAUGMCYDF_966"
task.gridRowCommandCallback.VA_TEXTINPUTBOXTFB_124611 = function(  entities, gridRowCommandCallbackEventArgs ) {
       gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
	   }
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
    
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
    for (var i = 0; i < scannedDocumentsDetailList.length; i++) {
        if (scannedDocumentsDetailList[i].documentId == '010') {
            posDataModRequest = i;
            break;
        }
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

        var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            entities.Context.addressState = 'N';
            entities.Context.mailState = 'N';
        }
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
    
    if(screenMode == 'Q'){ //caso#162288 --se cambio el mode que estaba del caso 162288 a screenMode por problemas en pantalla   
        var ds = entities.ScannedDocumentsDetail.data();
        for (var i = 0; i < ds.length; i++) {   
            var dsRow = ds[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', dsRow, 'edit');            
        }
    }

    if (screenMode != 'Q' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        if (entities.Person.statusCode == 'A' && entities.Context.roleEnabledDataModRequest != 'S' && gridRowRenderingEventArgs.rowData.documentId == '010') {
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'edit');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7463_28553', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNDD_972611');
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