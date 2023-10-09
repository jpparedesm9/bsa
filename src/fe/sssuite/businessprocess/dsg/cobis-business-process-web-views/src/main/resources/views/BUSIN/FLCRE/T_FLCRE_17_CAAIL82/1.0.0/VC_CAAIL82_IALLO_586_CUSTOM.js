<!-- Designer Generator v 5.0.0.1505 - release SPR 2015-05 20/03/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.officialactivityallocation;    
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };
    //DebtorGeneral.Role (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //OriginalHeader.AttAmount (TextInputBox) View: HeaderView 
    task.change.VA_ORIAHEADER8602_QUOA306 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //Official.[Control Sin Nombre] (ComboBox) View: Oficial 
    task.loadCatalog.VA_OFICIALOBG2103_OFIL240 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;

        // Para enviar solo la entidad que se necesita en el load
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.OriginalHeader = true;
    };
    
   //Official.Official (ComboBox) View: Oficial 
    task.change.VA_OFICIALOBG2103_OFIL240 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
	  if (changedEventArgs.oldValue != null)
		 {
	 changedEventArgs.commons.api.viewState.enable("CM_CAAIL82SAE52");
	 	 }
    };

	task.loadCatalog.VA_ORIAHEADER8602_EVAL957 = function(loadCatalogDataEventArgs) {	
		loadCatalogDataEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button) 
    task.executeCommand.CM_CAAIL82SAE52 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };
    
    task.executeCommandCallback.CM_CAAIL82SAE52 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
        var parentApi = executeCommandEventArgs.commons.api.parentApi();
      
    if(parentApi != undefined && executeCommandEventArgs.success){
      var parentVc = parentApi.vc;
      parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    } 
    executeCommandEventArgs.commons.execServer = false;    
    };
    

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, Args) {
	
	
         Args.commons.execServer = false;
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
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_CAAIL82SAE52");
		
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //Seleccion Oficial QueryView: GridOfficialLoad 
    task.gridRowSelecting.QV_OFFIA3873_31 = function(entities, gridRowSelectingEventArgs) {
	    entities.Official.Official="" + gridRowSelectingEventArgs.rowData.CodeOfficial;
        gridRowSelectingEventArgs.commons.api.viewState.enable("CM_CAAIL82SAE52");

        gridRowSelectingEventArgs.commons.execServer = false;
    };
    
        //GridCommand (Button) QueryView: Borrowers 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
    };
    
//SelectOficcer QueryView: GridOfficialLoad 
    
	
	
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormOfficialActivityAllocation 
    task.initData.VC_CAAIL82_IALLO_586 = function(entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters; 
		entities.OriginalHeader.NumberLine = initDataEventArgs.commons.api.parentVc.model.Task.bussinessInformationStringOne;		
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
    
//         entities.OriginalHeader.ApplicationNumber = 216;
//    
//     	var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
//		entities.OriginalHeader.Office=office;
        
        
        initDataEventArgs.commons.api.viewState.disable("CM_CAAIL82SAE52");
        //vc.viewState.CM_CAAIL82SAE52.visible
        
		  BUSIN.API.disable(initDataEventArgs.commons.api.viewState,['VA_ORIAHEADER8602_IOUR445','VA_ORIAHEADER8602_RQSD386','VA_ORIAHEADER8602_0000908','VA_ORIAHEADER8602_ITCE121',
																	 'VA_ORIAHEADER8602_OQUE134','VA_ORIAHEADER8602_URQT595','VA_ORIAHEADER8602_QUOA306'/*Deshabilita Cuota*/,'VA_ORIAHEADER8602_NQUE773'/*Deshabilita Frecuencia de pago*/,
																	 'VA_ORIAHEADER8602_CRET312','VA_ORIAHEADER8602_IALT328']);
		  BUSIN.API.hide(initDataEventArgs.commons.api.viewState,['VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773']);
		  
		  
		  

        //DESEMBOLSO BAJO LINEA CREDITO
		//var client = initDataEventArgs.commons.api.parentVc.model.Task;
		//if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' && 
		//    client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' ){
		//MCA - Se envía por parámetro datos para flujo de desembolso en esta etapa
		if(task.Etapa === FLCRE.CONSTANTS.Stage.AsignacionOficial && task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Desembolso){
			BUSIN.API.show(initDataEventArgs.commons.api.viewState , ['VA_ORIAHEADER8602_NMLN737']);
		}
         initDataEventArgs.commons.execServer = true;                   
    };
    
    task.initDataCallback.VC_CAAIL82_IALLO_586 = function(entities, initDataEventArgs) {
		var parentApi = initDataEventArgs.commons.api.parentApi();
		if(parentApi != undefined && initDataEventArgs.success){
		  var parentVc = parentApi.vc;
		  parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
		initDataEventArgs.commons.execServer = false;
	 };
    
	 
	
    //ViewContainer: FormOfficialActivityAllocation 
    task.render = function(entities, renderEventArgs) {
        // renderEventArgs.commons.execServer = false;
				renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		    renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
        
        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento){ 
            var ctrs = ['VA_ORIAHEADER8602_QUOA306','VA_ORIAHEADER8602_NQUE773','VA_ORIAHEADER8602_CRET312'];               
                        BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs); 
                } 

    };

}());