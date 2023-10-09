//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: GroupComposite
task.initData.VC_GROUPCOMOS_387974 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.api.viewState.disable('VA_9596VHOLMQOEFOI_924725');
    initDataEventArgs.commons.api.viewState.disable('VA_1940KQURTPVEVBJ_839725');
    initDataEventArgs.commons.api.viewState.disable('VA_5634HKMSQGZFPUQ_212725');
    initDataEventArgs.commons.api.viewState.disable('VA_4103IWRALHJMDZX_523725');
    initDataEventArgs.commons.api.viewState.hide('CM_TGROUPCO_O3P', true);
    initDataEventArgs.commons.api.viewState.hide('VA_1778TBFOWZJSSYZ_913725');
    initDataEventArgs.commons.api.grid.disabledColumn('QV_6248_19660','increment');
    initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','safePackage');
    titular = 0;
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc = initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = parentVc == undefined || parentVc == null ? {} : parentVc.model;
    var parentUrlParameters = customDialogParameters;
    entities.Context.channel = channel; // caso203112
	
    //Pantalla desde el inbox
    if (customDialogParameters != null) {
        //Parametros
        typeOrigin = LOANS.CONSTANTS.TypeOrigin.FLUJO;
        stage = customDialogParameters.Task.urlParams.Etapa;
        if(customDialogParameters.Task.urlParams.Tipo != undefined){
            requestType = customDialogParameters.Task.urlParams.Tipo;
            entities.Credit.isRenovation = requestType;
        }
    }
    if (initDataEventArgs.commons.api.vc.mode == 1) { //Creacion de grupo 
        //Inbox
        type = 'Ingreso';
        initDataEventArgs.commons.api.grid.hideColumn('QV_7978_25243', 'secuential');
        initDataEventArgs.commons.api.viewState.hide('VC_GKVZJPXOPE_499678');
        if ((customDialogParameters != null || customDialogParameters != undefined) && parentParameters.Task != undefined) {
            var task = parentParameters.Task;
            if (task != null) {
                // initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**ACHP
                entities.Group.code = task.clientId;
                entities.Credit.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
                entities.Credit.applicationNumber = task.processInstanceIdentifier;
                entities.Credit.productType = task.bussinessInformationStringTwo;
                entities.Credit.creditCode = task.bussinessInformationIntegerTwo;
                initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
                initDataEventArgs.commons.api.viewState.show('VC_GKVZJPXOPE_499678');
            }
        }
        entities.Group.groupOffice = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code; //OFICIAL CON EL QUE SE LOGEO
       
    }
    else if (initDataEventArgs.commons.api.vc.mode == 2) { //Mantenimiento de grupo
        initDataEventArgs.commons.api.viewState.hide('VC_GKVZJPXOPE_499678');
        type = 'Consulta';
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer'
            , url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER
            , files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                                                                              }];
        nav.customDialogParameters = {
            mode: "findCustomer"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
    }
    initDataEventArgs.commons.serverParameters.Group = true;
    entities.Group.userName = cobis.userContext.getValue(cobis.constant.USER_NAME);
    initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXZSH_356190');
    initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXRFB_871190');
    initDataEventArgs.commons.api.viewState.hide('CM_TGROUPCO_2A7');
    initDataEventArgs.commons.api.viewState.hide('CM_TGROUPCO_62P');
    if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) {
        if (stage == 'CONSULTA') {
			if(parentUrlParameters.Task.urlParams.TIPO != "C"){
				initDataEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			}      
        } else if (stage === LOANS.CONSTANTS.Stage.APROBAR || stage === LOANS.CONSTANTS.Stage.ELIMINAR){ //****
            initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 = "Registrar Montos";
           /* initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 = cobis.translate("LOANS.LBL_LOANS_RBUREOYXZ_41352");*/
            initDataEventArgs.commons.api.vc.parentVc.executeCommand1 = function () {
                initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONNPVXIJW_123190', 'Registrar Montos', validator, false, false, '', false);
            }
            /*initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function () {
                initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAICSAKZ_975190', 'Consultar Buro', validator, false, false, '', false);
            }*/
            nameActivity= customDialogParameters.Task.taskSubject;			
		} else {
            initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 = "Registrar Montos";
            /*initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 = cobis.translate("LOANS.LBL_LOANS_RBUREOYXZ_41352");
*/            initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand3 = "Sincronizar Movil";
            initDataEventArgs.commons.api.vc.parentVc.executeCommand1 = function () {
                initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONNPVXIJW_123190', 'Registrar Montos', validator, false, false, '', false);
            }
           /* initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function () {
                initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAICSAKZ_975190', 'Consultar Buro', validator, false, false, '', false);
            }*/
            //SINCRONIZACION MOVIL PARA ETAPA DE INGRESO DE SOLICITUD
            if (initDataEventArgs.commons.api.vc.parentVc.customDialogParameters.Task.taskSubject == 'INGRESAR SOLICITUD') {
                initDataEventArgs.commons.api.vc.parentVc.executeCommand3 = function () {
                    initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONGPPUIHN_830190', 'Sincronizar Movil', validator, false, false, '', false);
                }
            }
            nameActivity= customDialogParameters.Task.taskSubject;            
        }
        //SE AGREGA PARA FLUJO DE RENOVACIONES
        if(requestType ==='R'){
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','cycleParticipation');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','voluntarySavings');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','authorizedAmount');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','creditBureau');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','checkRenapo');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','safePackage');
        }else{
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','oldOperation');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','oldBalance');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','resultAmount');
            initDataEventArgs.commons.api.grid.hideColumn('QV_6248_19660','checkRenapo');
        }
    }
    initDataEventArgs.commons.serverParameters.Group = true;
    initDataEventArgs.commons.serverParameters.Credit = true;
    initDataEventArgs.commons.serverParameters.Context = true;
    initDataEventArgs.commons.execServer = true;
};