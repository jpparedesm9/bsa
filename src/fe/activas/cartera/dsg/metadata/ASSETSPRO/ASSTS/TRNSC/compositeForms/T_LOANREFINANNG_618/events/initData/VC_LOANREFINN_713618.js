//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanRefinancing
    task.initData.VC_LOANREFINN_713618 = function (entities, initDataEventArgs){
        	initDataEventArgs.commons.execServer = true;        
        var commons = initDataEventArgs.commons;
        var api=initDataEventArgs.commons.api;
		var parentVc=api.parentVc;
        var parameters=api.navigation.getCustomDialogParameters();        
        entities.LoanInstancia = parameters.parameters.loanInstancia;		
		 
		if(parameters.parameters!=undefined){
			screenCall = parameters.parameters.screenCall;
			if(screenCall=='payment'){			
				parentVc.closeDialog();				
			}		
		}
        commons.execServer = true;;
    };