<!-- Designer Generator v 5.0.0.1509 - release SPR 2015-09 15/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.tlineheaderdetail;

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FLineHeaderDetail 
    task.initData.VC_NEEDA85_LHEIL_830 = function(entities, initDataEventArgs) {
        var api = initDataEventArgs.commons.api;
        var customProperties = api.parentVc.customDialogParameters;
        entities['LineHeader'] = customProperties.lineHeader;
        initDataEventArgs.commons.execServer = false;
		
		//Oculto campos demas es probable que haya que eliminarlos de la vista
		api.viewState.hide("VA_LIHDETLVIW1481_PROE043");
		api.viewState.hide("VA_LIHDETLVIW1481_EPRO485");
		api.viewState.hide("VA_LIHDETLVIW1481_SCTR073");
		api.viewState.hide("VA_LIHDETLVIW1481_RVIC566");
		api.viewState.hide("VA_LIHDETLVIW1481_ADSN224");
		api.viewState.hide("VA_LIHDETLVIW1481_AAUN909");
    };

}());