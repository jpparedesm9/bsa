//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: OperationSearch
    task.initData.VC_OSRCH32_AOEAR_233 = function(entities, initDataEventArgs) {
    	
    	//Entidad Temporal
    	entities.Operations = {} ;
    	
    	//Recupero datos enviado por parametros
    	var customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
    	var task=initDataEventArgs.commons.api.parentVc.parentVc.customDialogParameters;
    	//Verifico si tiene el cliente
    	if (customDialogParameters != null && customDialogParameters.debtor != null) {
    		
        	var debtor =  customDialogParameters.debtor;
        	entities.Operations =  customDialogParameters.operations;
			var generalParameters = customDialogParameters.generalParameters;
			entities.generalData = customDialogParameters.generalParameters;
        	
        	if(debtor != null && debtor.Role=="D") {
        		entities.CustomerSearch.CustomerId = debtor.CustomerCode;
        		entities.CustomerSearch.Customer = debtor.CustomerName;
				if (generalParameters.enableSearchClients != undefined && generalParameters.enableSearchClients == false){
					initDataEventArgs.commons.api.viewState.disable("VA_TOMERSHVIW6014_CSER255");
				}else{
					initDataEventArgs.commons.api.viewState.enable("VA_TOMERSHVIW6014_CSER255");
				}
        		initDataEventArgs.commons.execServer = true;
    		} else {
    			initDataEventArgs.commons.execServer = false;
    		}
		} else {
			initDataEventArgs.commons.execServer = false;
		}
    	
    };