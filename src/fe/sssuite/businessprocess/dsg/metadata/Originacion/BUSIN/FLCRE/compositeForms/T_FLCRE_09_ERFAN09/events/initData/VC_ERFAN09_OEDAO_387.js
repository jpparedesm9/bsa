//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: CustomerDataVerification
    task.initData.VC_ERFAN09_OEDAO_387 = function (entities, initDataEventArgs){
         var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
     	var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.UserL=userL;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;			
		entities.myParameters ={
			isProrroga : initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.bussinessInformationStringTwo=='P'?true:false,
			lineNumber : initDataEventArgs.commons.api.parentVc.customDialogParameters.Task.bussinessInformationStringOne
		}
        
    };