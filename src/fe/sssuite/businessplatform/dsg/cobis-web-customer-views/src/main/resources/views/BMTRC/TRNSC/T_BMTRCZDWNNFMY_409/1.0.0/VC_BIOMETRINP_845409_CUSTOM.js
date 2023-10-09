/* variables locales de T_BMTRCZDWNNFMY_409*/
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

    
        var task = designerEvents.api.biometricfingerprints;
    

    //"TaskId": "T_BMTRCZDWNNFMY_409"


    // (Button) 
    task.executeCommand.VA_VABUTTONRKQKGKO_888166 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    executeCommandEventArgs.commons.api.vc.closeModal("");
    
        
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: BiometricFingerprints
task.initData.VC_BIOMETRINP_845409 = function (entities, initDataEventArgs) {
	initDataEventArgs.commons.execServer = false;
	initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONRKQKGKO_888166');
	
    /*$("#G_FINVENTCYS_628365").find('div.form-vertical').css({
    "height": "30px",
    "margin-bottom": "0px"
    });*/
    
	var args = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().grid;
	var entidad = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().entities.AdditionalInformation.environment;
	console.log("antes de llamar al sevicio de bicheck");

	BMTRC.SERVICES.BIOCHECK.validateBiocheck(args, entidad, localIp,initDataEventArgs);
};



}));