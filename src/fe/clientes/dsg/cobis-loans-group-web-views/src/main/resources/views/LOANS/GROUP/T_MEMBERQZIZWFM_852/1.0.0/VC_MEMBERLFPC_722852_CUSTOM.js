/* variables locales de T_MEMBERQZIZWFM_852*/
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

    
        var task = designerEvents.api.memberpoppupform;
    

    //"TaskId": "T_MEMBERQZIZWFM_852"
var mode;
var groupId = '';
var otherPLaces=null;
var individualAccount=null;
var DireccionIntegrante=null;
var typeOrigin = '';
task.findValueInCatalog = function (code, data) {
    if (code == null) {
        return null;
    }
    else {
        code = code.toString();
    }
    for (var i = 0; i < data.length; i++) {
        if (data[i].code == code) {
            return data[i].value;
        }
    }
    return null;
};

    //Entity: Member
    //Member. (Button) View: MemberPopPupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONTPUAZVF_333132 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.Member = true;
    };

//Entity: Member
    //Member. (Button) View: MemberPopPupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONTPUAZVF_333132 = function(  entities, executeCommandCallbackEventArgs ) {

    executeCommandCallbackEventArgs.commons.execServer = false;
    
        
    };

//Entity: Member
//Member. (Button) View: MemberPopPupForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONXYNUHPG_895132 = function (entities, executeCommandEventArgs) {
    var catalogs = executeCommandEventArgs.commons.api.vc.catalogs;
    individualAccount = executeCommandEventArgs.commons.api.vc.parentVc.model.Group.hasIndividualAccount; //comentadao
    //executeCommandEventArgs.commons.constants.mode 

	if(entities.Member.membershipDate === null || entities.Member.membershipDate === undefined){
		executeCommandEventArgs.commons.messageHandler.showMessagesError("LOANS.LBL_LOANS_LAFECHAEL_59329");
        executeCommandEventArgs.commons.execServer = false;
	}else{
        if (executeCommandEventArgs.commons.constants.mode.Insert === mode) {
            entities.Member.operation = 'I';
        }
        else if (executeCommandEventArgs.commons.constants.mode.Update === mode) {
            entities.Member.operation = 'U';
        }
        else if (executeCommandEventArgs.commons.constants.mode.Delete === mode) {
            entities.Member.operation = 'D';
        }
        entities.Member.groupId = groupId;
        entities.Member.role = task.findValueInCatalog(entities.Member.roleId, catalogs.VA_TEXTINPUTBOXHYH_612132.data());
        entities.Member.state = task.findValueInCatalog(entities.Member.stateId, catalogs.VA_TEXTINPUTBOXAIN_291132.data());
        // entities.Member.qualification=task.findValueInCatalog(entities.Member.qualificationId, catalogs.VA_TEXTINPUTBOXKTO_991132.data());
        entities.Member.qualification = entities.Member.qualificationId;
        if (typeOrigin === LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
            entities.Member.creditCode = executeCommandEventArgs.commons.api.vc.parentVc.model.Credit.creditCode;
        }
        executeCommandEventArgs.commons.serverParameters.Member = true;
        executeCommandEventArgs.commons.execServer = true;	
	}
};

//Start signature to Callback event to VA_VABUTTONXYNUHPG_895132
task.executeCommandCallback.VA_VABUTTONXYNUHPG_895132 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        var resultArgs = {
            index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex
            , mode: executeCommandCallbackEventArgs.commons.api.vc.mode
            , data: entities.Member
            , addRow: 'S'
        }
        executeCommandCallbackEventArgs.commons.api.navigation.closeModal({
            response: resultArgs
        });
    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: MemberPopPupForm
task.initData.VC_MEMBERLFPC_722852 = function (entities, initDataEventArgs) {
    var parentVc = initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;    
    //Pantalla desde el inbox
    if (customDialogParameters != null) {
        //Parametros
        typeOrigin = LOANS.CONSTANTS.TypeOrigin.FLUJO;        
    }
    
    
    
    otherPLaces = initDataEventArgs.commons.api.vc.parentVc.model.Group.otherPlace;
    individualAccount = initDataEventArgs.commons.api.vc.parentVc.model.Group.hasIndividualAccount;
    entities.Member.hasIndividualAccountAux = individualAccount;
    DireccionIntegrante = initDataEventArgs.commons.api.vc.parentVc.model.Group.addressMember;
    groupId = initDataEventArgs.commons.api.vc.parentVc.model.Group.code;
    entities.Member.groupId=initDataEventArgs.commons.api.vc.parentVc.model.Group.code;
    //desabilito el campo nivel de riesgo
   initDataEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXKTO_991132');
    mode = initDataEventArgs.commons.api.vc.mode;
    if (otherPLaces == true) {
        initDataEventArgs.commons.api.viewState.disable('VA_9339JAGVFZSMRSA_972132');
    }
    else {
        initDataEventArgs.commons.api.viewState.enable('VA_9339JAGVFZSMRSA_972132');
    }
   /* if (individualAccount == true) {
        initDataEventArgs.commons.api.viewState.enable('VA_8316ZNUUMBGIZYL_525132');
    }
    else {
        initDataEventArgs.commons.api.viewState.disable('VA_9339JAGVFZSMRSA_972132');
    }*/
    if (DireccionIntegrante == true) {
        initDataEventArgs.commons.api.viewState.enable('VA_9339JAGVFZSMRSA_972132');
    }
    else {
        initDataEventArgs.commons.api.viewState.disable('VA_9339JAGVFZSMRSA_972132');
    }        
    //desabilitar campo en el init data
    initDataEventArgs.commons.api.viewState.disable('VA_NUMBERCYCLEPSSU_968132');
    
    initDataEventArgs.commons.serverParameters.Member = true;
    initDataEventArgs.commons.execServer = true;
};

//Entity: Member
    //Member.customer (TextInputButton) View: MemberPopPupForm
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXOKY_519132 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
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

    task.closeModalEvent.findCustomer = function (args) {        
        var resp = args.commons.api.vc.dialogParameters;
		var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
		var CustomerName=  args.commons.api.vc.dialogParameters.customerType ==='C'?args.commons.api.vc.dialogParameters.commercialName:args.commons.api.vc.dialogParameters.name;
		var identification= args.commons.api.vc.dialogParameters.documentId;
		args.model.Member.customer  = customerCode +"-"+ CustomerName;
		args.model.Member.customerId  = customerCode; 
        //args.model.Member.qualification='AMARILLO'
        args.commons.api.vc.executeCommand('VA_VABUTTONTPUAZVF_333132', 'FindCustomer', undefined, true, false, 'VC_MEMBERLFPC_722852', false);
     
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: MemberPopPupForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        var viewState = renderEventArgs.commons.api.viewState;
        if(mode===renderEventArgs.commons.constants.mode.Insert){
            viewState.disable('VA_TEXTINPUTBOXAIN_291132',true);			
        }else if(mode===renderEventArgs.commons.constants.mode.Update){
			viewState.disable('VA_TEXTINPUTBOXOKY_519132',true);
		}
        
        
    };



}));