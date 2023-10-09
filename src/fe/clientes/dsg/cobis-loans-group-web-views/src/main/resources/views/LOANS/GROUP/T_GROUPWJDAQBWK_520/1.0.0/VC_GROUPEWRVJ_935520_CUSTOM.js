/* variables locales de T_GROUPWJDAQBWK_520*/
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

    
        var task = designerEvents.api.groupform;
    

    //"TaskId": "T_GROUPWJDAQBWK_520"


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

//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
    //ViewContainer: GroupForm
    task.changeGroup.VC_GROUPEWRVJ_935520 = function (entities, changeGroupEventArgs){
        changeGroupEventArgs.commons.execServer = false;
        
    };

//Entity: Group
    //Group. (Button) View: GroupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONPDPCKGB_382725 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Group = true;
		executeCommandEventArgs.commons.serverParameters.Credit = true;
		//executeCommandEventArgs.commons.serverParameters.GroupMember = true;
		executeCommandEventArgs.commons.serverParameters.Amount = true;
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
    var parentVc = executeCommandCallbackEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    if (customDialogParameters != null) {
        if (customDialogParameters.Task.urlParams.Etapa == 'CONSULTA') {
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXLEH_921190']").prop("disabled", "disabled");
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXUPR_288190']").prop("disabled", "disabled");
        }
    }
     if (customDialogParameters == null) {
	    if (entities.Group.updateGroup == 'N') {
           executeCommandCallbackEventArgs.commons.api.viewState.disable('VC_GROUPCOMOS_387974');
           executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_HASLIQUIDGARNFF_564725');
		if(entities.Group.otherPlace==true)
		 {
		 executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725');
         executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_HASLIQUIDGARNFF_564725');
		 }
        } 
	}
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



}));