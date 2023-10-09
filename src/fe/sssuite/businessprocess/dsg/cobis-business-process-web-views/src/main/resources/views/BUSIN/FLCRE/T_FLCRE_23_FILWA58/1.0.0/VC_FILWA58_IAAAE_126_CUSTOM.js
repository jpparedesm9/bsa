<!-- Designer Generator v 5.0.0.1518 - release SPR 2015-16 18/09/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.officialassigwarrantiesticket;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.Boton (Button) View: ViewGuaranteesTicket
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_IEWGUARNTK6812_0000459 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
    };

    //Entity: OriginalHeader
    //OriginalHeader.CreditSector (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6805_EDCT992 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: OriginalHeader
    //OriginalHeader.Province (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6805_OINC062 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6809_EEAR819 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Entity: Official
    //Official.Official (ComboBox) View: Oficial
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_OFICIALOBG2103_OFIL240 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
		if (changedEventArgs.oldValue != null)
		{
	        changedEventArgs.commons.api.viewState.enable("CM_FILWA58SVE22");
	 	}
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_IEWGUARNTK6806_LIES496 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.WarrantyType (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_IEWGUARNTK6806_WNTP122 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;
    };

    //Entity: Official
    //Official.Official (ComboBox) View: Oficial
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_OFICIALOBG2103_OFIL240 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		
		// Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OriginalHeader = true;
		
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_IEWGUARNTK6809_EEAR819 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
    };
	
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //SaveCmd (Button) 
    task.executeCommand.CM_FILWA58SVE22 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };
	
	task.executeCommandCallback.CM_FILWA58SVE22 = function(entities, executeCommandEventArgs) {
        BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
        executeCommandEventArgs.commons.execServer = false;    
    };
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //SelectReason QueryView: GridCentralInternalReasons
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_NUTER6889_40 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //SelectOficcerAll QueryView: GridOfficialLoadAll
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_OFFIA3873_22 = function(entities, gridRowSelectingEventArgs) {
        entities.Official.Official="" + gridRowSelectingEventArgs.rowData.CodeOfficial; 
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_FILWA58SVE22");		
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //SelectOficcer QueryView: GridOfficialLoad
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_OFFIA3873_31 = function(entities, gridRowSelectingEventArgs) {
		entities.Official.Official="" + gridRowSelectingEventArgs.rowData.CodeOfficial; 
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_FILWA58SVE22");		
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: OfficialAssigWarrantiesTicket 
    task.initData.VC_FILWA58_IAAAE_126 = function(entities, initDataEventArgs) {        
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		
		entities.HeaderGuaranteesTicket.CustomerId = client.clientId;
		entities.HeaderGuaranteesTicket.CustomerName = client.clientName;
		entities.HeaderGuaranteesTicket.ByAccountName = client.clientName;
		entities.HeaderGuaranteesTicket.CustomerType = client.clientType;//Se agrega el tipo de cliente para buscar dirección del cliente
		entities.HeaderGuaranteesTicket.RenewOperation= client.bussinessInformationStringOne;
		//Envio la variable de contexto para la oficina
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		//envio el usuario para recuperar la ciudad destino		
        entities.HeaderGuaranteesTicket.User = cobis.userContext.getValue(cobis.constant.USER_NAME);		
		entities.OriginalHeader.ApplicationNumber = client.processInstanceIdentifier;				
		initDataEventArgs.commons.execServer = true;	
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: OfficialAssigWarrantiesTicket 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
		renderEventArgs.commons.api.viewState.disable("CM_FILWA58SVE22");
		var ctrs = ['GR_IEWGUARNTK68_04','GR_IEWGUARNTK68_07','GR_IEWGUARNTK68_08',
					'GR_IEWGUARNTK68_09','GR_IEWGUARNTK68_10','GR_IEWGUARNTK68_12',
					'VA_IEWGUARNTK6806_REWP949'];
		BUSIN.API.readOnlyAsync(renderEventArgs,['VA_IEWGUARNTK6806_WNTP122'],true,3000); 
		BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs);
		var grps = ['VC_FILWA58_BATAG_863', 'VA_IEWGUARNTK6806_DAPS003'];
		BUSIN.API.disable(renderEventArgs.commons.api.viewState,grps);
        var cst1 = ['VA_IEWGUARNTK6806_DAPS003']
	    BUSIN.API.show(renderEventArgs.commons.api.viewState,cst1);	
		
		var grid = renderEventArgs.commons.api.grid;		
		//QUITA BOTONES DEL GRID DE DUDORES
		grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		
    };

}());