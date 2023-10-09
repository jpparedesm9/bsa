<!-- Designer Generator v 5.0.0.1510 - release SPR 2015-10 29/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskexpasigoffcial;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Official.Official (ComboBox) View: Oficial 
    task.change.VA_OFICIALOBG2103_OFIL240 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
		 if (changedEventArgs.oldValue != null)
		 {
			changedEventArgs.commons.api.viewState.enable("CM_TSAFA58CMD88");
		 }
    };

    //Official.Official (ComboBox) View: Oficial 
    task.loadCatalog.VA_OFICIALOBG2103_OFIL240 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;		

        // Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OriginalHeader = true;
    };

    //OriginalHeader.Quota (TextInputBox) View: HeaderView 
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Official.Official (ComboBox) View: Oficial 
    task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {
        //ach
        // Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;
        serverParameters.OfficerAnalysis = true;
        serverParameters.DebtorGeneral = true;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //SaveCmd (Button) 
    task.executeCommand.CM_TSAFA58CMD88 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };

	task.executeCommandCallback.CM_TSAFA58CMD88 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
      
		if(parentApi != undefined && executeCommandCallbackEventArgs.success){
		  var parentVc = parentApi.vc;
		  parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		} 
		
	};
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        // gridRowInsertingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers 
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers 
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        // gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //SelectReason QueryView: GridCentralInternalReasons 
    task.gridRowSelecting.QV_NUTER6889_40 = function(entities, gridRowSelectingEventArgs) {
        // gridRowSelectingEventArgs.commons.execServer = false;
    };

    //SelectOficcerAll QueryView: GridOfficialLoadAll
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_OFFIA3873_22 = function(entities, gridRowSelectingEventArgs) {
        entities.Official.Official="" + gridRowSelectingEventArgs.rowData.CodeOfficial;
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_TSAFA58CMD88");
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //SelectOficcer QueryView: GridOfficialLoad 
    task.gridRowSelecting.QV_OFFIA3873_31 = function(entities, gridRowSelectingEventArgs) {
        entities.Official.Official="" + gridRowSelectingEventArgs.rowData.CodeOfficial;
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_TSAFA58CMD88");
        gridRowSelectingEventArgs.commons.execServer = false;
    };
	
	//**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormExprAsigOfficial 
    task.initData.VC_TSAFA58_OXIIL_149 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');
		
		
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters; 
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.UserL=userL;
		initDataEventArgs.commons.execServer = true;
		
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		
		initDataEventArgs.commons.api.viewState.disable("CM_TSAFA58CMD88");
		initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_OQUE134");
		initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_URQT595");
		initDataEventArgs.commons.api.viewState.hide("VA_ORIAHEADER8602_QUOA306");
		initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_NQUE773");
		initDataEventArgs.commons.api.viewState.hide("VA_ORIAHEADER8602_CRET312");
		initDataEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_IALT328");
    };
    
	task.initDataCallback.VC_TSAFA58_OXIIL_149 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.execServer = false;
	}
	
	task.render = function(entities, renderEventArgs){
		try{
		renderEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
		renderEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
		renderEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');
		
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		
		renderEventArgs.commons.api.viewState.disable("CM_TSAFA58CMD88");
		renderEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_OQUE134");
		renderEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_URQT595");
		renderEventArgs.commons.api.viewState.hide("VA_ORIAHEADER8602_QUOA306");
		renderEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_NQUE773");
		renderEventArgs.commons.api.viewState.hide("VA_ORIAHEADER8602_CRET312");
		renderEventArgs.commons.api.viewState.disable("VA_ORIAHEADER8602_IALT328");
		
		} catch (err){	
			renderEventArgs.commons.messageHandler.showMessagesInformation('Error al Renderizar');
		}
    };

}());