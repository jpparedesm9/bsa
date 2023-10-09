//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TPunishmentPlan
    task.initData.VC_PUSEN31_TIMNT_481 = function (entities, initDataEventArgs){
        entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		entities.generalData.vinculado="";
		entities.generalData.symbolCurrency="";
		entities.generalData.sectorNeg=" ";
		entities.generalData.loanType="";
		
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.HeaderPunishment.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.HeaderPunishment.Agency = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.HeaderPunishment.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);		

		if(parentParameters.Task.bussinessInformationStringOne !== undefined &&parentParameters.Task.bussinessInformationStringOne !== '' && parentParameters.Task.bussinessInformationStringOne !== null){
			entities.HeaderPunishment.NumberOperation = parentParameters.Task.bussinessInformationStringOne;
		}
		if(parentParameters.Task.bussinessInformationIntegerOne !== undefined &&parentParameters.Task.bussinessInformationIntegerOne !== '' && parentParameters.Task.bussinessInformationIntegerOne !== null){
			entities.HeaderPunishment.CustomerId = parentParameters.Task.bussinessInformationIntegerOne;
		}
		if(parentParameters.Task.urlParams.Etapa != null && parentParameters.Task.urlParams.Etapa !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.ETAPA;
		}		
    };