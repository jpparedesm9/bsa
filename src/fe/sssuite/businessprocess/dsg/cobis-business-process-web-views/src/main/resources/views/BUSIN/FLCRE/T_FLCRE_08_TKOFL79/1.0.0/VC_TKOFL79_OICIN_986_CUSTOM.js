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

    var task = designerEvents.api.taskofficialanalisysline;

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
			changedEventArgs.commons.api.viewState.enable("CM_TKOFL79DSA74");
		 }
    };

    //Official.Official (ComboBox) View: Oficial 
    task.loadCatalog.VA_OFICIALOBG2103_OFIL240 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.api.viewState.disable("CM_TKOFL79DSA74");

        // Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OriginalHeader = true;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //CmdSave (Button) 
    task.executeCommand.CM_TKOFL79DSA74 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };
	task.executeCommandCallback.CM_TKOFL79DSA74 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
      
		if(parentApi != undefined && executeCommandCallbackEventArgs.success){
		  var parentVc = parentApi.vc;
		  parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		} 
		
	};
	
	 //LineHeader.Number (TextLink) View: ApplicationHeaderView 
    task.executeCommand.VA_APITONEAEE5510_0000944 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //executeCommandEventArgs.commons.messageHandler.showMessagesInformation('Vista de Detalle Linea');
        
		var nav = executeCommandEventArgs.commons.api.navigation;

		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CUOMREARH_28245');
        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',    
            taskId: 'T_FLCRE_14_NEEDA85',    
            taskVersion: '1.0.0',    
            viewContainerId: 'VC_NEEDA85_LHEIL_830'  
        };
        nav.customDialogParameters = {
            lineHeader: entities['LineHeader']
        };
		nav.popoverProperties = {
            width: 500,
            height: 'auto',
            position: "left bottom"
        }; 
        nav.openPopover(executeCommandEventArgs.commons.controlId);        
    };
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        // gridRowInsertingEventArgs.commons.execServer = false;
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
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_TKOFL79DSA74");
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //SelectOficcer QueryView: GridOfficialLoad 
    task.gridRowSelecting.QV_OFFIA3873_31 = function(entities, gridRowSelectingEventArgs) {
        entities.Official.Official="" + gridRowSelectingEventArgs.rowData.CodeOfficial;
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_TKOFL79DSA74");
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormOfficialAnalisysLine 
    task.initData.VC_TKOFL79_OICIN_986 = function(entities, initDataEventArgs) {
         initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
		initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters; 
		entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringOne;
		var viewState = initDataEventArgs.commons.api.viewState;
		if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
		}
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
			task.Etapa = parentParameters.Task.urlParams.ETAPA;
		}
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.UserL=userL;
		
		var ctrs1 = ['VC_TKOFL79_GUSRE_619'];//
		BUSIN.API.hide(viewState,ctrs1);
		initDataEventArgs.commons.execServer = true;
		
		initDataEventArgs.commons.api.viewState.disable("CM_TKOFL79DSA74");
    };

    //ViewContainer: FormOfficialAnalisysLine 
    task.render = function(entities, renderEventArgs) {
         renderEventArgs.commons.execServer = false;
		var viewState = renderEventArgs.commons.api.viewState;
		var api = renderEventArgs.commons.api;
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		renderEventArgs.commons.api.viewState.disable("VA_HEDELNEVIE1304_OQUE778"); 
		renderEventArgs.commons.api.viewState.disable("VA_HEDELNEVIE1304_URQT805"); 
		renderEventArgs.commons.api.viewState.disable("VA_HEDELNEVIE1304_CRET710"); 
	
		//Cuando es ASIGNACIÓN DEL OFICIAL y MODIFICACION LC  PLAZO
		if(task.Etapa === FLCRE.CONSTANTS.Stage.AsignacionOficial && task.EtapaTramite === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo){
		    var ctrs2 = ['VC_TKOFL79_GUSRE_619'];//
		    BUSIN.API.show(viewState,ctrs2);
			var ctrs = ['VC_TKOFL79_EADER_041','VA_APITONEAEE5510_0000197','VA_APITONEAEE5511_FICE246'];//
		    BUSIN.API.hide(viewState,ctrs);
			var ctrs1 = ['VC_TKOFL79_GUSRE_619'];//
		    BUSIN.API.disable(viewState,ctrs1);
			
        }
		//Cuando es ASIGNACIÓN DEL OFICIAL y MODIFICACION LC  MONTO y PLAZO
		if(task.Etapa === FLCRE.CONSTANTS.Stage.AsignacionOficial && task.EtapaTramite === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo){
		    var ctrs2 = ['VC_TKOFL79_GUSRE_619'];//
		    BUSIN.API.show(viewState,ctrs2);
			var ctrs = ['VC_TKOFL79_EADER_041','VA_APITONEAEE5510_0000197','VA_APITONEAEE5511_FICE246'];//
		    BUSIN.API.hide(viewState,ctrs);
			var ctrs1 = ['VC_TKOFL79_GUSRE_619'];//
		    BUSIN.API.disable(viewState,ctrs1);
        }
		
    };

}());