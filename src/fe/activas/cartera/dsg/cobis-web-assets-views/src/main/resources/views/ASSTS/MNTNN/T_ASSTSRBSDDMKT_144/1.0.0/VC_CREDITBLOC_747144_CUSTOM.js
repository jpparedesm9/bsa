
/* variables locales de T_ASSTSRBSDDMKT_144*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_ASSTSASCRBCKE_501*/

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

    
        var task = designerEvents.api.creditblockcomposite;
    

    //"TaskId": "T_ASSTSRBSDDMKT_144"
task.loadFields = function(entities, args){

    var block = entities.Block;
    
    block.disbursementDate = kendo.toString((block.disbursementDate), cobis.containerScope.preferences.dateFormat);
    block.expirationDate = kendo.toString((block.expirationDate), cobis.containerScope.preferences.dateFormat);
    block.dateLastUpdate = kendo.toString((block.dateLastUpdate), cobis.containerScope.preferences.dateFormat);
    block.customerId = kendo.toString((block.customerId), "############");
    
    if (block.blocked == 'S'){
     args.commons.api.viewState.label("CM_TASSTSRB_N1N", 'ASSTS.LBL_ASSTS_DESBLOQUE_43117'); 
    }else{
     args.commons.api.viewState.label("CM_TASSTSRB_N1N", 'ASSTS.LBL_ASSTS_BLOQUEARR_90407');
    }
    
    if (block.active == 'N'){
        args.commons.api.viewState.disable("CM_TASSTSRB_N1N");
    }
};
    

    	// (Button) 
    task.executeCommand.CM_TASSTSRB_N1N = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Start signature to Callback event to CM_TASSTSRB_N1N
task.executeCommandCallback.CM_TASSTSRB_N1N = function(entities, executeCommandCallbackEventArgs) {
      
    task.loadFields(entities, executeCommandCallbackEventArgs);
};

	// (Button) 
    task.executeCommand.CM_TASSTSRB_NMS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	// (Button) 
    task.executeCommand.CM_TASSTSRB_SSS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Start signature to Callback event to CM_TASSTSRB_SSS
task.executeCommandCallback.CM_TASSTSRB_SSS = function(entities, executeCommandCallbackEventArgs) {
//here your code
};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: CreditBlockComposite
    task.initData.VC_CREDITBLOC_747144 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;	
    };

	//Start signature to Callback event to VC_CREDITBLOC_747144
task.initDataCallback.VC_CREDITBLOC_747144 = function(entities, initDataCallbackEventArgs) {

    task.loadFields(entities, initDataCallbackEventArgs);
    if(entities.Block.enabledAut=='S'){
        initDataCallbackEventArgs.commons.api.viewState.enable("CM_TASSTSRB_NMS");
    }else{
        initDataCallbackEventArgs.commons.api.viewState.disable("CM_TASSTSRB_NMS");
    }
};

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CreditBlockComposite
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
         ASSETS.Header.setDataStyle("VC_CREDITBLOC_747144","VC_EXWPOQOCGB_614144",entities, renderEventArgs); 
              
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
     try{
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.api.vc.closeDialog();
            var subModuleId = "CMMNS",
            taskId = "T_LOANSEARCHSWA_959",
            vcId = "VC_LOANSEARHC_144959",
            parameters = '', 
            label = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_BSQUEDASS_55923');
            ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);
     }
    catch(err){
        ASSETS.Utils.managerException(err);
    }
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONWVITZRQ_108612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
         ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
         return true;
    };



}));