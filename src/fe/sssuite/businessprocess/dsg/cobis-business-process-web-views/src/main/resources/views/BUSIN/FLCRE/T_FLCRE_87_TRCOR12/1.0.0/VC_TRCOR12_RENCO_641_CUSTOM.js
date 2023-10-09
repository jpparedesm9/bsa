<!-- Designer Generator v 5.0.0.1502 - release SPR 2015-02 06/02/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskrevenuecustomer;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //SourceRevenueCustomer.BtnCancelar (Button) View: RevenueCustomer 
    task.executeCommand.VA_VENUECUSOE1806_SCOR060 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		
		var api = executeCommandEventArgs.commons.api, data, parentGrid, parentApi;
		
		parentApi = executeCommandEventArgs.commons.api.parentApi(),		
		data = api.vc.rowData
		parentGrid = parentApi.grid;
		if(data.Type == 'Nuevo')
			parentGrid.removeRowByDsgnrId('SourceRevenueCustomer', data);
    };

    //SourceRevenueCustomer.BtnModificar (Button) View: RevenueCustomer 
    task.executeCommand.VA_VENUECUSOE1806_SORN079 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer:   FormRevenueCustomer 
    task.initData.VC_TRCOR12_RENCO_641 = function(entities, initDataEventArgs) {
        // initDataEventArgs.commons.execServer = false;
    };

    //ViewContainer:   FormRevenueCustomer 
    task.render = function(entities, renderEventArgs) {
        // renderEventArgs.commons.execServer = false;
    };

}());