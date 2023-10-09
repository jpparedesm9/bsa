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

    var task = designerEvents.api.validafechacictask;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
	//Entity: 
    //.Buscar (Button) View: ViewFechaCIC
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_VIEWFECHCC4404_0000869 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
		var serverParameters = executeCommandEventArgs.commons.api.vc.serverParameters;
		serverParameters.OriginalHeader = true;
        executeCommandEventArgs.commons.api.vc.serverParameters.entityName = true;
    };    
	task.executeCommandCallback.VA_VIEWFECHCC4404_0000869 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		//BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		task.disableRowGrid(executeCommandCallbackEventArgs, 'PersonalGuarantor', 'QV_PESAU2317_81');
	};

	//Entity: 
    //.Registrar Fecha CIC (Button) View: ViewFechaCIC
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_VIEWFECHCC4407_0000244 = function(entities, executeCommandEventArgs) {
		
		var serverParameters = executeCommandEventArgs.commons.api.vc.serverParameters;
		serverParameters.OriginalHeader = true;
		serverParameters.DebtorGeneral = true;
		serverParameters.PersonalGuarantor = true;
		executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.api.vc.serverParameters.entityName = true;
    };

	//Entity: DebtorGeneral
    //DebtorGeneral.TypeDocumentId (ComboBox) View: ViewFechaCIC
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_VIEWFECHCC4405_DOTD988 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.Role (ComboBox) View: ViewFechaCIC
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_VIEWFECHCC4405_ROLE907 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };
	
	 //Entity: DebtorGeneral
    //DebtorGeneral.DateCIC (DateField) View: ViewFechaCIC
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_VIEWFECHCC4405_DTCC606 = function(entities, changedEventArgs) {
       changedEventArgs.commons.execServer = false;
		FLCRE.UTILS.CUSTOMER.setDateCIC(changedEventArgs,'VA_VIEWFECHCC4405_DTCC606');
    };
	
	//Entity: PersonalGuarantor
    //PersonalGuarantor.DateCIC (DateField) View: ViewFechaCIC
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_VIEWFECHCC4406_DATE553 = function(entities, changedEventArgs) {
       changedEventArgs.commons.execServer = false;
		FLCRE.UTILS.GUARANTEE.setDateCIC(changedEventArgs,'VA_VIEWFECHCC4406_DATE553');
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 
    //QueryView: Borrowers
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitColumnTemplate.QV_BOREG0798_55 = function(idColumn) {
        if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC('VA_VIEWFECHCC4405_DTCC606');
		}
    };
    //QueryView: Borrowers
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitEditColumnTemplate.QV_BOREG0798_55 = function(idColumn) {
        //if(idColumn === 'NombreColumna'){
        //	return "<span></span>";
        //}

    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos. 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
        gridRowInsertingEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente. 
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        beforeOpenGridDialogEventArgs.commons.execServer = false;
        beforeOpenGridDialogEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

    //fileDeleting QueryView: GridPersonalGuarantor
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos. 
    task.gridRowDeleting.QV_PESAU2317_81 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
        gridRowDeletingEventArgs.commons.api.vc.serverParameters.PersonalGuarantor = true;
    };

    //BeforeEnterLine QueryView: Borrowers
    //Evento GridBeforeEnterInlineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.. 
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        gridABeforeEnterInLineRowEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

	   //SectingDeudores QueryView: Borrowers
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        gridRowSelectingEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

    //Selecting Personal QueryView: GridPersonalGuarantor
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_PESAU2317_81 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        gridRowSelectingEventArgs.commons.api.vc.serverParameters.PersonalGuarantor = true;
    };

	task.gridInitColumnTemplate.QV_PESAU2317_81 = function(idColumn) { //QueryView: GridPersonalGuarantor
		if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.GUARANTEE.getTemplateForDateCIC('VA_VIEWFECHCC4406_DATE553');
	}
	};
    //GridCommand (Button) QueryView: Borrowers
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla. 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        gridExecuteCommandEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: ValidaFechaCICtask 
    task.initData.VC_IEACI48_LDACK_439 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.vc.serverParameters.entityName = true;
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: ValidaFechaCICtask 
    task.render = function(entities, renderEventArgs) {
		var grid = renderEventArgs.commons.api.grid;
		//Ocultando botones de Deudores
		grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');//boton eliminar
		grid.hideToolBarButton('QV_BOREG0798_55', 'create');//boton nuevo
		grid.hideColumn ('QV_PESAU2317_81', 'delete');
        renderEventArgs.commons.execServer = false;
    };
	
	task.disableRowGrid = function(eventArgs, entity , idGrid ){
		//HABILITA LAS FILAS DE LA GRILLA DE LAS EXCEPCIONES QUE SE PUEDEN APROBAR
		var ds = eventArgs.commons.api.vc.model[entity];
		var grid = eventArgs.commons.api.grid;
		var dsData = ds.data();
        for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
		    grid.hideGridRowCommand(idGrid, dsRow, 'delete');
        }
	};

}());