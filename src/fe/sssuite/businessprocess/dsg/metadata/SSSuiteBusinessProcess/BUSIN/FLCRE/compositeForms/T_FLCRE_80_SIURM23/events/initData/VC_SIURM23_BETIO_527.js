//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TaskDisbursementFormExecution
    task.initData.VC_SIURM23_BETIO_527 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = true;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.LoanHeader.Operation = parentParameters.Task.processInstanceIdentifier;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.officerName = "";
		entities.LoanHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;

		//Obteniendo cliente del inbox
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.LoanHeader.Customer = client.clientName;
		entities.LoanHeader.CustomerId = client.clientId;
			
		//initDataEventArgs.commons.api.viewState.label('VA_DISURMETFR5106_OAIO459', 'BUSIN.DLB_BUSIN_OPEIONBER_32159', false);		
		//DESEMBOLSO BAJO LINEA CREDITO
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' &&
		    client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' ){
			entities.LoanHeader.NumberLine = client.bussinessInformationStringOne;
			BUSIN.API.show(initDataEventArgs.commons.api.viewState , ['VA_DISURMETFR5106_UERE335']);
			initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UERE335");
		}
    };