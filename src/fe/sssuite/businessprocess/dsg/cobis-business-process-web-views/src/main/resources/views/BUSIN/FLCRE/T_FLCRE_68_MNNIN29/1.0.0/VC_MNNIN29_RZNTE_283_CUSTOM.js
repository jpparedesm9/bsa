<!-- Designer Generator v 5.0.0.1519 - release SPR 2015-19 02/10/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.tmatrizfuentefinan;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.Guardar (Button) View: ViewMatrizFuente
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_IEWMAIZFNE8104_0000545 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };

	task.executeCommandCallback.VA_IEWMAIZFNE8104_0000545 = function(entities, executeCommandCallbackEventArgs) {
		var api = executeCommandCallbackEventArgs.commons.api;
		//var parentApi = api.parentApi();
		//var data = api.vc.rowData;
		var data =api.vc.model.SourceFunding;
        var parentGrid = api.parentApi().grid;
		var	entity = 'SourceFunding';
		//var parentVc = api.parentApi().vc;
		
		if(executeCommandCallbackEventArgs.success){
			executeCommandCallbackEventArgs.commons.api.vc.closeModal(entities.SourceFunding);
			
			//data.Currency= entities.SourceFunding.Currency;
			//data.FundingSource=entities.SourceFunding.FundingSource;
			//data.MaximunAmount= entities.SourceFunding.MaximunAmount;
			parentGrid.collapseRow("QV_COURC4312_01", data);
			executeCommandCallbackEventArgs.commons.api.parentVc.model.SourceFunding.sync();//sincronizo los datos de la grilla
		}
     };
	
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: TMatrizFuenteFin 
    task.initData.VC_MNNIN29_RZNTE_283 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
		var api = initDataEventArgs.commons.api;
		//Recupero la fila de la grilla con el RowData y le asigno a la entidad
		if(!BUSIN.VALIDATE.IsNull(api.vc.rowData)){
			entities.SourceFunding = api.vc.rowData;
		}
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: TMatrizFuenteFin 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
    };

}());