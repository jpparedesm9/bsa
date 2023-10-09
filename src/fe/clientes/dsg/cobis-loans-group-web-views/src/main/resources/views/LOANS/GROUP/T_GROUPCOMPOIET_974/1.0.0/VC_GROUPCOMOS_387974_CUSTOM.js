
/* variables locales de T_GROUPCOMPOIET_974*/

/* variables locales de T_HEADERGROUPPP_728*/

/* variables locales de T_GROUPWJDAQBWK_520*/

/* variables locales de T_MEMBERHUJKTOU_740*/

/* variables locales de T_AMOUNTZDGDPDF_678*/

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

    
        var task = designerEvents.api.groupcomposite;
    

    //"TaskId": "T_GROUPCOMPOIET_974"
var showHeader = true;
var taskHeader = {};
var type = '';
var stage = '';
var titular=0;
var typeConsulta = 'Consulta';
var typeIngreso = 'Ingreso';
var typeOrigin = '';
var porcentaje = 0;
var nameActivity = '';
var requestType = '';
var channel = 4; // tabla cl_canal caso203112

task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
	//args.model.Group.code = resp.CodeReceive;
    if (type == 'Consulta') {
        args.commons.api.viewState.disable('VA_TEXTINPUTBOXQKV_915725', false);
        args.commons.api.viewState.disable('VA_DATEFIELDBVXWGU_529725', false);
    }else if (type == 'Ingreso') {
        args.commons.api.viewState.enable('VA_TEXTINPUTBOXQKV_915725', false);
        args.commons.api.viewState.enable('VA_DATEFIELDBVXWGU_529725', false);
    }
     if( titular==1)
        {
        console.log("Entro a Titular1")
        args.model.Group.titular1Name  =resp.CodeReceive+"-"+ resp.name;
		args.model.Group.titularClient1  = resp.CodeReceive; 

        }
    else if(titular==2)
        {
       console.log("Entro a Titular2")  
       args.model.Group.titular2Name  =resp.CodeReceive+"-"+ resp.name;
       args.model.Group.titularClient2  = resp.CodeReceive;
        }
    if(titular==0)
    {
        args.model.Group.code = resp.CodeReceive;
    args.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
    }
};

//Para ocultar botones de grilla
task.hideButtonGridMember = function(args,entidad,queryId){
	var ds = args.commons.api.vc.model[entidad];
	var dsData = ds.data();
	for (var i = 0; i < dsData.length; i ++) {
		var dsRow = dsData[i];
		args.commons.api.grid.hideGridRowCommand(queryId, dsRow, 'edit');
		args.commons.api.grid.hideGridRowCommand(queryId, dsRow, 'delete');
	}
};



    	//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
    //ViewContainer: GroupComposite
    task.changeGroup.VC_PXLAAVTEYF_485974 = function (entities, changeGroupEventArgs){
        changeGroupEventArgs.commons.execServer = false;
        
        if(entities.Group.code == null){
			changeGroupEventArgs.commons.api.viewState.disable('VC_ZFXQOGVCIH_421740',true);
		}
        
    };

	// (Button) 
    task.executeCommand.CM_TGROUPCO_2A7 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
    };

	// (Button) 
    task.executeCommand.CM_TGROUPCO_62P = function(entities, executeCommandEventArgs) {
       
              
        executeCommandEventArgs.commons.execServer = false;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	// (Button) 
task.executeCommand.CM_TGROUPCO_IRO = function (entities, executeCommandEventArgs) {    
    entities.Group.nextVisitDate = '';    
    if (type == 'Consulta') {
        if (entities.Group.code != null && entities.Group.code != undefined && entities.Group.code != "") {
            entities.Group.operation = 'U';
            entities.Credit.customerId= entities.Group.code;
        }
    }
    else if (type == 'Ingreso') {
        if(entities.Group.code == null)
        {
        entities.Group.operation = 'I';
        }
        else
        {
            entities.Group.operation = 'U'
        }
    }
    executeCommandEventArgs.commons.serverParameters.Group = true;
    executeCommandEventArgs.commons.serverParameters.Member = true;
    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.api.viewState.show('CM_TGROUPCO_O3P', true);
};

	//Start signature to Callback event to CM_TGROUPCO_IRO
task.executeCommandCallback.CM_TGROUPCO_IRO = function (entities, executeCommandCallbackEventArgs) {
    //here your code
	var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var dia = "", mes = "", anio = "0";	
    
    if (executeCommandCallbackEventArgs.success) {
		viewState.enable('VC_ZFXQOGVCIH_421740',true);
        if (entities.Group.operation == 'I') {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('LOANS.LBL_LOANS_REGISTRAD_40101', '', 2000, false);
            
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848',     true); 
    executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
        }
        else if (entities.Group.operation == 'U') {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('LOANS.LBL_LOANS_REGISTRDE_81762', '', 2000, false);
             executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
        }
       
        //CABECERA DE PANTALLA       
        executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
        if (showHeader) {			
			if(entities.Group.constitutionDate != undefined){
				dia = entities.Group.constitutionDate.getDate();
				mes = entities.Group.constitutionDate.getMonth()+1;
				anio = entities.Group.constitutionDate.getFullYear();
			}
			if(dia < 10){
				dia= "0"+ dia;
			}
            		
			if(mes < 10){
				mes= "0"+ mes;
			}
                        
            LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.Group.nameGroup, 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha de Constituci\u00f3n', dia + "-" + mes + "-" + anio, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del grupo', entities.Group.code, 2);
            LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_HEADERGUOP_223993');
            executeCommandCallbackEventArgs.commons.api.viewState.show('G_HEADERGUOP_223993');
        }
        else {
            //Para VCC e Inbox
            executeCommandCallbackEventArgs.commons.api.viewState.hide('G_HEADERGUOP_223993');
        }
        executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848');
    }
    else {
         if(entities.Group.code!=null)
		{
			executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848',     true); 
		}
		else
		{
        entities.Group.code = undefined;
        executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_TGROUPCO_IRO');
    }
    }
    
    if (entities.Group.updateGroup == 'N') {
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VC_GROUPCOMOS_387974');
        executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_TGROUPCO_IRO');
    } else {
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VC_GROUPCOMOS_387974');
        executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
    }
    
};

	// (Button) 
    task.executeCommand.CM_TGROUPCO_O3P = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	// (Button) 
    task.executeCommandCallback.CM_TGROUPCO_O3P = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        
    };

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

	//Start signature to Callback event to VC_GROUPCOMOS_387974
task.initDataCallback.VC_GROUPCOMOS_387974 = function(entities, initDataCallbackEventArgs) {
//here your code
};

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: GroupComposite
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;
    var response = onCloseModalEventArgs.result.response;
    if (response != undefined) {
        if (onCloseModalEventArgs.result.response.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
            if (response.addRow != undefined && response.addRow === 'S') {
                if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                    onCloseModalEventArgs.commons.api.grid.addRow('Member', onCloseModalEventArgs.result.response.data, true);
                    
                    
                }
            }
            onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);

        } else if (onCloseModalEventArgs.result.response.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Member', onCloseModalEventArgs.result.response.index, onCloseModalEventArgs.result.response.data, true);
                
            }
            onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
        }
    }
     

    //if (type == typeConsulta) {
    //    onCloseModalEventArgs.commons.api.grid.hideToolBarButton('QV_7978_25243', 'create');
    //}

};

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: GroupComposite
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    renderEventArgs.commons.api.viewState.disable('G_MEMBERIDUM_459848', true);
    //renderEventArgs.commons.api.viewState.disable('G_AMOUNTGUDN_676190', true);
    var viewState = renderEventArgs.commons.api.viewState;		
	var api = renderEventArgs.commons.api;
    var parentVc = renderEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = customDialogParameters;
    if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        if (stage == LOANS.CONSTANTS.Stage.INGRESO || stage == LOANS.CONSTANTS.Stage.APROBAR ) { //****EN ETAPA DE INGRESO
            viewState.disable('VC_MQTFHWQRXJ_599520'); // Se deshabilita la parte de grupo
            //api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla
            if (stage == 'APROBAR') {
				api.grid.hideToolBarButton('QV_7978_25243', 'create');
			}
           // task.hideButtonGridMember(renderEventArgs, 'Member', 'QV_7978_25243');
          //habilita las columnas de la grilla de montos y boton en montos
            renderEventArgs.commons.api.viewState.enable('VA_VABUTTONNPVXIJW_123190');
            renderEventArgs.commons.api.viewState.enable('VC_ZFXQOGVCIH_421740');
			api.grid.enabledColumn('QV_6248_19660','secuential');
			api.grid.enabledColumn('QV_6248_19660','memberName');
			api.grid.enabledColumn('QV_6248_19660','cycleParticipation');
			api.grid.enabledColumn('QV_6248_19660','amount');
			api.grid.enabledColumn('QV_6248_19660','authorizedAmount');
			api.grid.enabledColumn('QV_6248_19660','voluntarySavings');
			api.grid.disabledColumn('QV_6248_19660','proposedMaximumSaving');
            api.grid.disabledColumn('QV_6248_19660','increment');
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
            
        }
        if (stage =='CONSULTA') { //EN ETAPA DE Consulta
            viewState.disable('VC_MQTFHWQRXJ_599520'); // Se deshabilita la parte de grupo
            api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla
            task.hideButtonGridMember(renderEventArgs, 'Member', 'QV_7978_25243');
            //se desabilita las columnas de la grilla de montos y boton en montos
            renderEventArgs.commons.api.viewState.disable('VA_VABUTTONNPVXIJW_123190');
			api.grid.disabledColumn('QV_6248_19660','secuential');
			api.grid.disabledColumn('QV_6248_19660','memberName');
			api.grid.disabledColumn('QV_6248_19660','cycleParticipation');
			api.grid.disabledColumn('QV_6248_19660','amount');
			api.grid.disabledColumn('QV_6248_19660','authorizedAmount');
			api.grid.disabledColumn('QV_6248_19660','voluntarySavings');
			api.grid.disabledColumn('QV_6248_19660','proposedMaximumSaving');   
            api.grid.disabledColumn('QV_6248_19660','increment'); 
            api.grid.hideColumn('QV_6248_19660','safePackage');
            
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
         $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXLEH_921190']").prop("disabled", "disabled");
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXUPR_288190']").prop("disabled", "disabled");
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
             $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
        }
        
        if (stage == LOANS.CONSTANTS.Stage.ELIMINAR) { //****EN ETAPA DE ELIMINAR
            viewState.disable('VC_MQTFHWQRXJ_599520'); // Se deshabilita la parte de grupo
            api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla
            // task.hideButtonGridMember(renderEventArgs, 'Member', 'QV_7978_25243');
            // habilita las columnas de la grilla de montos y boton en montos
            renderEventArgs.commons.api.viewState.enable('VA_VABUTTONNPVXIJW_123190');
            renderEventArgs.commons.api.viewState.enable('VC_ZFXQOGVCIH_421740');
			api.grid.enabledColumn('QV_6248_19660','secuential');
			api.grid.enabledColumn('QV_6248_19660','memberName');
			api.grid.enabledColumn('QV_6248_19660','cycleParticipation');
			api.grid.enabledColumn('QV_6248_19660','amount');
			api.grid.enabledColumn('QV_6248_19660','authorizedAmount');
			api.grid.enabledColumn('QV_6248_19660','voluntarySavings');
			api.grid.disabledColumn('QV_6248_19660','proposedMaximumSaving');
            api.grid.hideColumn('QV_6248_19660','safePackage');
        }		
        
        if(stage=='APROBAR'){
            //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            api.grid.showColumn('QV_6248_19660','safePackage');
            cobis.showMessageWindow.loading(true);
        }
    }
    
        
    if(type == typeIngreso && typeOrigin != LOANS.CONSTANTS.TypeOrigin.FLUJO){ // MENU ETAPA DE INGRESO     
		viewState.disable('VA_TEXTINPUTBOXGPY_589725');
		viewState.disable('VC_ZFXQOGVCIH_421740',true);
	}
    if((parentParameters!=null) && (parentParameters!=undefined)){
        if(parentParameters.Task.urlParams.TIPO=="C"){ // ESPERA CANCELACION DE CREDITO ACTIVO     
            viewState.show('CM_TGROUPCO_IRO');
            viewState.disable('CM_TGROUPCO_IRO');
            renderEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
        }
    }
   
};

	//Entity: Group
//Group.addressMember (CheckBox) View: GroupForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_8723IIAMUFLQPPL_567725 = function(  entities, changedEventArgs ) {
	changedEventArgs.commons.execServer = false;
	if(changedEventArgs.commons.api.parentVc==undefined){
		if(entities.Group.addressMember==true){
			changedEventArgs.commons.api.viewState.disable('VA_9330BRACKQSJMLZ_312725');
			changedEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725'); 
			/*  if(entities.Group.code){
				changedEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPEWRVJ_935520', false);
            }*/
        } else{
			changedEventArgs.commons.api.viewState.enable('VA_9330BRACKQSJMLZ_312725');
			changedEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725'); 
			entities.Group.meetingAddress=null;
		}
	}  
};

	//Entity: Group
//Group.otherPlace (CheckBox) View: GroupForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_9330BRACKQSJMLZ_312725 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    if (changedEventArgs.commons.api.parentVc == undefined) {
        if (entities.Group.otherPlace == true) {
            if (entities.Group.updateGroup != 'N') {
                changedEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXLLT_362725');
                changedEventArgs.commons.api.viewState.disable('VA_8723IIAMUFLQPPL_567725');
            }
            /*  if(entities.Group.code){
              changedEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false,          'VC_GROUPEWRVJ_935520', false);
              }*/
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725');
            changedEventArgs.commons.api.viewState.enable('VA_8723IIAMUFLQPPL_567725');
            entities.Group.meetingAddress = null;
        }
    }
};

	//Entity: Group
//Group.hasGroupAccount (CheckBox) View: GroupForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_9596VHOLMQOEFOI_924725 = function(  entities, changedEventArgs ) {
	changedEventArgs.commons.execServer = false;
	/*  if(changedEventArgs.commons.api.parentVc==undefined){
		if(entities.Group.hasGroupAccount==true){
			changedEventArgs.commons.api.viewState.enable('VA_5634HKMSQGZFPUQ_212725');
            changedEventArgs.commons.api.viewState.enable('VA_4103IWRALHJMDZX_523725'); 
            changedEventArgs.commons.api.viewState.enable('VA_1940KQURTPVEVBJ_839725');            
        }else{
         changedEventArgs.commons.api.viewState.disable('VA_5634HKMSQGZFPUQ_212725');
         changedEventArgs.commons.api.viewState.disable('VA_4103IWRALHJMDZX_523725'); 
         changedEventArgs.commons.api.viewState.disable('VA_1940KQURTPVEVBJ_839725'); 
         entities.Group.titular1Name  =null;
         entities.Group.titularClient1  =null;
         entities.Group.titular2Name  =null;
         entities.Group.titularClient2  =null;
         entities.Group.groupAccount  =null;    
        }
    }*/   
};

	//Entity: Group
    //Group. (Button) View: GroupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONPDPCKGB_382725 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Group = true;
		executeCommandEventArgs.commons.serverParameters.Credit = true;
		//executeCommandEventArgs.commons.serverParameters.GroupMember = true;
		executeCommandEventArgs.commons.serverParameters.Amount = true;		
		executeCommandEventArgs.commons.serverParameters.Context = true;  //caso203112 para pantalla de grupos flujo
		executeCommandEventArgs.commons.execServer = true;

    };

	//Start signature to Callback event to VA_VABUTTONPDPCKGB_382725
task.executeCommandCallback.VA_VABUTTONPDPCKGB_382725 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success && entities.Credit.applicationNumber != 0 && entities.Credit.applicationNumber != null) {
        //CABECERA DE PANTALLA       
        executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.Group.code + " - " + entities.Group.nameGroup, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', entities.Credit.creditCode, 1);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', entities.Credit.category, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested == 'null' ? 0 : entities.Credit.amountRequested), 2), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount == 'null' ? 0 : entities.Credit.approvedAmount), 2), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.Credit.term, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.Credit.paymentFrecuency, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Credit.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Credit.officeName), 2);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', entities.Credit.subtype, 2);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado',  entities.Credit.linked, 2);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', entities.Group.cycleNumber, 2);
        LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_HEADERGUOP_223993');
        executeCommandCallbackEventArgs.commons.api.viewState.show('G_HEADERGUOP_223993');
        porcentaje = entities.Credit.percentageWarranty;
        var percentage = LATFO.COMMONS.getPercentage(executeCommandCallbackEventArgs.commons.api.vc.model.Amount.data().map(function (item) {
            return item.authorizedAmount
        }), porcentaje);
        entities.Credit.warrantyAmount = percentage;
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");        
    }
    /* Se recarga el catalogo de oficiales */
    executeCommandCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXNBX_864725');
    executeCommandCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXYVS_120190');
    
    var parentVc = executeCommandCallbackEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
     if (customDialogParameters == null) {
	    if (entities.Group.updateGroup == 'N') {
           executeCommandCallbackEventArgs.commons.api.viewState.disable('VC_GROUPCOMOS_387974');
           //executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_HASLIQUIDGARNFF_564725');
		if(entities.Group.otherPlace==true)
		 {
		 executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725');
         executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_HASLIQUIDGARNFF_564725');
		 }
          executeCommandCallbackEventArgs.commons.messageHandler.showMessagesInformation('LOANS.MSG_LOANS_NOSEPUEOA_20236');//No se Puede Modificar el Grupo si la Solicitud no se Encuentra en la Etapa de Ingreso
        } 
        else
		{
			executeCommandCallbackEventArgs.commons.api.viewState.enable('G_MEMBERIDUM_459848', true);
		}
	}
    // se utiliza para bloquear el campo Incremento de la pantalla de montos
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
    
    if(stage == 'APROBAR'){
      $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
    }
    
    if(requestType != 'R'){
		var i=0;
		for (i = 0; i<entities.Amount.data().length;i++){
			executeCommandCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_6248_19660',entities.Amount.data()[i],'VA_GRIDROWCOMMMDAD_387190');
		}	
	}else{
		$("#QV_6248_19660 col:last-child").width("110px")
		$("#QV_6248_19660 .btn-toolbar a").removeClass("invisible");
	}
    
   /* if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) {
        //Si es renovación ocultar la pantalla de incremento
        if(entities.Group.cycleNumber>1){
             executeCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_6248_19660','proposedMaximumSaving');
        }else{
            executeCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_6248_19660','increment');
    }
}*/ //se comenta para mostrar ambas columnas
    
    //if(type == typeConsulta){
    // task.hideButtonGridMember(executeCommandCallbackEventArgs,'Member','QV_7978_25243');
    //}
};

	//Entity: Group
//Group.officer (ComboBox) View: GroupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TEXTINPUTBOXNBX_864725 = function( loadCatalogDataEventArgs ) {
    loadCatalogDataEventArgs.commons.execServer = true;    
    loadCatalogDataEventArgs.commons.serverParameters.Group = true;
};

	//Entity: Group
    //Group.titular2Name (TextInputButton) View: GroupForm
    
    task.textInputButtonEvent.VA_4103IWRALHJMDZX_523725 = function( textInputButtonEventArgs ) {

     textInputButtonEventArgs.commons.execServer = false;
        titular=2;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: "findCustomer",//idCustomer
            url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ["/customer/services/find-customers-srv.js",
                 //"/customer/services/find-program-srv.js",
                   "/customer/controllers/find-customers-ctrl.js"]
         }];
        
        nav.customDialogParameters = {
        
        };    
    };

	//Entity: Group
    //Group.titular1Name (TextInputButton) View: GroupForm
    
    task.textInputButtonEvent.VA_5634HKMSQGZFPUQ_212725 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        titular=1;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: "findCustomer",
            url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ["/customer/services/find-customers-srv.js",
                 //"/customer/services/find-program-srv.js",
                   "/customer/controllers/find-customers-ctrl.js"]
         }];
        
        nav.customDialogParameters = {
        
        };    
    };

	//Entity: Group
    //Group.titular1Name (TextInputButton) View: GroupForm
    
    task.textInputButtonEventGrid.VA_5634HKMSQGZFPUQ_212725 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

	//MemberQuery Entity: 
    task.executeQuery.Q_MEMBERZI_7978 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//Entity: Member
    //Member. (Button) View: MemberForm
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAA_212848 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
    
//Open Modal
var nav = gridRowCommandEventArgs.commons.api.navigation;

nav.label = 'Relaciones';
nav.address = {
    moduleId: 'CSTMR',
    subModuleId: 'CSTMR',
    taskId: 'T_RELATIONAJNQY_494',
    taskVersion: '1.0.0',
    viewContainerId: 'VC_RELATIONQE_861494'
};
nav.queryParameters = {
    mode: 1
};
nav.modalProperties = {
    size: 'lg',
    callFromGrid: false
};
nav.customDialogParameters = {
    modeRelation:'ModeRelation',
   codigoCli:gridRowCommandEventArgs.rowData.customerId
}

//Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
//nav.openModalWindow(args.commons.controlId, null);
//Si la llamada es desde un evento de un control perteneciente a una grilla de la página
nav.openModalWindow('QV_7978_25243', gridRowCommandEventArgs.modelRow);

    
        
    };

	//Entity: Member
//Member. (ImageButton) View: MemberForm

task.gridRowCommand.VA_GRIDROWCOMMMNNA_977848 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = false;

    var nav = gridRowCommandEventArgs.commons.api.navigation;
    //views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html
    nav.label = 'Mantenimiento de Personas Naturales';
    nav.address = {
        moduleId: 'CSTMR',
        subModuleId: 'CSTMR',
        taskId: 'T_CUSTOMERCOETP_680',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_CUSTOMEROI_208680'
    };
    nav.queryParameters = {
        mode: 9
    };
    nav.modalProperties = {
        size: 'lg',
        height: 900,
        callFromGrid: true
    };
    nav.customDialogParameters = {
        clientId: gridRowCommandEventArgs.rowData.customerId
    };
    //   nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, null);  //Si la llamada es desde un evento de un control 
    nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, gridRowCommandEventArgs.rowData);

};

	//gridRowRendering QueryView: QV_7978_25243
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7978_25243 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','VA_GRIDROWCOMMMNNA_977848');//ocultar lupa
    if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        if (stage == LOANS.CONSTANTS.Stage.INGRESO || stage == LOANS.CONSTANTS.Stage.APROBAR || stage == LOANS.CONSTANTS.Stage.ELIMINAR) {
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'edit');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAA_212848');
            gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla en la etapa de ingreso PXSG
			gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'delete');//Se oculta boton de Eliminar enla etapa de ingreso PXSG
            
        }
        if (stage == 'APROBAR') {
		    gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData,      'delete');
            //ocultar columnas vacias
            gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','VA_GRIDROWCOMMMAAA_212848');
            gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','cmdEdition');
            gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_7978_25243','VA_GRIDROWCOMMMNNA_977848');//mostrar lupa
	   }
    }
};

	//gridRowDeleting QueryView: QV_7978_25243
//Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_7978_25243 = function (entities, gridRowDeletingEventArgs) {
    if (typeOrigin === LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        gridRowDeletingEventArgs.rowData.creditCode =  entities.Credit.creditCode; //gridRowDeletingEventArgs.commons.api.vc.parentVc.model.Task.bussinessInformationIntegerTwo; //se comenta xq se pierde el codigo del credito
    }
    gridRowDeletingEventArgs.rowData.groupId = entities.Group.code;
    gridRowDeletingEventArgs.commons.serverParameters.Member = true;
    gridRowDeletingEventArgs.commons.execServer = true;
};

	//Start signature to Callback event to QV_7978_25243
task.gridRowDeletingCallback.QV_7978_25243 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

	//Entity: Amount
    //Amount.authorizedAmount (TextInputBox) View: AmountForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXLEH_921190 = function(  entities, changedEventArgs ) {
            changedEventArgs.commons.execServer = false;
            
            if (changedEventArgs.newValue > 0) {
                changedEventArgs.rowData.cycleParticipation = 'S'
            }
            else {
                changedEventArgs.rowData.cycleParticipation = 'N'
            }
            
            var percentage = LATFO.COMMONS.getPercentage(changedEventArgs.commons.api.vc.model.Amount.data().map(function(item){return item.authorizedAmount}));                
            entities.Credit.warrantyAmount = percentage;
       changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "authorizedAmount", changedEventArgs.newValue);
        
            // Seccion para el bloqueo de columnas
            
            // Incremento
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
            
            //  Monto Maximo Propuesto 
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
        
           if (stage == 'APROBAR') {
        
                //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            
               changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXYVS_120190');
            
           }
        
      
        
    };

	//Entity: Amount
//Amount.amount (TextInputBox) View: AmountForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXSRP_129190 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.rowData.authorizedAmount = changedEventArgs.rowData.amount;
	if (changedEventArgs.newValue > 0) {
        changedEventArgs.rowData.cycleParticipation = 'S'
    }
    else {
        changedEventArgs.rowData.cycleParticipation = 'N'
    }
    //changedEventArgs.commons.serverParameters.Amount = true;
    var index = $("#QV_6248_19660").data("kendoGrid").dataSource.indexOf(changedEventArgs.rowData);
    var nextRowData = $("#QV_6248_19660").data("kendoGrid").dataSource.data()[index + 1];
    if (nextRowData != undefined) {
        setTimeout(function (argRowData) {
            var control = $("#VA_TEXTINPUTBOXSRP_129190-" + argRowData.secuential);
            var instanceControl = control[0];
            var uiControl = $("#" + instanceControl.id);
            var visibleControl1 = uiControl.siblings("input:visible");
            visibleControl1.focus();
            // visibleControl1.get(0).setSelectionRange(0,0);
        }, 300, nextRowData);
    }
    if(requestType=='R'){
        var result =changedEventArgs.newValue - changedEventArgs.rowData.oldBalance;
        changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "resultAmount", result);    
    }
    //changedEventArgs.commons.api.grid.updateRow("Amount", index, changedEventArgs.rowData);
    changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "amount", changedEventArgs.newValue);
    changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "authorizedAmount", changedEventArgs.newValue);
  
    //Monto maximo propuesto
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    
    //Incremento
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
    
};

	//Entity: Credit
    //Credit. (Button) View: AmountForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONAICSAKZ_975190 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Group = true;
        executeCommandEventArgs.commons.serverParameters.Amount = true;
        executeCommandEventArgs.commons.execServer = true;    
    };

	//Start signature to Callback event to VA_VABUTTONAICSAKZ_975190
task.executeCommandCallback.VA_VABUTTONAICSAKZ_975190 = function(entities, executeCommandCallbackEventArgs) {
 if (stage == 'APROBAR') {
        
                //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            
            
           }      
};

	//Entity: Credit
//Credit. (Button) View: AmountForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONGPPUIHN_830190 = function (entities, executeCommandEventArgs) {
    if ((executeCommandEventArgs.commons.api.parentVc.model.Task.taskSubject == 'INGRESAR SOLICITUD') && (entities.Credit.creditCode > 0 )) {
        entities.Credit.nameActivity = nameActivity;
        executeCommandEventArgs.commons.serverParameters.Credit = true;
        executeCommandEventArgs.commons.execServer = true;
    }
    else {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError("LOANS.LBL_LOANS_NOSEPUEUN_82756")
    }    
};

	//Entity: Credit
//Credit. (Button) View: AmountForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommandCallback.VA_VABUTTONGPPUIHN_830190 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success == true) {
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VC_PXLAAVTEYF_485974', true);
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXLEH_921190']").prop("disabled", "disabled");
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXUPR_288190']").prop("disabled", "disabled");
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    }
};

	//Entity: Credit
    //Credit. (Button) View: AmountForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONNPVXIJW_123190 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Amount = true;
        executeCommandEventArgs.commons.serverParameters.Group = true;
        executeCommandEventArgs.commons.serverParameters.Credit = true;        
        executeCommandEventArgs.commons.execServer = true;
    };

	//Start signature to Callback event to VA_VABUTTONNPVXIJW_123190
task.executeCommandCallback.VA_VABUTTONNPVXIJW_123190 = function(entities, executeCommandCallbackEventArgs) {
	if (executeCommandCallbackEventArgs.success == true ){ //**ACHP
        
        var percentage = LATFO.COMMONS.getPercentage(executeCommandCallbackEventArgs.commons.api.vc.model.Amount.data()
                                                 .map(function(item){return item.authorizedAmount}), porcentaje);         
        entities.Credit.warrantyAmount = percentage;
        
	    executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**ACHP
		LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested  == 'null' ? 0 : entities.Credit.amountRequested ), 2), 1);
    	LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount  == 'null' ? 0 : entities.Credit.approvedAmount ), 2), 1);	
	}else{
		executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //para que no vaya con cualquier monto, si se vuelve a ejecutar con datos incorrectos
	}
	//Monto maximo propuesto
	$("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    //Incremento
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
     //MontoSolicitado
	if(stage=='APROBAR'){
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
	}
};

	//AmountQuery Entity: 
    task.executeQuery.Q_AMOUNTKL_6248 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	task.gridInitColumnTemplate.QV_6248_19660 = function(idColumn, gridInitColumnTemplateEventArgs) {
    if (angular.isDefined(gridInitColumnTemplateEventArgs.commons.api.vc.parentVc)) {
        stage = gridInitColumnTemplateEventArgs.commons.api.vc.parentVc.customDialogParameters.Task.urlParams.Etapa;
    } else {
        stage = "";
    }
    if (idColumn == 'creditBureau') {
        return "<div class='cb-indicator cb-flex cb-column'>" +
            "<div class='cb-flex cb-grow cb-center cb-middle cb-indicator-value'>{{dataItem.creditBureau}}</div>" +
            "<div ng-show='{{dataItem.riskLevel == \"VERDE\"}}' style='background-color:green;height:3px;'></div>" +
            "<div ng-show='{{dataItem.riskLevel == \"AMARILLO\"}}' style='background-color:yellow;height:3px;'></div>" +
            "<div ng-show='{{dataItem.riskLevel == \"ROJO\"}}' style='background-color:red;height:3px;'></div>" +
            "<div class='cb-footer-label'>{{'LOANS.LBL_LOANS_NIVELDERI_38662'|translate}}</div>" +
            "</div>";
    }

   
    if (idColumn == 'amount' && stage != 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.amount\" id=\"VA_TEXTINPUTBOXSRP_129190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.amount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.amount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.amount.decimals\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'amount')\" tabindex=\"10000\"></input>";
    } else if (idColumn == 'amount' && stage == 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.amount\"  disabled=\"disabled\" id=\"VA_TEXTINPUTBOXSRP_129190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.amount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.amount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.amount.decimals\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'amount')\" tabindex=\"10000\"></input>";
    }


    if (idColumn == 'authorizedAmount' && stage != 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.authorizedAmount\" id=\"VA_TEXTINPUTBOXLEH_921190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.authorizedAmount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.authorizedAmount.decimals\"  k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'authorizedAmount')\"></input>";
    } else if (idColumn == 'authorizedAmount' && stage == 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.authorizedAmount\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXLEH_921190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.authorizedAmount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.authorizedAmount.decimals\"  k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'authorizedAmount')\"></input>";
    }

    if (idColumn == 'voluntarySavings' && (stage != 'CONSULTA' && stage != 'APROBAR')) {
        return "<input type=\"text\" ng-model=\"dataItem.voluntarySavings\" id=\"VA_TEXTINPUTBOXUPR_288190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.voluntarySavings.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.voluntarySavings.decimals\" ></input>";
    } else if (idColumn == 'voluntarySavings' && (stage == 'CONSULTA' || stage == 'APROBAR')) {
        return "<input type=\"text\" ng-model=\"dataItem.voluntarySavings\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXUPR_288190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.voluntarySavings.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.voluntarySavings.decimals\" ></input>";
    }

    if (idColumn == 'proposedMaximumSaving') {
        return "<input type=\"text\" ng-model=\"dataItem.proposedMaximumSaving\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXWXN_691190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.proposedMaximumSaving.decimals\" ></input>";
    }
    //if(idColumn == 'NombreColumna'){
    //  return  "#=nombreColumna#" ;
    //}  
    if (idColumn == 'increment') {
        return "<input type=\"text\" ng-model=\"dataItem.increment\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXAFW_332190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.increment.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.increment.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.increment.decimals\" ></input>";
    }

    if (idColumn === 'safePackage' && stage == 'APROBAR') {
        cobis.showMessageWindow.loading(true);
        return "<input id=\"VA_TEXTINPUTBOXYVS_120190\" kendo-ext-combo-box=\"comboBox.VA_TEXTINPUTBOXYVS_120190\" k-data-source=\"vc.catalogs.VA_TEXTINPUTBOXYVS_120190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.safePackage.validationCode}}\" ng-model=\"dataItem.safePackage\"  k-auto-bind=\"true\" k-ng-delay=\"vc.afterInitData\"  k-data-text-field=\"'value'\" k-data-value-field=\"'code'\" k-index=0 />";

    }


};

	task.gridInitEditColumnTemplate.QV_6248_19660 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

	//Entity: Amount
    //Amount. (Button) View: AmountForm
    
    task.gridRowCommand.VA_GRIDROWCOMMMDAD_387190 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
    
        //Open Modal
        var nav = gridRowCommandEventArgs.commons.api.navigation;

        nav.label = 'Tabla de Amortizacion';
        nav.address = {
        moduleId: 'LOANS',
        subModuleId: 'GROUP',
        taskId: 'T_LOANSKVAEOTPS_336',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_AMORTIZAAT_297336'
        };
        nav.queryParameters = {
        mode: 1
        };
        nav.modalProperties = {
        size: 'md',
        height: 450,
        callFromGrid: false
        };
        nav.customDialogParameters = {
            operation: gridRowCommandEventArgs.rowData.oldOperation
        };

        //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
        //nav.openModalWindow(args.commons.controlId, null);
        //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
        nav.openModalWindow('VA_GRIDROWCOMMMDAD_387190', gridRowCommandEventArgs.rowData);

    };

	//Entity: Amount
//Amount.safePackage (ComboBox) View: AmountForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TEXTINPUTBOXYVS_120190 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.Amount = true;
};



}));