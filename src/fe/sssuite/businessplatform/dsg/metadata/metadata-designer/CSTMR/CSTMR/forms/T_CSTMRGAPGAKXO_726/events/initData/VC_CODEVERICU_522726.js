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