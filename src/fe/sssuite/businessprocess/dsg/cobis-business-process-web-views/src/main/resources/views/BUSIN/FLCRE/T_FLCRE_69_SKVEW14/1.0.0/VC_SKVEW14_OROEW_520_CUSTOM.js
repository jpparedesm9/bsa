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

    var task = designerEvents.api.taskaprovedview;
	var listCustomer = [];

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //.Autorizar (Button) View: ApproveCreditRequest 
    task.executeCommand.VA_OVECRDTRQE4827_0000833 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };
	
	task.executeCommandCallback.VA_OVECRDTRQE4827_0000833 = function(entities, executeCommandCallbackEventArgs) { //
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};


    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };
	
	//DistributionLine.AmountProposed (TextInputBox) View: ApproveCreditRequest 
    task.change.VA_OVECRDTRQE4830_AONO775 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = true;
    };
	
	 //DistributionLine.Currency (ComboBox) View: ApproveCreditRequest 
    task.change.VA_OVECRDTRQE4830_CUCY033 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = true;
    };
	
	//DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest 
    task.change.VA_OVECRDTRQE4830_RITT981 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = true;
    };

    //DistributionLine.CreditType (ComboBox) View: ApproveCreditRequest 
    task.loadCatalog.VA_OVECRDTRQE4830_RITT981 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;
    };

    //LineHeader.[Control Sin Nombre] (TextLink) View: ApplicationHeaderView 
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

    //IndexSizeActivity.btnReaclcular (Button) View: ApproveCreditRequest 
    task.executeCommand.VA_OVECRDTRQE4831_NEIY294 = function(entities, executeCommandEventArgs) {
		//entities.OfficerAnalysis = {"Sector":entities.LineHeader.Sector};
        executeCommandEventArgs.commons.execServer = true;
		 
    };

    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 
    //QueryView: GridExceptions 
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
    task.gridInitColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
      if(idColumn === 'Aproved'){
			return "<input type=\'checkbox\' name=\'Aproved\' id=\'VA_OVECRDTRQE4824_EULT673\' #if (Aproved === true) {# checked #}# ng-click=\"vc.grids.QV_UERXC4756_18.events.customRowClick($event, \'VA_OVECRDTRQE4824_EULT673\', \'Exceptions\', grids.QV_UERXC4756_18)\" ng-disabled=\"#=(Authorized===\'N\')#\"/>";
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
   /* task.gridInitEditColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
       

    };*/

	//**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button) 
    task.executeCommand.CM_SKVEW14SAV65 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };
	
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };

    //InsertingRow QueryView: GridDistributionLine 
    task.gridRowInserting.QV_QRRTI5057_14 = function(entities, gridRowInsertingEventArgs) {
        if( (gridRowInsertingEventArgs.rowData.CreditType != null && gridRowInsertingEventArgs.rowData.CreditType != "") && (gridRowInsertingEventArgs.rowData.Module != null &&  gridRowInsertingEventArgs.rowData.Module != "")&& gridRowInsertingEventArgs.rowData.Currency != null && 
		gridRowInsertingEventArgs.rowData.AmountProposed != 0 && gridRowInsertingEventArgs.rowData.AmountLocalCurrency != 0 && gridRowInsertingEventArgs.rowData.Quote != 0)
		{
			gridRowInsertingEventArgs.commons.execServer = true;
		}else
		{		
			gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_VALIDATEO_88187');   
			gridRowInsertingEventArgs.commons.execServer = false;
			gridRowInsertingEventArgs.cancel = true;
			
		}
    };	
	
	 task.gridRowInsertingCallback.QV_QRRTI5057_14 = function(entities, gridRowInsertingEventArgs) {
		gridRowInsertingEventArgs.commons.execServer = false;
		var row = gridRowInsertingEventArgs.commons.api.vc.grids.QV_QRRTI5057_14.selectedRow
		if (!gridRowInsertingEventArgs.success){
			entities.DistributionLine.remove(row);
		}
		
	 }

    //BeforeViewCreationCl QueryView: Borrowers 
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
         beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //updatePoint QueryView: ManagersPointsGrid 
    task.gridRowUpdating.QV_MARPN5915_10 = function(entities, gridRowUpdatingEventArgs) {
         gridRowUpdatingEventArgs.commons.execServer = true;
    };

    //UpdateRow QueryView: GridDistributionLine 
    task.gridRowUpdating.QV_QRRTI5057_14 = function(entities, gridRowUpdatingEventArgs) {
        if( (gridRowUpdatingEventArgs.rowData.CreditType != null && gridRowUpdatingEventArgs.rowData.CreditType != "") && (gridRowUpdatingEventArgs.rowData.Module != null &&  gridRowUpdatingEventArgs.rowData.Module != "")&& gridRowUpdatingEventArgs.rowData.Currency != null && 
		gridRowUpdatingEventArgs.rowData.AmountProposed != 0 && gridRowUpdatingEventArgs.rowData.AmountLocalCurrency != 0 && gridRowUpdatingEventArgs.rowData.Quote != 0)
		{
			
				gridRowUpdatingEventArgs.commons.execServer = true;
			
			
		}else
		{
			gridRowUpdatingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_VALIDATEO_88187');  
			gridRowUpdatingEventArgs.commons.execServer = false;
		}
    };
	
	 //RowInserting QueryView: GridDIstributionLineExten 
    task.gridRowSelecting.QV_QRRTI5057_14 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
    };

    //DeleteRow QueryView: GridDistributionLine 
    task.gridRowDeleting.QV_QRRTI5057_14 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = true;
    };

	 //AfterLeaveInLineRow QueryView: GridDIstributionLineExten 
    task.gridAfterLeaveInLineRow.QV_QRRTI5057_14 = function(entities, gridAfterLeaveInLineRowEventArgs) {
         gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
    };

	//beforeEnterInLineRow QueryView: GridDIstributionLineExten 
    task.gridBeforeEnterInLineRow.QV_QRRTI5057_14 = function(entities, gridABeforeEnterInLineRowEventArgs) {
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
		 var api = gridABeforeEnterInLineRowEventArgs.commons.api;
		 if(gridABeforeEnterInLineRowEventArgs.inlineWorkMode==0){		 
			api.grid.enabledColumn("QV_QRRTI5057_14","CreditType");
			api.grid.enabledColumn("QV_QRRTI5057_14","Currency");		 
		 }else{
			api.grid.disabledColumn("QV_QRRTI5057_14","CreditType");
			api.grid.disabledColumn("QV_QRRTI5057_14","Currency");
		 }
    };
	
	
    //BeforeEnterLine QueryView: Borrowers 
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //SelectingRole QueryView: ManagersPointsGrid 
    task.gridRowSelecting.QV_MARPN5915_10 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //SelectDisbursement QueryView: GridDisbursementForms 
    task.gridRowSelecting.QV_QURDM9228_60 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = true;
    };

    //GridCommand (Button) QueryView: Borrowers 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
         gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: formApprobedView 
    task.initData.VC_SKVEW14_OROEW_520 = function(entities, initDataEventArgs) {
        var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		 var viewState = initDataEventArgs.commons.api.viewState;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
		}
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
			task.Etapa = parentParameters.Task.urlParams.ETAPA;
		}
		entities.OfficerAnalysis={};
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		//entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringTwo;
		entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringOne;
		
		entities.OriginalHeader.UserL=userL;
        entities.OriginalHeader.TypeRequest = "P";
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		
		//Oculta Menu de Cabecera en Tabla de amortizacion
		BUSIN.API.GRID.hideFilter('QV_QUYOI3312_16', initDataEventArgs.commons.api);
		
		task.hideField(viewState);

		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office=cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL =cobis.userContext.getValue(cobis.constant.USER_NAME);
		
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.OriginalHeader.NumberLine = client.bussinessInformationStringOne;

		if (client.clientId != 0 && client.clientId != undefined && client.clientId != ''){
			var client = initDataEventArgs.commons.api.parentVc.model.Task;
			var cust = new DebtorGeneral(client.clientId,client.clientName, 'D', '');
			listCustomer.push(cust);
			initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
		}
		//APROBACION - DESEMBOLSO BAJO LINEA CREDITO
		//MCA - Se asigna parámetros para ingreso a Desembolso
		if(task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Desembolso  && task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion  ){
			entities.OriginalHeader.NumberLine = client.bussinessInformationStringOne;
			entities.OriginalHeader.OfficerName = cobis.userContext.getValue(cobis.constant.USER_FULLNAME);
			task.IsDisbursement = true;
		}
    };
	
	  task.initDataCallback.VC_SKVEW14_OROEW_520 = function(entities, initDataEventArgs) {
		 initDataEventArgs.commons.execServer = false;
	  }
	  
    //ViewContainer: formApprobedView 
    task.render = function(entities, renderEventArgs) {
         renderEventArgs.commons.execServer = false;
		 var api = renderEventArgs.commons.api;
		 var viewState = renderEventArgs.commons.api.viewState;
		 task.disableField(viewState);
		 
		 BUSIN.API.readOnlyAsync(renderEventArgs,['VA_APITONEAEE5505_EPRO465'],true,2000); // ACH -- hoy -- Para desabilitar destino geofrafico en explorer  // hoy moneda

		//Deshabilito los botones de crear nuevo de deudores
		api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');  // ACH --
		api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); // ACH --  
		
		  //Cuando es APROBACION y MODIFICACION LC PLAZO
		if(task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion && task.EtapaTramite === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo){
			  //ACH -- hoy -- Botones en Distribucion de Linea
				var ds = renderEventArgs.commons.api.vc.model['DistributionLine'];		
				var dsData = ds.data();		
				for (var i = 0; i < dsData.length; i ++) {
					var dsRow = dsData[i];
					renderEventArgs.commons.api.grid.hideGridRowCommand('QV_QERIS7170_82', dsRow, 'edit');
					renderEventArgs.commons.api.grid.hideGridRowCommand('QV_QERIS7170_82', dsRow, 'delete');
				} 
				//oculto el boton nuevo de la grilla de Distribucion de Linea
				api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');
				
				
		}
        //Cuando es APROBACION y MODIFICACION LC PLAZO o MODIFICACION LC MONTO y PLAZO
        if((task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion && task.EtapaTramite === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo)||
		(task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion && task.EtapaTramite === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo)){
			
			api.viewState.show("VA_OVECRDTRQE4832_EDNE863"); //Aumento de nivel de endeudamiento
			task.hideFieldModificatorios(viewState);
			var ds = renderEventArgs.commons.api.vc.model['DistributionLine'];		
			var dsData = ds.data();		
			for (var i = 0; i < dsData.length; i ++) {
					var dsRow = dsData[i];
				}
				
			//oculto el boton nuevo de la grilla de Distribucion de Linea
				api.grid.hideToolBarButton('QV_QERIS7170_82', 'create');
        }
		
		
		
    };

    //**********************************************************
    //  Eventos para Grupos
    //**********************************************************
    //Contenedor de Pestañas (TabbedLayout)  View: ApproveCreditRequest 
    task.changeGroup.GR_OVECRDTRQE48_04 = function(entities, changedGroupEventArgs) {
    };
	
	task.disableField=function (viewState){
		var grps = ['VA_APITONEAEE5505_RTAY481','VA_APITONEAEE5505_PROE367','VA_APITONEAEE5505_USED740','VA_APITONEAEE5505_NDTE867','VA_APITONEAEE5505_TERM140',
					'VA_APITONEAEE5505_XPIA086','VA_APITONEAEE5505_OFIC220','VA_APITONEAEE5505_SCTR004','VA_APITONEAEE5505_ADSN125','VA_APITONEAEE5506_ITCE223',
					'VA_APITONEAEE5506_IALT470','VA_APITONEAEE5506_OQUE114','VA_APITONEAEE5506_TERM631','VA_APITONEAEE5506_FICE377','VA_OVECRDTRQE4831_ATRN348',
					'VA_OVECRDTRQE4831_0000709','VA_OVECRDTRQE4831_0000495','VA_OVECRDTRQE4831_0000135','VA_OVECRDTRQE4831_0000641','VA_APITONEAEE5511_RQSD053'] 
	    BUSIN.API.disable(viewState,grps);	
	};  
	
	task.hideField=function (viewState){
		var grps = ['GR_OVECRDTRQE48_05','GR_OVECRDTRQE48_13','GR_OVECRDTRQE48_06','GR_OVECRDTRQE48_20','GR_OVECRDTRQE48_12'] 
	    BUSIN.API.hide(viewState,grps);	
	};
	
	task.hideFieldModificatorios=function (viewState){
		var grps = ['CM_SKVEW14SAV65','GR_OVECRDTRQE48_34','GR_OVECRDTRQE48_32','GR_OVECRDTRQE48_31'] //Boton Guardar,Rebaja de Tasa,Consulta Central,Recalculo del Indice
	    BUSIN.API.hide(viewState,grps);	
	};

	
}());

DebtorGeneral = function(idClient, name, role, idNumber){
    this.CustomerCode = idClient;
    this.CustomerName = name;
    this.Role = role;
    this.Identification = idNumber;
}