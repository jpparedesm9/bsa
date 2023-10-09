//Designer Generator v 1.13.2 - release ART 13.2 28/11/2014
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskqueryoperation;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //
    task.change.VA_VIWROPRAIO5604_ACON597 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
		if(entities.DatosGeneralesOperacion.Operation == null || entities.DatosGeneralesOperacion.Operation == ""){
        changeEventArgs.commons.execServer = false; //el mensaje de err no baja al svr
        changeEventArgs.commons.api.grid.showColumn('QV_BOREG0798_55', 'Address');
		}
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };

    //
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
		   queryViewCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************

    //
    task.render = function(entities, renderEventArgs) {
        //renderEventArgs.commons.execServer = false;
		 renderEventArgs.commons.api.grid.showColumn('QV_BOREG0798_55', 'Address');
    };
}());