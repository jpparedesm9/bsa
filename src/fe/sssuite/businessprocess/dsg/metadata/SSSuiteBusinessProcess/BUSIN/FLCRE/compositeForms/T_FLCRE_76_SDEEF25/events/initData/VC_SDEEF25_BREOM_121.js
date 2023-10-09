//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: taskDisbursementForm
    task.initData.VC_SDEEF25_BREOM_121 = function(entities, initDataEventArgs) {	
        entities.LoanHeader.OfficeId = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.LoanHeader.ProcessNumber = parentParameters.Task.processInstanceIdentifier;
		var parentApi = initDataEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		//Obteniendo cliente del inbox
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";		
		entities.generalData.officerName = "";
		entities.LoanHeader.Customer = client.clientName;
		entities.LoanHeader.CustomerId = client.clientId;
        typeRequest = parentParameters.Task.urlParams.SOLICITUD;

		//DESEMBOLSO BAJO LINEA CREDITO
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' &&
		    client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' ){
			entities.LoanHeader.NumberLine = client.bussinessInformationStringOne;						
		}
		initDataEventArgs.commons.execServer = true;
		
		if(parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined){
			task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
		}
		if(parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined){
			task.Etapa = parentParameters.Task.urlParams.ETAPA;
		}
    };