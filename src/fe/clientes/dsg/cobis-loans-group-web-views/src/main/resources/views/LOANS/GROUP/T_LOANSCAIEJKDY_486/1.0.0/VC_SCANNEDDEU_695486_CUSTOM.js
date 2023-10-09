
/* variables locales de T_LOANSCAIEJKDY_486*/


/* variables locales de T_HEADERGROUPPP_728*/

/* variables locales de T_LOANSLCOEGDWR_614*/

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

    
        var task = designerEvents.api.scanneddocuments;
    

    //"TaskId": "T_LOANSCAIEJKDY_486"
    var taskHeader = {};
    var type = '';

    task.loadTaskHeader = function (entities, eventArgs) {
        //LATFO.INBOX.addTaskHeader(taskHeader, 'title', 'Titulo', 0);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha de Constituci\u00f3n', '01-01-2017', 1);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del grupo', '01', 2);
        
		
		
		
		LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.Group.code + " - " + entities.Group.nameGroup, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', entities.Credit.creditCode, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', entities.Credit.category, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested  == 'null' ? 0 : entities.Credit.amountRequested ), 2), 1);
		LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount  == 'null' ? 0 : entities.Credit.approvedAmount ), 2), 1);
		LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.Credit.term, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.Credit.paymentFrecuency, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Credit.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Credit.officeName), 2);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', entities.Credit.subtype, 2);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado',  entities.Credit.linked, 2);
		LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', entities.Group.cycleNumber, 2);
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_HEADERGUOP_223993');
        eventArgs.commons.api.viewState.show('G_HEADERGUOP_223993');
    };

    	// (Button) 
    task.executeCommand.CM_TLOANSCA_SL0 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ScannedDocuments
    task.initData.VC_SCANNEDDEU_695486 = function (entities, initDataEventArgs){
        //initDataEventArgs.commons.execServer = true;
        /*LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.Group.nameGroup, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha de Constituci\u00f3n', dia + "-" + mes + "-" + anio, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del grupo', entities.Group.code, 2);
        LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_HEADERGUOP_223993');
        executeCommandCallbackEventArgs.commons.api.viewState.show('G_HEADERGUOP_223993');*/
		
        var nav = initDataEventArgs.commons.api.navigation;
        var parentVc = initDataEventArgs.commons.api.vc.parentVc;
        var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
        var parentParameters = parentVc == undefined || parentVc == null ? {} : parentVc.model;
        if(initDataEventArgs.commons.api.vc.mode == 1){
		type = 'Ingreso';
        //initDataEventArgs.commons.api.grid.hideColumn('QV_7978_25243', 'secuential');
        //initDataEventArgs.commons.api.viewState.hide('VC_GKVZJPXOPE_499678');
        if ((customDialogParameters != null || customDialogParameters != undefined) && parentParameters.Task != undefined) {
            var task = parentParameters.Task;
            if (task != null) {
                // initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**ACHP
                entities.Group.code = task.clientId;
				entities.Credit.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
				entities.Credit.applicationNumber = task.processInstanceIdentifier;
				entities.Credit.productType = task.bussinessInformationStringTwo;
				entities.Credit.creditCode = task.bussinessInformationIntegerTwo;
                entities.UploadedDocuments.groupId = entities.Group.code;
                entities.UploadedDocuments.processInstance = entities.Credit.applicationNumber;
				//initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
                //initDataEventArgs.commons.api.viewState.show('VC_GKVZJPXOPE_499678');
            }
        }
		initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //**ACHP
		}else if (initDataEventArgs.commons.api.vc.mode == 2) { //Creacion de grupo 
            type = 'Consulta'
            nav.label = 'B\u00FAsqueda de Clientes';
            nav.customAddress = {
                id: 'findCustomer',
                url: '/customer/templates/find-customers-tpl.html'
            };
            nav.scripts = [{
                module: cobis.modules.CUSTOMER,
                files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                                                                                  }];
            nav.customDialogParameters = {
                mode: "findCustomer"
            };
            nav.modalProperties = {
                size: 'lg'
            };
            nav.openCustomModalWindow('findCustomer');
			//initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**ACHP
        }
        initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 = "Validar";
        initDataEventArgs.commons.api.vc.parentVc.executeCommand1 = function () {
            initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJQYRZQE_653539', 'Validar', validator, false, false, '', false);
        }
		entities.Group.userName = cobis.userContext.getValue(cobis.constant.USER_NAME);
        initDataEventArgs.commons.serverParameters.Group = true;
		initDataEventArgs.commons.serverParameters.Credit = true;
        
    };

	//Start signature to Callback event to VC_SCANNEDDEU_695486
task.initDataCallback.VC_SCANNEDDEU_695486 = function(entities, initDataCallbackEventArgs) {
//here your code
    console.log("entra a callback");
    //Llamada a la funcion que muestra datos de la cabecera
    task.loadTaskHeader(entities, initDataCallbackEventArgs);
	//Se crea filtro para llenar la grilla
	var filtro = {
				groupId: entities.Group.code
			}
	//initDataCallbackEventArgs.commons.api.grid.refresh('QV_1763_79525',filtro);    
};

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: ScannedDocuments
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
        var response = onCloseModalEventArgs.result;
        if (response != undefined) {
            var filtro ={groupId:response.selectedData.groupId}
            //Refresh de la grilla para llenar la entidad
            onCloseModalEventArgs.commons.api.grid.refresh('QV_1763_79525');
            
            /*if (onCloseModalEventArgs.result.params.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                if (response.addRow != undefined && response.addRow === 'S') {
                    if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                        onCloseModalEventArgs.commons.api.grid.addRow('Member', onCloseModalEventArgs.result.response.data, true);


                    }
                }
                //onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
                
                //onCloseModalEventArgs.commons.execServer = true;
            } else if (onCloseModalEventArgs.result.response.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('Member', onCloseModalEventArgs.result.response.index, onCloseModalEventArgs.result.response.data, true);

                }
                //onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
                //onCloseModalEventArgs.commons.execServer = true;
            }*/
        }
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ScannedDocuments
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        var filtro = {
				groupId: entities.Group.code,
				applicationNumber: entities.Credit.creditCode
			}
	   renderEventArgs.commons.api.grid.refresh('QV_1763_79525',filtro);
    };

	//showGridRowDetailIcon QueryView: QV_1763_79525
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_1763_79525 = function (entities, showGridRowDetailIconEventArgs) {

        //gridInitDetailTemplate
        

        return true;
        
    };

	//Entity: UploadedDocuments
    //UploadedDocuments. (Button) View: ScannedDocuments
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONJQYRZQE_653539 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
        
        //executeCommandEventArgs.commons.serverParameters.UploadedDocuments = true;
    };

	//Entity: UploadedDocuments
    //UploadedDocuments. (Button) View: ScannedDocuments
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONJQYRZQE_653539 = function(  entities, executeCommandCallbackEventArgs ) {

        executeCommandCallbackEventArgs.commons.execServer = false;
        
        if(entities.UploadedDocuments.uploads){
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Los documentos fueron completados', true);
        } else {
            executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //**POV
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('Faltan documentos por subir', true);
        }
        
    };

	//DebtorQuery Entity: 
    task.executeQuery.Q_DEBTORJD_1763 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridInitDetailTemplate QueryView: QV_1763_79525
        //
        task.gridInitDetailTemplate.QV_1763_79525 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            var customerId = gridInitDetailTemplateEventArgs.modelRow.members;
			var asd = customerId.split("-");
            var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;
            
			nav.address = {
			moduleId: 'LOANS',
			subModuleId: 'GROUP',
			taskId: 'T_LOANSTIAEJUNH_604',
			taskVersion: '1.0.0',
			viewContainerId: 'VC_SCANNEDDAE_495604'
			};
			nav.queryParameters = {
			mode: 8 
			};
			nav.openDetailTemplate('QV_1763_79525', gridInitDetailTemplateEventArgs.modelRow);
        };



}));