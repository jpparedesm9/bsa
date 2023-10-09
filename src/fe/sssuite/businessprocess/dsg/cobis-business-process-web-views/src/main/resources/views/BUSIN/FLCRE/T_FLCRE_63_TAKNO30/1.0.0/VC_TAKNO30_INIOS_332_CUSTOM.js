<!-- Designer Generator v 5.0.0.1515 - release SPR 2015-15 07/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.tasksindicos;

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //CM_Accept (Button) 
    task.executeCommand.CM_TAKNO30ACT14 = function(entities, executeCommandEventArgs) {
		var group = executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().group;
		entities.HeaderPunishment.GroupID = group.GroupID;
        executeCommandEventArgs.commons.execServer = false;
		if ((entities.HeaderPunishment.Sindico1 != null && entities.HeaderPunishment.Sindico1 != undefined && entities.HeaderPunishment.Sindico1 != '') && 
			(entities.HeaderPunishment.Sindico2 != null && entities.HeaderPunishment.Sindico2 != undefined && entities.HeaderPunishment.Sindico2 != '') ){
				var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.Affidavit],['grupo',group.GroupID]];			   
				BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.Affidavit,args);			
				//APCH
				var args1 = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.ReportRequestPunishment],['grupo',entities.HeaderPunishment.GroupID]];		
		        BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.ReportRequestPunishment,args1);
				var result = [entities.HeaderPunishment.Sindico1,entities.HeaderPunishment.Sindico2];
				executeCommandEventArgs.commons.api.vc.closeModal(result);
			}else{
				executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_GLNMRELSD_95664');
			}		
    };

	
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: Sindicos 
    task.initData.VC_TAKNO30_INIOS_332 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: Sindicos 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
    };

}());