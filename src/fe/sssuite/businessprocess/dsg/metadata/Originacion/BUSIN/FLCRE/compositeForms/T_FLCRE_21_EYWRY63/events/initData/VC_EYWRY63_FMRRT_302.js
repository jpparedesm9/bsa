//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: EntryWarranty
    task.initData.VC_EYWRY63_FMRRT_302 = function (entities, initDataEventArgs){
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;	
		
		//Creacion de entidad temporal para enviar el id del cliente
		entities.EntityClient = {clientId : initDataEventArgs.commons.api.parentVc.model.Task.clientId};
		
		initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
			initDataEventArgs.commons.api.vc.executeCommand('CM_EYWRY63SOA19','Associate', undefined, true, false, 'VC_EYWRY63_FMRRT_302', false);
		}
        
    };