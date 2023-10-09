<!-- Designer Generator v 5.1.0.1601 - release SPR 2016-01 22/01/2016 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.tdetailsourcerevenuecustomer;

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: TDetailSourceRevenueCustomer 
    task.initData.VC_SEVNO59_LSREU_678 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.vc.serverParameters.entityName = true;
		 var api = initDataEventArgs.commons.api;
        var customProperties = api.parentVc.customDialogParameters;
        //entities['SourceRevenueCustomer'] = customProperties.detailSourceRevenue;
		//var data=initDataEventArgs.commons.api.parentVc.model.SourceRevenueCustomer.data();
		entities.DetailSourceRevenueCustomer.aclaracionFie=customProperties.detailSourceRevenue;
		entities.DetailSourceRevenueCustomer.subActividadEconomica=customProperties.detailSubActividadEconomica;
       
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: TDetailSourceRevenueCustomer 
    task.render = function(entities, renderEventArgs) {
        var viewState = renderEventArgs.commons.api.viewState;
		viewState.disable('VA_AOUCCSOMER4102_ALIF218');
		viewState.disable('VA_AOUCCSOMER4102_BOMC571');
		renderEventArgs.commons.execServer = false;
    };

}());