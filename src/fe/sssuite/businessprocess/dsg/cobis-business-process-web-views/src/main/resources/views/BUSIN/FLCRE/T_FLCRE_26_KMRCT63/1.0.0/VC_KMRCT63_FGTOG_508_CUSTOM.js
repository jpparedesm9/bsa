<!-- Designer Generator v 5.0.0.1507 - release SPR 2015-06 17/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor

    var task = designerEvents.api.taskemergentcatalog;
    var emergentDialogParameters;
	 var selectedResponse ;
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //.Cancelar (Button) View: ViewEmergentList 
    task.executeCommand.VA_EMEGENTLIT4806_0000006 = function(entities, executeCommandEventArgs) {
	    executeCommandEventArgs.commons.api.vc.closeModal(); 
        executeCommandEventArgs.commons.execServer = false;
    };

    //.Buscar (Button) View: ViewEmergentList 
    task.executeCommand.VA_EMEGENTLIT4871_0000308 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };

    //EmergentCatalog.Aceptar (Button) View: ViewEmergentList 
    task.executeCommand.VA_EMEGENTLIT4806_0000164 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		selectedResponse = executeCommandEventArgs.commons.api.grid.getSelectedRows('QV_QEYME5063_04');
		 var result = {parameterEmergent: selectedResponse};
		 executeCommandEventArgs.commons.api.vc.closeModal(result);	
        
    };
    
    //EmergentCatalog.Description (TextInputBox) View: ViewEmergentList 
    task.change.VA_EMEGENTLIT4871_ECRI325 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

    //**********************************************************
    //  Eventos de QUERY
    //**********************************************************    
    //QueryEmergentList  Entity: EmergentList 
    task.executeQuery.Q_QEYMERET_5063 = function(executeQueryEventArgs) {
        executeQueryEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //SelectingMult QueryView: GridEmergentList 
    task.gridRowSelecting.QV_QEYME5063_04 = function(entities, gridRowSelectingEventArgs) {
         //emergentDialogParameters= gridRowSelectingEventArgs.rowData;
         gridRowSelectingEventArgs.commons.execServer = false;
		  
 /*       var count = 0;
			for (var i = 0; i < entities.EmergentList.data().length; i++) {
				var row = entities.EmergentList.data()[i];
				if(row.emergentDialogParameters ==  gridRowSelectingEventArgs.rowData.emergentDialogParameters){
					count++;
				}
			}
   */     
    
        
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormEmergentCatalog 
    task.initData.VC_KMRCT63_FGTOG_508 = function(entities, initDataEventArgs) {
         initDataEventArgs.commons.execServer = true;
    };

}());