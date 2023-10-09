/*global designerEvents, console */
(function () {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola
    //  console.log("executeCommand");

    //  Para enviar mensaje use
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************

    var task = designerEvents.api.entrywarranty;
	task.EtapaTramite = '';
	task.Etapa = '';
	var taskHeader = {};

//"TaskId": "T_FLCRE_21_EYWRY63"

	// (Button) 
    task.executeCommand.CM_EYWRY63SOA19 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
    };

	//Start signature to callBack event to CM_EYWRY63SOA19
    task.executeCommandCallback.CM_EYWRY63SOA19 = function(entities, executeCommandCallbackEventArgs) {
        BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		task.disableRowGrid(executeCommandCallbackEventArgs, 'OtherWarranty' , 'QV_URYTH5890_66');
		task.disableRowGrid(executeCommandCallbackEventArgs, 'PersonalGuarantor', 'QV_PESAU2317_81');
		if(executeCommandCallbackEventArgs.success){		 
		  //Set del campo HiddenInCompleted para poder continuar la tarea
		  executeCommandCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
    };

task.disableRowGrid = function(eventArgs, entity , idGrid ){

		var ds = eventArgs.commons.api.vc.model[entity];
		var grid = eventArgs.commons.api.grid;
		var dsData = ds.data();
        for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
            if(dsRow.isHeritage === 'S'){
                grid.addRowStyle(idGrid, dsRow, 'Disable_CTR');
			    grid.hideGridRowCommand(idGrid, dsRow, 'delete');
            }else{
				grid.removeRowStyle(idGrid, dsRow, 'Disable_CTR');
				grid.showGridRowCommand(idGrid, dsRow, 'delete');
			}
        }
		eventArgs.commons.api.viewState.refreshData(idGrid);
	};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: EntryWarranty
    task.initData.VC_EYWRY63_FMRRT_302 = function (entities, initDataEventArgs){
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
          entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;   
		
		//Creacion de entidad temporal para enviar el id del cliente
		entities.EntityClient = {clientId : initDataEventArgs.commons.api.parentVc.model.Task.clientId};
		
		initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
			initDataEventArgs.commons.api.vc.executeCommand('CM_EYWRY63SOA19','Associate', undefined, true, false, 'VC_EYWRY63_FMRRT_302', false);
		}
        
    };

	//Start signature to callBack event to VC_EYWRY63_FMRRT_302
    task.initDataCallback.VC_EYWRY63_FMRRT_302 = function(entities, initDataEventArgs) {
        if(entities.OriginalHeader.TypeRequest == FLCRE.CONSTANTS.Tramite.Refinanciamiento){ //CUANDO ES REFINANCIAMIENTO
			BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
		}		
		task.loadTaskHeader(entities,initDataEventArgs);
    };

task.loadTaskHeader=function(entities,eventArgs){
		
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.OriginalHeader;
		
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.IDRequested==null||originalh.IDRequested=='null' ? '--':originalh.IDRequested),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested ==null||originalh.AmountRequested =='null' ? 0:originalh.AmountRequested ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda','USD',0);//tomar el campo de moneda(codigo??)
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',originalh.Term,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((originalh.OfficerName!=null)?originalh.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
          //LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);
		
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: EntryWarranty
    task.render = function (entities, renderEventArgs){
       var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
    	
    	if (parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == 'Q') {
    		task.hideModeQuery(renderEventArgs);    	
    	}
    	
    	var columns1 = ['CodeWarranty','Type','Description','GuarantorPrimarySecondary','ClassOpen','IdCustomer','State','CurrentValue',
        	            'Currency'];
        BUSIN.API.GRID.addColumnsStyle('QV_PESAU2317_81', 'Grid-Column-Header',renderEventArgs.commons.api,columns1);
        
        var columns2 = ['CodeWarranty','Type','Description','InitialValue','DateAppraisedValue','ValueApportionment','ClassOpen','ValueAvailable',
       	            'IdCustomer','NameGar','State','ValueVNR','RelationshipGuarantees'];
        BUSIN.API.GRID.addColumnsStyle('QV_URYTH5890_66', 'Grid-Column-Header',renderEventArgs.commons.api,columns2);
        
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'CodeWarranty', 150);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'Description', 110);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'DateAppraisedValue', 90);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'InitialValue', 90);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'State', 110);
       
	   task.showButtons(renderEventArgs);
        
    };

task.hideModeQuery = function(args) {
		
		//Variables
		var api = args.commons.api;
		var personalGuarantorDs = api.vc.model['PersonalGuarantor'].data();
		var otherWarrantyDs = api.vc.model['OtherWarranty'].data();

		//Deshabilito los botones
		args.commons.api.vc.viewState.CM_EYWRY63SOA19.visible = false;
		args.commons.api.vc.viewState.VA_UARNTEESEW9610_HBTN418.visible = false;
		args.commons.api.vc.viewState.VA_UARNTEESEW9610_0000924.visible = false;
		BUSIN.API.GRID.hideCommandColumns('QV_PESAU2317_81',personalGuarantorDs,api,'edit');
		BUSIN.API.GRID.hideCommandColumns('QV_PESAU2317_81',personalGuarantorDs,api,'delete');				
		BUSIN.API.GRID.hideCommandColumns('QV_URYTH5890_66',otherWarrantyDs,api,'edit');
		BUSIN.API.GRID.hideCommandColumns('QV_URYTH5890_66',otherWarrantyDs,api,'delete');		
		
		//Set del campo HiddenInCompleted para poder continuar la tarea
		args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			
	};

task.showButtons = function(args){
		var api = args.commons.api;
		var parentParameters = args.commons.api.parentVc.customDialogParameters;

		if(parentParameters.Task.urlParams.MODE!= undefined&&parentParameters.Task.urlParams.MODE!=null
		&&parentParameters.Task.urlParams.MODE=="Q"){
			args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}else {
		
		// Boton Secundario 1 (Wizard)
			//(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
			//(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
			//(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
		// (Tiene una limitacion de 5 axecute commands)			
		args.commons.api.vc.parentVc.labelExecuteCommand1 = "Asociar";
		args.commons.api.vc.parentVc.executeCommand1 = function(){
			args.commons.api.vc.executeCommand('CM_EYWRY63SOA19','Associate', undefined, true, false, 'VC_EYWRY63_FMRRT_302', false);
		}					
			//Set del campo HiddenInCompleted para poder continuar la tarea
			args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";			
			
		
		}

		
			
	};

	//Entity: GuaranteesBtn
    //GuaranteesBtn. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_UARNTEESEW9610_0000924 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
		/*var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_35_RRCAI67','VC_RRCAI67_WACRI_884');
		nav.modalProperties = { size: 'lg' };
		nav.customDialogParameters = { maxRelation : task.getMaxPrelation(entities)};
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);*/
        FLCRE.UTILS.GUARANTEE.openFindGuarantee(entities,executeCommandEventArgs,{});
        
    };

task.getMaxPrelation = function(entities){
		var relations = [];
		entities.PersonalGuarantor.data().forEach(function(garPersonal){
			relations.push(garPersonal.relation);
		});
		entities.OtherWarranty.data().forEach(function(garOther){
			relations.push(garOther.relation);
		});
		relations.sort(function(elem1, elem2){
			return elem2-elem1;
		});
		return relations[0];
	};

//CloseModal Creacion de Garantias
	task.closeModalEvent.VC_RRCAI67_WACRI_884 = function(eventArgs){
		var response = eventArgs.result;	
		
		if(response!=null && response!=undefined){			
			if(response.Type != 'PERSONAL'){   //GARGPE
				var otherWarranties = eventArgs.commons.api.vc.model.OtherWarranty==undefined?[]:eventArgs.commons.api.vc.model.OtherWarranty.data();
				otherWarranties.forEach(function(otherWarrantyItem){
					if(otherWarrantyItem.CodeWarranty == response.CodeWarranty){
						otherWarrantyItem.CodeWarranty = response.CodeWarranty;
						otherWarrantyItem.Type= response.Type;
						otherWarrantyItem.Description= response.Description;
						otherWarrantyItem.InitialValue= response.InitialValue;
						otherWarrantyItem.DateAppraisedValue= response.DateAppraisedValue;
						otherWarrantyItem.ValueApportionment= response.ValueApportionment;
						otherWarrantyItem.ClassOpen= response.ClassOpen;
						otherWarrantyItem.ValueAvailable= response.ValueAvailable;
						otherWarrantyItem.IdCustomer= response.IdCustomer;
						otherWarrantyItem.NameGar= response.NameGar;
						otherWarrantyItem.State= response.State;
						otherWarrantyItem.Flag= response.Flag;
						otherWarrantyItem.IsNew= response.IsNew;
						otherWarrantyItem.ValueVNR= response.ValueVNR;
						otherWarrantyItem.RelationshipGuarantees= response.RelationshipGuarantees;
						otherWarrantyItem.isHeritage= response.isHeritage;
						otherWarrantyItem.relation= response.relation;
					}
				})
				eventArgs.commons.api.vc.model.OtherWarranty.data(otherWarranties);
			}else{
				var personalWarranties = eventArgs.commons.api.vc.model.PersonalGuarantor==undefined?[]:eventArgs.commons.api.vc.model.PersonalGuarantor.data();
				personalWarranties.forEach(function(personalWarrantyItem){
					if(personalWarrantyItem.CodeWarranty == response.CodeWarranty){
						personalWarrantyItem.CodeWarranty = response.CodeWarranty;
						personalWarrantyItem.Type = response.Type;
						personalWarrantyItem.Description = response.Description;
						personalWarrantyItem.GuarantorPrimarySecondary = response.GuarantorPrimarySecondary;
						personalWarrantyItem.ClassOpen = response.ClassOpen;
						personalWarrantyItem.IdCustomer = response.IdCustomer;
						personalWarrantyItem.State = response.State;
						personalWarrantyItem.DateCIC = response.DateCIC;
						personalWarrantyItem.isHeritage = response.isHeritage;
						personalWarrantyItem.CurrentValue = response.CurrentValue;
						personalWarrantyItem.Currency = response.Currency;
					}
				})
				eventArgs.commons.api.vc.model.PersonalGuarantor.data(personalWarranties);
			}
			//Set del campo HiddenInCompleted para poder continuar la tarea
			eventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		}
    };   

	//Entity: GuaranteesBtn
    //GuaranteesBtn. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_UARNTEESEW9610_HBTN418 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
		var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_24_GURNH31','VC_GURNH31_OMREA_904');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
		nav.modalProperties = { size: 'lg' };
		nav.queryParameters = { mode: executeCommandEventArgs.commons.constants.mode.Update };
		nav.customDialogParameters = { maxRelation : task.getMaxPrelation(entities)};
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);
        
    };

task.closeModalEvent.VC_GURNH31_OMREA_904 = function(eventArgs){
		FLCRE.UTILS.GUARANTEE.addFromSearch(eventArgs);
		if (eventArgs.result.parameterGuarantee != null && eventArgs.result.parameterGuarantee != undefined){
			//Set del campo HiddenInCompleted para poder continuar la tarea
			eventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		}
    };    

	//gridRowDeleting QueryView: GridPersonalGuarantor
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_PESAU2317_81 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        
    };

	//gridRowSelecting QueryView: GridPersonalGuarantor
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_PESAU2317_81 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };

	//gridRowDeleting QueryView: GridOtherWarranty
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_URYTH5890_66 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        
    };

	//gridRowSelecting QueryView: GridOtherWarranty
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_URYTH5890_66 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };


}());