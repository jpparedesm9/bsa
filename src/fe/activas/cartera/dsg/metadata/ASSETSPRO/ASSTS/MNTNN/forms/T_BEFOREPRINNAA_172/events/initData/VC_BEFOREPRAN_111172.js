//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BeforePrintPaymentForm
    task.initData.VC_BEFOREPRAN_111172 = function (entities, initDataEventArgs){
		initDataEventArgs.commons.execServer = true;
		var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.loanInstancia;
		commons.execServer = true;        
    };