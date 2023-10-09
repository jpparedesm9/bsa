//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QueryGeneralInformationMain
    task.initData.VC_GENERALITN_743443 = function (entities, initDataEventArgs){
        var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;
        entities.LoanInstancia.groupSummary=parameters.parameters.groupSummary;
		commons.execServer = true;		
        
    };