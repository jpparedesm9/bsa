
/* variables locales de T_BUSINSFKMIYJN_838*/

/* variables locales de T_HEADERIIDDGZO_939*/

/* variables locales de T_BUSINPORUZCUB_860*/

(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

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

    
        var task = designerEvents.api.dataverificationquestionscompound;
    

    //"TaskId": "T_BUSINSFKMIYJN_838"

var taskHeader = {};
var typeRequest = '';

task.loadTaskHeader = function (entities, eventArgs) {    
    var client = eventArgs.commons.api.parentVc.model.Task;
    var context = entities.Context;
    var originalh = entities.OriginalHeader;
    
   // Titulo de la cabecera (title)
   if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
	   LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientId + " - " + client.clientName);
   }else{
	   LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);
   }
   
    // Subtitulos de la cabecera       
   LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == '0' ? '--' : originalh.IDRequested), 0);

   //LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', (entities.OriginalHeader.category == null ? ' ': entities.OriginalHeader.category), 0)//SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
   LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountAprobed == null || originalh.AmountAprobed == 'null' ? 0 : originalh.AmountAprobed), 2), 0);//ACHP
   //SMO cambia en grupales  LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.GeneralData.symbolCurrency, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.GeneralData.mnemonicCurrency, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.OriginalHeader.Term, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.GeneralData.paymentFrecuencyName, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
   //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((entities.OfficerAnalysis.OfficierName != null) ? entities.OfficerAnalysis.OfficierName.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
    //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
    //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.GeneralData.loanType, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', (entities.OriginalHeader.Type == null ? ' ' : entities.OriginalHeader.Type) + " " + (entities.OriginalHeader.subType == null ? ' ' : entities.OriginalHeader.subType), 1);//SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.GeneralData.vinculado, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.GeneralData.sectorNeg, 1);
    if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
	    LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', (context.cycleNumber == null? '--' : context.cycleNumber), 1);
    }else{
	    LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', (context.cycleNumber == null? '--' : context.cycleNumber), 1);
    }

    // Actualizo el grupo de designer
    LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_HEADERZBOW_963263');
};

   task.showButtons = function (args) {
       var api = args.commons.api;
       var parentParameters = args.commons.api.parentVc.customDialogParameters;
       // Boton Principal (Wizard)
       // initDataEventArgs.commons.api.vc.parentVc.executeSaveTask =
       // function(){
       // initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save',
       // undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
       // }

       // Boton Secundario 1 (Wizard)
       // (Para aumentar un boton adicional copiar y pegar el bloque de codigo
       // debajo de estos comentarios)
       // (Posteriormente cambiar el numero de terminacion de la etiqueta Ej.
       // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 =>
       // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
       // (Posteriormente cambiar el numero de terminacion del metodo Ej.
       // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
       // function() =>
       // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
       // function())
       // (Tiene una limitacion de 5 axecute commands)

       if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == "Q") {
           args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
       } else {
           args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar";
           args.commons.api.vc.parentVc.executeCommand1 = function () {
               args.commons.api.vc.executeCommand('CM_TBUSINSF_3N8', 'Save', undefined, true, false, 'VC_DATAVERITO_790838', false);
           }

           args.commons.api.vc.parentVc.labelExecuteCommand2 = "Sincronizar Movil";
           args.commons.api.vc.parentVc.executeCommand2 = function () {
               args.commons.api.vc.executeCommand('CM_TBUSINSF_SSU', "Synchronize Mobile", undefined, true, false, 'VC_DATAVERITO_790838', false);
           }		   
       }
   };

    	// (Button) 
    task.executeCommand.CM_TBUSINSF_3N8 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	// (Button) 
    task.executeCommandCallback.CM_TBUSINSF_3N8 = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        
        var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
        if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
        
        
        
        
    };

	// (Button) 
    task.executeCommand.CM_TBUSINSF_SSU = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	// (Button) 
task.executeCommandCallback.CM_TBUSINSF_SSU = function (entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.execServer = false;
		var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
		if(entities.Context.enable === 'N'){
			/*var ctrs = ['CM_TBUSINSF_3N8', 'CM_TBUSINSF_SSU'] -- Se habilita por bug B139427 Spring20*/
		    var ctrs = ['CM_TBUSINSF_3N8']
			BUSIN.API.disable(viewState, ctrs);
			entities.Context.enable = 'N' // Al dar clic debe bloquerse todo el cuestionario
			//angular.element('#VC_DATAVERION_567496').scope().vc.model.QuestionsPartThree.enableView=12;
		}      
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestionsCompound
    task.initData.VC_DATAVERITO_790838 = function (entities, initDataEventArgs){   
        var viewState = initDataEventArgs.commons.api.viewState;
        var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;
        var parentParameters = initDataEventArgs.commons.api.parentVc.model; // Recupero parametros de la ventana padre
        typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
        // Set de campos
		entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;
		entities.OriginalHeader.OpNumberBank = parentParameters.Task.bussinessInformationStringOne;
		entities.GeneralData.type = parentParameters.Task.urlParams.TRAMITE;
        entities.Context.CustomerId = parentParameters.Task.clientId;       
        entities.Context.ApplicationSubject = parentParameters.Task.taskSubject;
        initDataEventArgs.commons.execServer = true;
        
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestionsCompound
    task.initDataCallback.VC_DATAVERITO_790838 = function (entities, initDataCallbackEventArgs){
        initDataCallbackEventArgs.commons.execServer = true;      
        task.loadTaskHeader(entities, initDataCallbackEventArgs);
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: DataVerificationQuestionsCompound
    task.render = function (entities, renderEventArgs){
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = renderEventArgs.commons.api.viewState;
        var api = renderEventArgs.commons.api;
        var customDialogParameters = renderEventArgs.commons.api.vc.parentVc.customDialogParameters;
        typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
        
        renderEventArgs.commons.execServer = false;
        
        // Modo Consulta
		task.showButtons(renderEventArgs);
		// Se comenta todo porque siempre debe que estar oculto		
		var ctrs = ['CM_TBUSINSF_3N8']
		BUSIN.API.hide(viewState, ctrs);
		
		var ctrsEna = ['CM_TBUSINSF_SSU'] /*-- Se habilita por bug B139427 Spring20*/
		BUSIN.API.enable(viewState, ctrsEna);
		/*	
		var grid = renderEventArgs.commons.api.grid;
		if (entities.Context.enable === 'N') {
		    var ctrs = ['CM_TBUSINSF_3N8', 'CM_TBUSINSF_SSU']
		    BUSIN.API.disable(viewState, ctrs);
		} else if (entities.Context.enable === 'S' && entities.Context.synchronize === 'N') {
		    var ctrs = ['CM_TBUSINSF_SSU']
		    BUSIN.API.disable(viewState, ctrs);
		} else if (entities.Context.enable === 'S' && entities.Context.synchronize === 'S') {
		    var ctrs = ['CM_TBUSINSF_SSU']
		    BUSIN.API.enable(viewState, ctrs);
		}*/
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: undefined
task.initData.VC_HEADEROGYA_884939 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    // initDataEventArgs.commons.serverParameters.entityName = true;
};

	//showGridRowDetailIcon QueryView: QV_7029_28177
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_7029_28177 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };

	//MemberQuestionQuery Entity: 
    task.executeQuery.Q_MEMBEREN_7029 = function(executeQueryEventArgs){
        //Debe estar en false - se cambia al generar a true
        executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridInitDetailTemplate QueryView: QV_7029_28177
        //
        task.gridInitDetailTemplate.QV_7029_28177 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            gridInitDetailTemplateEventArgs.commons.execServer = false;
		    var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;
            var api = gridInitDetailTemplateEventArgs.commons.api;
            nav.customDialogParameters = {
				idMember: gridInitDetailTemplateEventArgs.modelRow.codeMember,
				idTramite: entities.OriginalHeader.IDRequested,
                productType: entities.OriginalHeader.ProductType,
				applicationSubject:entities.Context.ApplicationSubject,
				enable: entities.Context.enable
			};
            nav.address = {
               moduleId: 'BUSIN',
               subModuleId: 'FLCRE',
               taskId: 'T_BUSINIJVXCUKR_496',
               taskVersion: '1.0.0',
               viewContainerId: 'VC_DATAVERION_567496'
            };
            nav.openDetailTemplate('QV_7029_28177', gridInitDetailTemplateEventArgs.modelRow);            
        };



}));