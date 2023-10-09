/* variables locales de T_LOANSTIAEJUNH_604*/
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
    

    //"TaskId": "T_LOANSTIAEJUNH_604"
    task.gridRowCommandCallback.VA_TEXTINPUTBOXLEM_317904 = function(  entities, gridRowCommandCallbackEventArgs ) {
       gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_6397_58590', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
	   }
    };
    task.gridRowCommandCallback.VA_TEXTINPUTBOXLDM_787904 = function(  entities, gridRowCommandCallbackEventArgs ) {
       gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_4137_63627', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
	   }
    };

task.download = function (entities, gridRowCommandEventArgs) {
    var extension = gridRowCommandEventArgs.rowData.extension.trim();
    var formaMapeo = document.createElement("form");
    formaMapeo.method = "POST"; 
    formaMapeo.action = "/CTSProxy/services/cobis/web/customer/GetFileServlet";
    
    if((gridRowCommandEventArgs.rowData.groupId != 0) && (gridRowCommandEventArgs.rowData.groupId != null)){
        var mapeoInput = document.createElement("input");
        mapeoInput.type = "hidden";
        mapeoInput.name = "groupId";
        mapeoInput.value = gridRowCommandEventArgs.rowData.groupId;
        formaMapeo.appendChild(mapeoInput);				
        document.body.appendChild(formaMapeo);
    }
    
    if((gridRowCommandEventArgs.rowData.processInstance != 0) && (gridRowCommandEventArgs.rowData.processInstance != null)){
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

    //gridAfterLeaveInLineRow QueryView: QV_6397_58590
        //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
        task.gridAfterLeaveInLineRow.QV_6397_58590 = function (entities,gridAfterLeaveInLineRowEventArgs) {
            gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.showColumn('QV_6397_58590', 'uploaded');
        };

//gridBeforeEnterInLineRow QueryView: QV_6397_58590
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_6397_58590 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXLEM_317904');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_6397_58590', 'file');
            gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_6397_58590', 'uploaded');
        };

//ScannedDocumentsQuery Entity: 
    task.executeQuery.Q_SCANNEDD_6397 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;

//Start signature to Callback event to Q_SCANNEDD_6397
task.executeQueryCallback.Q_SCANNEDD_6397 = function(entities, executeQueryCallbackEventArgs) {
//here your code
    executeQueryCallbackEventArgs.commons.api.viewState.disable("VA_GRIDROWCOMMMAAD_760904");
};

task.gridInitColumnTemplate.QV_6397_58590 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'uploaded'){
            var template = "<span";
            template +=  "#if(uploaded == 'N'){# class=\"fa fa-times\" #}#"
			template +=  "#if(uploaded == 'S'){# class=\"fa fa-check\" #}#"
			template +=  "#if(uploaded == null){# class=\"fa fa-times\" #}#"
			template +=  "></span>"
         return template;
        }
};

task.gridInitEditColumnTemplate.QV_6397_58590 = function (idColumn, gridInitColumnTemplateEventArgs) {
        
    };

//Entity: ScannedDocumentsDetail
    //ScannedDocumentsDetail.undefined (Button) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAD_760904 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };

//Entity: ScannedDocumentsDetail
    //ScannedDocumentsDetail.file (FileUpload) View: ScannedDocumentsDetail
    
    task.gridRowCommand.VA_TEXTINPUTBOXLEM_317904 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = true;
    };

//gridRowRendering QueryView: undefined
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_6397_58590 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            //Funcionalidad para habilitar o deshabilitar el botón de descarga
            if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
				gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_6397_58590',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',false);
			}else{
              //cambiar esto has corregir error de uid en gridRowUpdating
                gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_6397_58590',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',false);
				gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_6397_58590',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',false);
			}
            
            //Ocultar y desocultar columnas
			gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_6397_58590', 'file');
            gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_6397_58590', 'uploaded');
        };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ScannedDocumentsDetail
    task.initData.VC_SCANNEDDAE_495604 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var members = initDataEventArgs.commons.api.vc.rowData.members;
		var customerId = members.split("-");
        var taskViews = initDataEventArgs.commons.api.vc.parentVc.parentVc.model.TaskViews;
        var taskView  = taskViews == null || taskViews.length < 2 ? null : (taskViews[2] == null ? null : taskViews[2].componentDetailUrl);
        var params = taskView == null? null : taskView.split("?");
        var valueCode =  params == null || params < 1 ? null: params[1].split("=");
        var typeRequest = valueCode == null ? "": valueCode[1];
        
		var filtro = {
			customerId: customerId[0],
			groupId: initDataEventArgs.commons.api.parentVc.model.Group.code,
			processInstance: initDataEventArgs.commons.api.parentVc.model.Credit.applicationNumber,
            typeRequest: typeRequest
		}
		initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_SCANNEDD_6397', filtro);
        initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_SCANNEEC_4137', filtro);
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ScannedDocumentsDetail
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.grid.hideColumn('QV_6397_58590', 'file');
        renderEventArgs.commons.api.grid.hideColumn('QV_4137_63627', 'file');
    };

//gridRowUpdating QueryView: QV_6397_58590
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_6397_58590 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            gridRowUpdatingEventArgs.rowData.extension = gridRowUpdatingEventArgs.rowData.file.substring((gridRowUpdatingEventArgs.rowData.file).lastIndexOf(".")+1);
			gridRowUpdatingEventArgs.rowData.file = "";
            //Descomentar esto cuando en el gridRowUpdatingEventArgs este llegando el uid
            /*if(gridRowUpdatingEventArgs.rowData.uploaded == 'S'){
				gridRowUpdatingEventArgs.commons.api.grid.removeCellStyle('QV_6397_58590',gridRowUpdatingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',true);
			}*/
        };



}));