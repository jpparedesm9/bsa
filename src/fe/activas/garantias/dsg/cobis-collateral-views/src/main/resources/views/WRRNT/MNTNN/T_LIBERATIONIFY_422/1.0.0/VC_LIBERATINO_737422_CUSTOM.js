/*global designerEvents, console */
(function () {
    "use strict";

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

    var task = designerEvents.api.liberation;

//"TaskId": "T_LIBERATIONIFY_422"

// (Button) 
    task.executeCommand.CM_TLIBERAT_1TL = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal(true);
    };

// (Button) 
    task.executeCommand.CM_TLIBERAT_T16 = function(entities, executeCommandEventArgs) {
        //executeCommandEventArgs.commons.execServer = true;
       
       
			var msgConfirm = "WRRNT.LBL_WRRNT_ESTSEGUEN_20114";
			
			return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm(msgConfirm).then(function(resp){
				var response = false;
				switch(resp.buttonIndex){
					case 0 : //CANCEL
							executeCommandEventArgs.commons.execServer = false;
							break;
					case 1 : //ACCEPT													
				            executeCommandEventArgs.commons.execServer = true;
							response = true;
							break;
				}
				return response;
			});
        
        

    };

//Start signature to Callback event to CM_TLIBERAT_T16
task.executeCommandCallback.CM_TLIBERAT_T16 = function(entities, executeCommandCallbackEventArgs) {

    var args = executeCommandCallbackEventArgs;
    if(executeCommandCallbackEventArgs.success){
    var api = executeCommandCallbackEventArgs.commons.api;
    if (api.parentVc != undefined){
            api.parentVc.setContainerView(entities.Warranty.externalCode);
    }
    executeCommandCallbackEventArgs.commons.api.vc.closeModal(true);
    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: Liberation
    task.initData.VC_LIBERATINO_737422 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var customParameters = initDataEventArgs.commons.api.vc.customDialogParameters;
        entities.Warranty.externalCode = customParameters.externalCode;
        entities.Warranty.custody = customParameters.custody;
        entities.Warranty.type = customParameters.custodyType;
        
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: Liberation
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };


}());