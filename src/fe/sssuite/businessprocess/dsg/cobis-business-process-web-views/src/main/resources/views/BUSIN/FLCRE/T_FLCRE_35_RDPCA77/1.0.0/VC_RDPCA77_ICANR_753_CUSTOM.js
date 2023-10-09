<!-- Designer Generator v 5.1.0.1608 - release SPR 2016-08 29/04/2016 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.approvedapplication;
	var taskHeader = {};

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de cabecera.
    //  task.changeWithError.allGroup = true;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de grilla.
    //  task.changeWithError.allGrid = true;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.Autorizar (Button) View: ExceptionsView
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_EEPTIONVIW2204_0000550 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };
	
	task.executeCommandCallback.VA_EEPTIONVIW2204_0000550 = function(entities, executeCommandCallbackEventArgs) { //
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};    

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button) 
    task.executeCommand.CM_RDPCA77SAE65 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    }; 
	
	task.executeCommandCallback.CM_RDPCA77SAE65 = function(entities, executeCommandEventArgs) {
        BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
    };

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
    task.gridInitColumnTemplate.QV_UERXC4756_18 = function(idColumn) {
        if(idColumn === 'Aproved'){
			//return "<input type=\'checkbox\' name=\'Aproved\' id=\'VA_OVECRDTRQE4824_EULT673\' #if (Aproved === true) {# checked #}# ng-click=\"vc.grids.QV_UERXC4756_18.events.customRowClick($event, \'VA_OVECRDTRQE4824_EULT673\', \'Exceptions\', grids.QV_UERXC4756_18)\" />";
			return "<input type=\'checkbox\' name=\'Aproved\' id=\'VA_OVECRDTRQE4824_EULT673\' #if (Aproved === true) {# checked #}# ng-click=\"vc.grids.QV_UERXC4756_18.events.customRowClick($event, \'VA_OVECRDTRQE4824_EULT673\', \'Exceptions\', \'QV_UERXC4756_18\')\" />";
			
		}
    };
	task.showGridRowDetailIcon.QV_UERXC4756_18 = function (entities, showGridRowDetailIconEventArgs){
		var result=false;
		var row = showGridRowDetailIconEventArgs.rowData;
		if(row.Type==='D'){
			result=false;
		}else{
			result=true;
		}
	return result;
	};
	task.gridRowSelecting.QV_UERXC4756_18 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
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

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: PoliciesAndExceptionsForm 
    task.initData.VC_RDPCA77_ICANR_753 = function(entities, initDataEventArgs) {
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
		
		var viewState = initDataEventArgs.commons.api.viewState;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		var parentParameters = initDataEventArgs.commons.api.parentVc.model; //OGU
		entities.OriginalHeader.UserL=userL;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;	
		entities.OriginalHeader.ActivityNumber = parentParameters.Task.taskInstanceIdentifier;
		var client = initDataEventArgs.commons.api.parentVc.model.Task;		
		initDataEventArgs.commons.execServer = true;
    };
	
	task.initDataCallback.VC_RDPCA77_ICANR_753 = function(entities, initDataEventArgs) {        
	
		task.loadTaskHeader(entities,initDataEventArgs);
		initDataEventArgs.commons.execServer = false;		
        // initDataEventArgs.commons.serverParameters.entityName = true;
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: PoliciesAndExceptionsForm 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = renderEventArgs.commons.api.viewState;	
		
		task.showButtons(renderEventArgs);
		
		//********Parametros
		//********Modo
		//Modo Consulta
		if(parentParameters.Task.urlParams.Modo==FLCRE.CONSTANTS.Mode.Query){			
		}
		//********Etapas
		//Aprobacion
		if(parentParameters.Task.urlParams.Etapa==FLCRE.CONSTANTS.Stage.Aprobacion){			
		}	
		
		//********Tramite
		//Refinanciamiento, Reestructuracion, Renovacion
		if(parentParameters.Task.urlParams.Tramite==FLCRE.CONSTANTS.RequestName.Refinancing
		||parentParameters.Task.urlParams.Tramite==FLCRE.CONSTANTS.RequestName.Renovation
		||parentParameters.Task.urlParams.Tramite==FLCRE.CONSTANTS.RequestName.Reestructuration
		){
			
		}				
    };
	
	task.loadTaskHeader=function(entities,eventArgs){
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.OriginalHeader;
		var plazo='0';		

		if(originalh.Term==null||originalh.Term==undefined){
			entities.OriginalHeader.Term=0;
			plazo='0';
		}else{
			//entities.OriginalHeader.Term=entities.OfficerAnalysis.Term;
			plazo=entities.OriginalHeader.Term;
		}
		entities.OriginalHeader.CurrencyRequested=2;
		
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.IDRequested==null||originalh.IDRequested=='null' ? '--':originalh.IDRequested),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested ==null||originalh.AmountRequested =='null' ? 0:originalh.AmountRequested ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',plazo+' '+entities.generalData.paymentFrecuencyName,0);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((originalh.OfficierName!=null)?originalh.OfficierName.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};
	
		task.showButtons = function(args){
		var api = args.commons.api;
		var parentParameters = args.commons.api.parentVc.customDialogParameters;
		//Boton Principal (Wizard)
		//initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
		//	initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
		//}
		
		//Boton Secundario 1 (Wizard)
		//(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
		//(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
		//(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
		//(Tiene una limitacion de 5 axecute commands)
		
		if(parentParameters.Task.urlParams.Modo!= undefined&&parentParameters.Task.urlParams.Modo!=null
		&&parentParameters.Task.urlParams.Modo==FLCRE.CONSTANTS.Mode.Query){
			args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}else{
			args.commons.api.vc.parentVc.labelExecuteCommand1 = "Autorizar";
			args.commons.api.vc.parentVc.executeCommand1 = function(){
				args.commons.api.vc.executeCommand('CM_RDPCA77SAE65','Autorizar', undefined, true, false, 'VC_RDPCA77_ICANR_753', false);
			}	
		}		
	};
}());