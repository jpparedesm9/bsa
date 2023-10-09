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