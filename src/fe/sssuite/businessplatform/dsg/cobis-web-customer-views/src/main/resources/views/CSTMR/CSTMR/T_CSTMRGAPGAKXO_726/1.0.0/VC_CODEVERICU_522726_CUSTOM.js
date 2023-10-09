/* variables locales de T_CSTMRGAPGAKXO_726*/
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

    
        var task = designerEvents.api.codeverificationpopupform;
    

    //"TaskId": "T_CSTMRGAPGAKXO_726"


    //Entity: CodeVerification
    //CodeVerification. (Button) View: CodeVerificationPopupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONLWVBSLQ_895339 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.CodeVerification = true;
    };

//Start signature to Callback event to VA_VABUTTONLWVBSLQ_895339
task.executeCommandCallback.VA_VABUTTONLWVBSLQ_895339 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONSQJVHTN_888339');
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONLWVBSLQ_895339');
    }
};

//Entity: CodeVerification
    //CodeVerification. (Button) View: CodeVerificationPopupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONSQJVHTN_888339 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.CodeVerification = true;
    };

//Start signature to Callback event to VA_VABUTTONSQJVHTN_888339
task.executeCommandCallback.VA_VABUTTONSQJVHTN_888339 = function(entities, executeCommandCallbackEventArgs) {
    
    if(executeCommandCallbackEventArgs.success){
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            /*resultArgs: {
                mode: executeCommandEventArgs.commons.api.vc.mode,
                accountIndividual: entities.AltairAccount.oldAccountIndividual}*/
        });
    } else {
        if(entities.CodeVerification.failureCounter == 3){
            executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONLWVBSLQ_895339');
            executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONSQJVHTN_888339');
            entities.CodeVerification.failureCounter = 0;
            entities.CodeVerification.code = null;
        }
    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: CodeVerificationPopupForm
    task.initData.VC_CODEVERICU_522726 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        var args = initDataEventArgs;
        
        args.commons.api.viewState.disable('VA_VABUTTONLWVBSLQ_895339');
        entities.CodeVerification.cstmrCode = args.commons.api.vc.customDialogParameters.cstmrCode;
        entities.CodeVerification.phoneNumber = args.commons.api.vc.customDialogParameters.phoneNumber;
        entities.CodeVerification.valType = args.commons.api.vc.customDialogParameters.valType;
        entities.CodeVerification.addressId = args.commons.api.vc.customDialogParameters.addressId;

		if (entities.CodeVerification.valType === 'MAIL') {
		    initDataEventArgs.commons.api.viewState.label('VA_VASIMPLELABELLL_645339','CSTMR.LBL_CSTMR_PORFAVOAO_33991');
		    initDataEventArgs.commons.api.viewState.label('VA_VASIMPLELABELLL_632339','CSTMR.LBL_CSTMR_INGRESAIO_56926');
		}
        
        
    };

//Start signature to Callback event to VC_CODEVERICU_522726
task.initDataCallback.VC_CODEVERICU_522726 = function(entities, initDataCallbackEventArgs) {
//here your code
};



}));