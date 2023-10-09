//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanRefinancing
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		var  api = renderEventArgs.commons.api;    
		if(entities.RefinanceLoans.data().length != 0 ){		
			try{
				ASSETS.Header. setDataStyle ("VC_LOANREFINN_713618", "VC_AUCLUAIEKU_127618", entities, renderEventArgs);
				var api=renderEventArgs.commons.api;

	
				var msg_default = api.viewState.translate('ASSTS.MSG_ASSTS_RENOVAPRE_12304'); 				
				var msg_sta = api.viewState.translate('ASSTS.MSG_ASSTS_RENOVAPRE_12305'); 
				var msg_end = api.viewState.translate('ASSTS.MSG_ASSTS_RENOVAPRE_12306'); 
				if (entities.RefinanceDetailLoans.observations == ""){
					entities.RefinanceDetailLoans.observations = msg_default;
				}
				else {
					entities.RefinanceDetailLoans.observations = msg_sta + entities.RefinanceDetailLoans.observations + msg_end;
				}
				
			}
			catch(err){
				alert(err.message);
			}          
		}	
        
    };