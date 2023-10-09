<!-- Designer Generator v 6.0.0 - release SPR 2016-13 08/07/2016 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.tobservationpenalization;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de cabecera.
    //  task.changeWithError.allGroup = true;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de grilla.
    //  task.changeWithError.allGrid = true;

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Acpetar (Button) 
    task.executeCommand.CM_TAONE32TAR13 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		
		var rowHeaderPunishment = entities.HeaderPunishment;
   		executeCommandEventArgs.commons.api.vc.closeModal(rowHeaderPunishment);
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

    //Cancelar (Button) 
    task.executeCommand.CM_TAONE32CAR77 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		
		executeCommandEventArgs.commons.api.vc.closeModal("");
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };
	
	 //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: FGeneralPenalization 
    task.initData.VC_TAONE32_GEPLI_734 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
        // initDataEventArgs.commons.serverParameters.entityName = true;
		var customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();  
        if(customDialogParameters != undefined ){
			entities.HeaderPunishment = customDialogParameters.HeaderPunishmentRow;
        }
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: FGeneralPenalization 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
    };

}());