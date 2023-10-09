//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_SUMNF62_FXUSN_876 = function(entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters; 
		entities.LoanHeader.Operation = 701;//parentParameters.Task.processInstanceIdentifier;
		
		//Obteniendo cliente del inbox
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.LoanHeader.Customer = client.clientName;
		entities.LoanHeader.CustomerId = client.clientId;

		//entities.LoanHeader.Operation=253;
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_PTTP830");
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_CURR863");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UOBU373"); 
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_FFIE451"); 
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UOBU373");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UUNT712");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_USMR660");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_PIQO508");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_OMUT564");
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_IIAT392");	 
		initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_IIAT392"); 
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_ATBS598");	
        initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_BAIO267");		
		
		
		//initDataEventArgs.commons.api.viewState.addStyle('QV_TSRSE1342_26', 'grupo-lectura');
		//DESEMBOLSO BAJO LINEA CREDITO
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' && 
		    client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' ){
			entities.LoanHeader.NumberLine = client.bussinessInformationStringOne;						
			BUSIN.API.show(initDataEventArgs.commons.api.viewState , ['VA_DISURMETFR5106_UERE335']);
			initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UERE335");
		}
		initDataEventArgs.commons.execServer = true;	
    };