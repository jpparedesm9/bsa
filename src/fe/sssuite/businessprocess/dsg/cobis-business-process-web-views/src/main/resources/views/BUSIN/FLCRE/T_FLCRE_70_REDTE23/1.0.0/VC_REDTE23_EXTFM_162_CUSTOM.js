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

    var task = designerEvents.api.taskextendedcreditline;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //LineHeader.[Control Sin Nombre] (TextLink) View: ApplicationHeaderView 
    task.executeCommand.VA_APITONEAEE5507_0000606 = function(entities, executeCommandEventArgs) {
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

    //CustomerReference.Result (CheckBox) View: CustomerReferenceView 
    //task..VA_USTMRENCVW3903_0000448 = function() {};

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button) 
    task.executeCommand.CM_REDTE23SAE40 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers 
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
         beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers 
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //SELECTING QueryView: GridCustomerReference 
    task.gridRowSelecting.QV_QURRF6164_42 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
         gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: formExtendedCreditLine 
    task.initData.VC_REDTE23_EXTFM_162 = function(entities, initDataEventArgs) {
         var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = 'YES';

		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringOne;
		//entities.OriginalHeader.IDRequested =  parentParameters.Task.bussinessInformationStringOne;
		//alert(parentParameters.Task);
		
		entities.OriginalHeader.UserL=userL;
		//entities.OriginalHeader.ApplicationNumber = 232;		
        entities.OriginalHeader.TypeRequest = "P";
        //entities.LineHeader.Number = "LC1-0000000010";
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
    };
	
	task.initDataCallback.VC_REDTE23_EXTFM_162=function(entities, initDataEventArgs) {
         initDataEventArgs.commons.execServer = false;
		 console.log(entities);
    };

    //ViewContainer: formExtendedCreditLine 
    task.render = function(entities, renderEventArgs) {
         renderEventArgs.commons.execServer = false;
		 var api = renderEventArgs.commons.api;  
		 api.viewState.disable("VA_APITONEAEE5505_RTAY481");
		 api.viewState.disable("VA_APITONEAEE5505_PROE367");
		 api.viewState.disable("VA_APITONEAEE5505_USED740");
		 api.viewState.disable("VA_APITONEAEE5505_NDTE867");
		 api.viewState.disable("VA_APITONEAEE5505_TERM140");
		 api.viewState.disable("VA_APITONEAEE5505_XPIA086");
		 api.viewState.disable("VA_APITONEAEE5505_OFIC220");
		 api.viewState.disable("VA_APITONEAEE5505_SCTR004");
		 api.viewState.disable("VA_APITONEAEE5505_ADSN125");
		 api.viewState.disable("VA_APITONEAEE5506_ITCE223");
		 api.viewState.disable("VA_APITONEAEE5506_IALT470");
		 api.viewState.disable("VA_APITONEAEE5506_OQUE114");
		 api.viewState.disable("VA_APITONEAEE5506_TERM631");
		 api.viewState.disable("VA_APITONEAEE5506_FICE377"); 
		 
		 
	
			//Deshabilito los botones de crear nuevo de deudores
			api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');
			api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		
    };
	
	
	
	
	

}());