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