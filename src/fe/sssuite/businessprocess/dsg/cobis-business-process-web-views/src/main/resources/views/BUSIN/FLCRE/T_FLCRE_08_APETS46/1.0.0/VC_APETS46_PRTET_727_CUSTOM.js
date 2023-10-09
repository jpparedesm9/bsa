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

    var task = designerEvents.api.approvewarrantiesticket;
	task.authorizedExceptions =false;	
	task.validateError = false;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.Boton (Button) View: ViewGuaranteesTicket
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_IEWGUARNTK6812_0000459 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

    //Entity: 
    //.Autorizar (Button) View: ApproveCreditRequest
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_OVECRDTRQE4827_0000833 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };
	
	task.executeCommandCallback.VA_OVECRDTRQE4827_0000833 = function(entities, executeCommandCallbackEventArgs) { //
		if(executeCommandCallbackEventArgs.success){
			task.authorizedExceptions = true
		}
        task.enableContinue(executeCommandCallbackEventArgs);		
	};
	
    //Entity: IndexSizeActivity
    //IndexSizeActivity.btnReaclcular (Button) View: ApproveCreditRequest
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_OVECRDTRQE4831_NEIY294 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DebtorGeneral
    //DebtorGeneral.Role (ComboBox) View: BorrowerView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: OriginalHeader
    //OriginalHeader.CreditSector (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6805_EDCT992 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: OriginalHeader
    //OriginalHeader.Province (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6805_OINC062 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CurrencyRequested (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6806_RRQE376 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEWGUARNTK6809_EEAR819 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.AmountProposed (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_OVECRDTRQE4830_AONO775 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.Currency (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_OVECRDTRQE4830_CUCY033 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_OVECRDTRQE4830_RITT981 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_IEWGUARNTK6806_LIES496 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;
		serverParameters.OfficerAnalysis= true;
		serverParameters.DebtorGeneral= true;
		loadCatalogDataEventArgs.commons.execServer = true;
		
    };


    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.WarrantyType (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_IEWGUARNTK6806_WNTP122 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;
    };

   

    //Entity: DistributionLine
    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_OVECRDTRQE4830_RITT981 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.DistributionLine = true;
		loadCatalogDataEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_IEWGUARNTK6809_EEAR819 = function(textInputButtonEventArgs) {
        //textInputButtonEventArgs.commons.execServer = false;
    };
	
	//Entity: FeeRate
    //FeeRate.costCategory (ComboBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_OVECRDTRQE4833_CCGR491 = function(entities, changedEventArgs) {         
        task.hideShowFunction(entities, changedEventArgs);	        
		task.limpiarCampos(entities);		
		changedEventArgs.commons.execServer = true;		
    };
	
    //Entity: FeeRate
    //FeeRate.percentageNew (TextInputBox) View: ApproveCreditRequest
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_OVECRDTRQE4833_PRNT414 = function(entities, changedEventArgs) {        
		task.validateFactors(entities, changedEventArgs);	
		if(task.validateError){
			changedEventArgs.commons.execServer = false;			
	    }
		else
			changedEventArgs.commons.execServer = true;
    };
	//Entity: 
    //.Aceptar (Button) View: ApproveCreditRequest
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_OVECRDTRQE4833_0000032 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };
	task.executeCommandCallback.VA_OVECRDTRQE4833_0000032 = function(entities, executeCommandCallbackEventArgs) {
			task.enableContinue(executeCommandCallbackEventArgs);
	}
    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 
    //QueryView: GridExceptions
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitDetailTemplate.QV_UERXC4756_18 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
        var nav = gridInitDetailTemplateArgs.commons.api.navigation;

        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_50_VPLIC33',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_VPLIC33_VAEPL_011'
        };
		nav.customDialogParameters = {
			Mnemonic:gridInitDetailTemplateArgs.modelRow.mnemonic,
		    VariableEx:entities.VariableExceptions,
			seccion:'E'
		};
        nav.openDetailTemplate('QV_UERXC4756_18', gridInitDetailTemplateArgs.modelRow);
    };

    //QueryView: GridPolicy
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitDetailTemplate.QV_QUERO4480_42 = function(entities, gridInitDetailTemplateArgs) {
		gridInitDetailTemplateArgs.commons.execServer = false;
        var nav = gridInitDetailTemplateArgs.commons.api.navigation;

        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_50_VPLIC33',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_VPLIC33_VAEPL_011'
        };
		nav.customDialogParameters = {
			Mnemonic:gridInitDetailTemplateArgs.modelRow.mnemonic,
		    VariablePolicy:entities.VariablePolicy,
			seccion:'P'
		};
        nav.openDetailTemplate('QV_QUERO4480_42', gridInitDetailTemplateArgs.modelRow);
    };

    //QueryView: GridExceptions
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
        if(idColumn === 'Aproved'){
			return "<input type=\'checkbox\' name=\'Aproved\' id=\'VA_OVECRDTRQE4824_EULT673\' #if (Aproved === true) {# checked #}# ng-click=\"vc.grids.QV_UERXC4756_18.events.customRowClick($event, \'VA_OVECRDTRQE4824_EULT673\', \'Exceptions\', \'QV_UERXC4756_18\')\" ng-disabled=\"#=(Authorized===\'N\')#\"/>";
		}
    };
    //QueryView: GridExceptions - Actualiza el Valor de la Entidad.
	task.gridRowCommand.VA_OVECRDTRQE4824_EULT673 = function (entities, args) {
        args.commons.execServer = false;
        var index = args.rowIndex;
		for (var i = 0; i<=entities.Exceptions.data.length; i++)
		{
			if (i === index)
				entities.Exceptions.data()[i].Aproved = !entities.Exceptions.data()[i].Aproved;
		}
	};	
    //QueryView: GridExceptions
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitEditColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
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
        // gridRowInsertingEventArgs.commons.execServer = false;
    };

    //InsertingRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos. 
    task.gridRowInserting.QV_QERIS7170_82 = function(entities, gridRowInsertingEventArgs) {
        // gridRowInsertingEventArgs.commons.execServer = false;
    };

    //BeforeViewCreationCl QueryView: Borrowers
    //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente. 
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //updatePoint QueryView: ManagersPointsGrid
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowUpdating.QV_MARPN5915_10 = function(entities, gridRowUpdatingEventArgs) {
        // gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //UpdateRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowUpdating.QV_QERIS7170_82 = function(entities, gridRowUpdatingEventArgs) {
        // gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //DeleteRow QueryView: GridDistributionLine
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos. 
    task.gridRowDeleting.QV_QERIS7170_82 = function(entities, gridRowDeletingEventArgs) {
        // gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers
    //Evento GridBeforeEnterInlineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.. 
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        // gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //SelectingRole QueryView: ManagersPointsGrid
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_MARPN5915_10 = function(entities, gridRowSelectingEventArgs) {
        // gridRowSelectingEventArgs.commons.execServer = false;
    };

    //SelectDisbursement QueryView: GridDisbursementForms
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_QURDM9228_60 = function(entities, gridRowSelectingEventArgs) {
        // gridRowSelectingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla. 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
    };
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: ApproveWarrantiesTicket 
    task.initData.VC_APETS46_PRTET_727 = function(entities, initDataEventArgs) {
		var client = initDataEventArgs.commons.api.parentVc.model.Task;		
		entities.HeaderGuaranteesTicket.CustomerId = client.clientId;
		entities.HeaderGuaranteesTicket.CustomerName = client.clientName;
		entities.HeaderGuaranteesTicket.ByAccountName = client.clientName;
		entities.HeaderGuaranteesTicket.CustomerType = client.clientType;//Se agrega el tipo de cliente para buscar dirección del cliente
		entities.HeaderGuaranteesTicket.RenewOperation= client.bussinessInformationStringOne; // Se agrega el valor de la operacion a renovar
		
		//Envio la variable de contexto para la oficina
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		//envio el usuario para recuperar la ciudad destino		
        entities.HeaderGuaranteesTicket.User = cobis.userContext.getValue(cobis.constant.USER_NAME);		
		entities.OriginalHeader.ApplicationNumber = client.processInstanceIdentifier;
        initDataEventArgs.commons.execServer = true;
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: ApproveWarrantiesTicket 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
		var idToHide = ['GR_OVECRDTRQE48_34','GR_IEWGUARNTK68_04','GR_IEWGUARNTK68_07','GR_IEWGUARNTK68_08',
					'GR_IEWGUARNTK68_09','GR_IEWGUARNTK68_10','GR_IEWGUARNTK68_12',
					'GR_OVECRDTRQE48_05','GR_OVECRDTRQE48_06','GR_OVECRDTRQE48_13',
					'GR_OVECRDTRQE48_20','GR_OVECRDTRQE48_30','GR_OVECRDTRQE48_31',
					'VA_IEWGUARNTK6806_REWP949', 'VA_OVECRDTRQE4833_FCTO562','VA_OVECRDTRQE4833_RCEE196', 
					'VA_OVECRDTRQE4833_FORO729', 'VA_OVECRDTRQE4833_PRNT414','GR_OVECRDTRQE48_32'];
		BUSIN.API.hide(renderEventArgs.commons.api.viewState,idToHide);
		var idToDisable = ['VC_APETS46_OLGNT_719', 'VA_OVECRDTRQE4833_RCEE196', 'VA_OVECRDTRQE4833_FCTO562', 'VA_OVECRDTRQE4833_FORO729',
		                   'GR_OVECRDTRQE48_34','GR_IEWGUARNTK68_04','GR_IEWGUARNTK68_07','GR_IEWGUARNTK68_08',
					       'GR_IEWGUARNTK68_09','GR_IEWGUARNTK68_10','GR_IEWGUARNTK68_12',
					       'GR_OVECRDTRQE48_05','GR_OVECRDTRQE48_06','GR_OVECRDTRQE48_13',
					       'GR_OVECRDTRQE48_20','GR_OVECRDTRQE48_30','GR_OVECRDTRQE48_31',
					       'VA_IEWGUARNTK6806_REWP949', 'VA_OVECRDTRQE4833_FCTO562','VA_OVECRDTRQE4833_RCEE196', 
					       'VA_OVECRDTRQE4833_FORO729','GR_OVECRDTRQE48_32', 'VA_OVECRDTRQE4833_0000032',
						   'VA_OVECRDTRQE4833_NALE922','VA_OVECRDTRQE4833_ALUE668','VA_OVECRDTRQE4833_MION737',
						   'VA_OVECRDTRQE4833_CURE565','VA_OVECRDTRQE4833_IMUM383','GR_OVECRDTRQE48_33'];
		BUSIN.API.readOnlyAsync(renderEventArgs,['VA_IEWGUARNTK6806_WNTP122'],true,3000); 
		BUSIN.API.disable(renderEventArgs.commons.api.viewState,idToDisable);
		var grid = renderEventArgs.commons.api.grid;
		grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		var idToShow = ['GR_OVECRDTRQE48_33','VA_IEWGUARNTK6806_DAPS003']
		BUSIN.API.show(renderEventArgs.commons.api.viewState,idToShow);
		var idToShow = ['VA_IEWGUARNTK6806_DAPS003']
		BUSIN.API.enable(renderEventArgs.commons.api.viewState,idToShow);
		var idDisable = ['VA_IEWGUARNTK6806_DAPS003'];
		BUSIN.API.disable(renderEventArgs.commons.api.viewState,idDisable);
		//HABILITA LAS FILAS DE LA GRILLA DE LAS EXCEPCIONES QUE SE PUEDEN APROBAR
		var ds = renderEventArgs.commons.api.vc.model['Exceptions'];
		var dsData = ds.data();
        for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
            if(dsRow.Authorized === 'N'){
                grid.addRowStyle('QV_UERXC4756_18', dsRow, 'Disable_CTR');
            }else{
				grid.removeRowStyle('QV_UERXC4756_18', dsRow, 'Disable_CTR');
			}
        }
		if(dsData.length === 0){
			task.authorizedExceptions = true
		}
        task.enableContinue(renderEventArgs);
		task.validateFactors(entities, renderEventArgs);
		task.hideShowFunction(entities, renderEventArgs);
    };
    //**********************************************************
    //  Eventos para Grupos
    //**********************************************************
    //Contenedor de Pestañas (TabbedLayout)  View: ApproveCreditRequest
    //Evento ChangeGroup: Evento change para pestañas, collapsible y accordion. 
    task.changeGroup.GR_OVECRDTRQE48_04 = function(entities, changedGroupEventArgs) {
        // changedGroupEventArgs.commons.execServer = false;
        //if((changedGroupEventArgs.commons.item.id === 'GroupId') && (changedGroupEventArgs.commons.item.isOpen === true)){
        //console.log("Open by " + changedGroupEventArgs.commons.item.id);
        //}
    };	
	task.hideShowFunction = function(entities, renderEventArgs) {
         if(entities.FeeRate.costCategory === 'E'){
			var idToShow = ['VA_OVECRDTRQE4833_FCTO562','VA_OVECRDTRQE4833_FORO729','VA_OVECRDTRQE4833_PRNT414','VA_OVECRDTRQE4833_0000622', 'VA_OVECRDTRQE4833_0000479',  'VA_OVECRDTRQE4833_0000056']
		    BUSIN.API.show(renderEventArgs.commons.api.viewState,idToShow); 
			var idToHide = ['VA_OVECRDTRQE4833_RCEE196', 'VA_OVECRDTRQE4833_0000622','VA_OVECRDTRQE4833_0000373','VA_OVECRDTRQE4833_0000479', 'VA_OVECRDTRQE4833_0000459']
		    BUSIN.API.hide(renderEventArgs.commons.api.viewState,idToHide); 
		 }else{
			var idToShow = ['VA_OVECRDTRQE4833_RCEE196','VA_OVECRDTRQE4833_PRNT414','VA_OVECRDTRQE4833_0000373','VA_OVECRDTRQE4833_0000479', 'VA_OVECRDTRQE4833_0000375']
		    BUSIN.API.show(renderEventArgs.commons.api.viewState,idToShow);  
			var idToHide = ['VA_OVECRDTRQE4833_FCTO562','VA_OVECRDTRQE4833_FORO729','VA_OVECRDTRQE4833_0000622','VA_OVECRDTRQE4833_0000479', 
			                'VA_OVECRDTRQE4833_0000056','VA_OVECRDTRQE4833_0000459']
		    BUSIN.API.hide(renderEventArgs.commons.api.viewState,idToHide); 
		 }	
    };
	task.enableContinue = function(executeCommandCallbackEventArgs) {
		if(task.authorizedExceptions ){
			if(executeCommandCallbackEventArgs.success != undefined)
				BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
			else
				BUSIN.INBOX.STATUS.nextStep(true,executeCommandCallbackEventArgs.commons.api);
		}
			
    };	
	task.validateFactors = function(entities, changedEventArgs) {		
		if(!BUSIN.VALIDATE.IsNullOrEmpty(entities.FeeRate.percentageNew)){
			if(entities.FeeRate.costCategory === 'E'){
				if(entities.FeeRate.percentageNew < entities.FeeRate.factorFrom || entities.FeeRate.percentageNew > entities.FeeRate.factorTo){
					changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_EELRSRANI_87817');
					task.validateError = true;			
				}else{
					task.validateError = false;				
				}
			}else{
				if(entities.FeeRate.percentageNew > entities.FeeRate.percentage || entities.FeeRate.percentageNew < 0){
					changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_TJNPMRAJD_08129');
					task.validateError = true;					
				}else{
					task.validateError = false;					
				}	
			}	
		}else {
			task.validateError = false;
		}
    };
	task.limpiarCampos = function(entities){
		entities.FeeRate.percentageNew='';
		entities.FeeRate.commission='';
		entities.FeeRate.currency='';		
		entities.FeeRate.minimum='';		
	}

}());