//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: REAJUSTE
    task.initData.VC_REAJUSTEKP_207872 = function (entities, initDataEventArgs){
        try{
	       var commons = initDataEventArgs.commons;
	       var api=initDataEventArgs.commons.api;
           var parameters=api.navigation.getCustomDialogParameters();		
           entities.LoanInstancia = parameters.parameters.loanInstancia;
	       commons.execServer = true; 
        } catch(err){
			ASSETS.Utils.managerException(err);
        }
        
    };