<!-- Designer Generator v 5.0.0.1517 - release SPR 2015-16 04/09/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskprintguaranteetickets;

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
    //HeaderGuaranteesTicket.DateFrom (DateField) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_ATRO527 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.RequestedTermInDays (TextInputBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_EUER032 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.ExpirationDate (DateField) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_POTE119 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CurrencyRequested (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_RRQE376 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.AmountRequested (TextInputBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_TREU555 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CustomerSector (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_UMRO301 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6809_EEAR819 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
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

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_IEWGUARNTK6809_EEAR819 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //CMPrintGuarantee (Button) 
    task.executeCommand.CM_AKIUE81RNN18 = function(entities, executeCommandEventArgs) {		
				
	//var debtor = entities.DebtorGeneral._data[0].CustomerCode;    
		//entities.DocumentProduct.ReportParamGuarantor = 'mix';
		//var reportGuarantor = entities.DocumentProduct.ReportParamGuarantor;
        for (var i = 0; i <= entities.DocumentProduct.data().length - 1; i++) {
			if(entities.DocumentProduct.data()[i].YesNot === true){ 
				//var city = executeCommandEventArgs.commons.api.viewState.selectedText('VA_ORIAHEADER8602_ITCE121', entities.OriginalHeader.CityCode);				
				if(FLCRE.CONSTANTS.Report.LoanApplication===entities.DocumentProduct.data()[i].Template){

				}else{

					var args = [['report.module', 'credito'],['report.name', entities.DocumentProduct.data()[i].Template],['idCustomer',entities.HeaderGuaranteesTicket.CustomerId],['idTramit',entities.OriginalHeader.IDRequested],['idProcess',entities.OriginalHeader.ApplicationNumber],['tipoCustomer',entities.HeaderGuaranteesTicket.CustomerType]];
				}
				BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template,args);				
				BUSIN.INBOX.STATUS.nextStep(true,executeCommandEventArgs.commons.api);
			}
		}			
		executeCommandEventArgs.commons.execServer = true;
		
		
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 
    //QueryView: GridDocumentProduct
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitColumnTemplate.QV_QDMNT8051_16 = function(idColumn) {
        if(idColumn === 'YesNot'){        	
			return "<input type=\'checkbox\' name=\'YesNot\' id=\'VA_DOCUNODCVW7303_YSNO533\' #if (YesNot === true) {# checked #}# ng-click=\"vc.grids.QV_QDMNT8051_16.events.customRowClick($event, \'VA_DOCUNODCVW7303_YSNO533\', \'DocumentProduct\', \'QV_QDMNT8051_16\')\"/>";
		}

    };
	
	//QueryView: GridDocumentProduct - Actualiza el Valor de la Entidad.     
	task.gridRowCommand.VA_DOCUNODCVW7303_YSNO533 = function (entities, args) {		
        args.commons.execServer = false;		
        var index = args.rowIndex;								
		for (var i = 0; i<=entities.DocumentProduct.data().length; i++)
		{			
			if (i === index)
				entities.DocumentProduct.data()[i].YesNot = !entities.DocumentProduct.data()[i].YesNot;
		}
	};
	
    //QueryView: GridDocumentProduct
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitEditColumnTemplate.QV_QDMNT8051_16 = function(idColumn) {
        //if(idColumn === 'NombreColumna'){
        //	return "<span></span>";
        //}

    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //GridRowSelectingDoc QueryView: GridDocumentProduct
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_QDMNT8051_16 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: FPrintGuaranteesTicket 
    task.initData.VC_AKIUE81_PITCK_259 = function(entities, initDataEventArgs) {
     /*var client = initDataEventArgs.commons.api.parentVc.model.Task;		
		entities.HeaderGuaranteesTicket.CustomerId = client.clientId;
		entities.HeaderGuaranteesTicket.CustomerName = client.clientName;
		entities.HeaderGuaranteesTicket.ByAccountName = client.clientName;
		entities.HeaderGuaranteesTicket.ClientType = client.clientType;
		//Envio la variable de contexto para la oficina
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		//envio el usuario para recuperar la ciudad destino		
        entities.HeaderGuaranteesTicket.User = cobis.userContext.getValue(cobis.constant.USER_NAME);		
		entities.OriginalHeader.ApplicationNumber = client.processInstanceIdentifier;
		*/
		
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.HeaderGuaranteesTicket.CustomerName=client.clientName; //Recupero el NOmbre del Cliente
		entities.HeaderGuaranteesTicket.CustomerType = client.clientType;//Se agrega el tipo de cliente para buscar direcciÃ³n del cliente
		entities.HeaderGuaranteesTicket.RenewOperation= client.bussinessInformationStringOne; // Se agrega el valor de la operacion a renovar
		
		entities.HeaderGuaranteesTicket.CustomerId=client.clientId;//Recupero el Id del Cliente
		//entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.HeaderGuaranteesTicket.User = cobis.userContext.getValue(cobis.constant.USER_NAME);
		
		
        initDataEventArgs.commons.execServer = true;
		
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: FPrintGuaranteesTicket 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
		
		//renderEventArgs.commons.api.grid.hideColumn('QV_QDMNT8051_16', 'ReportParamGuarantor');
		
		var api = renderEventArgs.commons.api;
		api.viewState.hide('GR_IEWGUARNTK68_08');
		api.viewState.hide('GR_IEWGUARNTK68_09');
		api.viewState.hide('GR_IEWGUARNTK68_10');		
		api.viewState.hide('GR_IEWGUARNTK68_12');
		api.viewState.hide('VA_IEWGUARNTK6806_REWP949');		
		
		api.viewState.disable('VA_IEWGUARNTK6807_TORR665');
		api.viewState.disable('VA_IEWGUARNTK6806_REWP949');
		api.viewState.disable('VA_IEWGUARNTK6806_RRQE376');
		api.viewState.disable('VA_IEWGUARNTK6806_WNTS030');
		api.viewState.disable('VA_IEWGUARNTK6806_TREU555');
		api.viewState.disable('VA_IEWGUARNTK6806_WNTP122');
		api.viewState.disable('VA_IEWGUARNTK6806_ATRO527');
		api.viewState.disable('VA_IEWGUARNTK6806_EUER032');
		api.viewState.disable('VA_IEWGUARNTK6806_POTE119');
		api.viewState.disable('VA_IEWGUARNTK6806_UMRO301');
		api.viewState.disable('VA_IEWGUARNTK6806_LIES496');
		
    };

}());