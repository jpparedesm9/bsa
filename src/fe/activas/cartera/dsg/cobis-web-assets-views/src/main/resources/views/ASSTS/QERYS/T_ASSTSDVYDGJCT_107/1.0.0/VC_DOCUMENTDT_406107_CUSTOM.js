/* variables locales de T_ASSTSDVYDGJCT_107*/
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

    
        var task = designerEvents.api.querydocumentsgriddetail;
    

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

//gridAfterLeaveInLineRow QueryView: QV_2153_73215
//Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
task.gridAfterLeaveInLineRow.QV_2153_73215 = function (entities,gridAfterLeaveInLineRowEventArgs) {
    gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
    gridAfterLeaveInLineRowEventArgs.commons.api.grid.refresh('QV_2153_73215');      
};

//gridBeforeEnterInLineRow QueryView: QV_2153_73215
//Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
task.gridBeforeEnterInLineRow.QV_2153_73215 = function (entities,gridBeforeEnterInLineRowEventArgs) {
    gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
    gridBeforeEnterInLineRowEventArgs.commons.api.viewState.show('VA_TEXTINPUTBOXWLC_118831');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.showColumn('QV_2153_73215', 'file');
    gridBeforeEnterInLineRowEventArgs.commons.api.grid.hideColumn('QV_2153_73215', 'uploaded');
};

//ScannedDocumentDetailsQuery Entity: 
    task.executeQuery.Q_SCANNEEE_2153 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
    };

//Start signature to Callback event to Q_SCANNEEE_2153
task.executeQueryCallback.Q_SCANNEEE_2153 = function(entities, executeQueryCallbackEventArgs) {
//here your code    
};

task.gridInitColumnTemplate.QV_2153_73215 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'uploaded'){
            var template = "<span";
            template +=  "#if(uploaded == 'N'){# class=\"fa fa-times\" #}#"
			template +=  "#if(uploaded == 'S'){# class=\"fa fa-check\" #}#"
			template +=  "#if(uploaded == null){# class=\"fa fa-times\" #}#"
			template +=  "></span>"
         return template;
        }
    
};

task.gridInitEditColumnTemplate.QV_2153_73215 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Entity: QueryDocumentGridDetail
    //QueryDocumentGridDetail. (Button) View: QueryDocumentsGridDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMDDD_941831 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        task.download(entities, gridRowCommandEventArgs);
    };

//Entity: QueryDocumentGridDetail
    //QueryDocumentGridDetail. (Button) View: QueryDocumentsGridDetail
    
    task.gridRowCommand.VA_GRIDROWCOMMMDND_285831 = function(  entities, gridRowCommandEventArgs ) {
        gridRowCommandEventArgs.commons.execServer = false;
        //Open Modal
        ASSETS.Navigation.openHistorical(gridRowCommandEventArgs.rowData, gridRowCommandEventArgs, 'VA_GRIDROWCOMMMDND_285831');
    };

//Entity: QueryDocumentGridDetail
    //QueryDocumentGridDetail.file (FileUpload) View: QueryDocumentsGridDetail
    
    task.gridRowCommand.VA_TEXTINPUTBOXWLC_118831 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = true;
    
        //gridRowCommandEventArgs.commons.serverParameters.QueryDocumentGridDetail = true;
    };

//Start signature to Callback event to VA_TEXTINPUTBOXWLC_118831
task.gridRowCommandCallback.VA_TEXTINPUTBOXWLC_118831 = function(entities, gridRowCommandCallbackEventArgs) {
    gridRowCommandCallbackEventArgs.commons.execServer = false;
    if(gridRowCommandCallbackEventArgs.success){
        gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_2153_73215', 'file');
        gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
    }
};

//gridRowRendering QueryView: QV_2153_73215
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_2153_73215 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;

	if (gridRowRenderingEventArgs.rowData.enableEditing != 'S')
    	gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_2153_73215','cmdEdition');//

    //Funcionalidad para habilitar o deshabilitar el botón de descarga
	if(gridRowRenderingEventArgs.rowData.uploaded == 'N' || gridRowRenderingEventArgs.rowData.uploaded == null){
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_941831','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDND_285831','disabled',false);
	}else{
      //cambiar esto has corregir error de uid en gridRowUpdating
		gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_941831','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDDD_941831','disabled',false);
        gridRowRenderingEventArgs.commons.api.grid.addCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDND_285831','disabled',false);
		gridRowRenderingEventArgs.commons.api.grid.removeCellStyle('QV_2153_73215',gridRowRenderingEventArgs.rowData,'VA_GRIDROWCOMMMDND_285831','disabled',false);
	}
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: QueryDocumentsGridDetail
task.initData.VC_DOCUMENTDT_406107 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    //initDataEventArgs.commons.api.grid.hideColumn('QV_2153_73215','cmdEdition');
	
	var filtro = {
		processInstance: initDataEventArgs.commons.api.vc.rowData.processInstance,
		customerId: initDataEventArgs.commons.api.vc.rowData.clientId
	}
	initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_SCANNEEE_2153', filtro);
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMEAL_3671', filtro);
	
    initDataEventArgs.commons.api.grid.hideColumn('QV_2153_73215', 'file');

};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: QueryDocumentsGridDetail
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
    };

//gridRowUpdating QueryView: QV_2153_73215
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_2153_73215 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            
        };



}));