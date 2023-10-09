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