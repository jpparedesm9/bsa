// (Button) 
task.executeCommandCallback.CM_TBUSINSF_SSU = function (entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.execServer = false;
		var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
		if(entities.Context.enable === 'N'){
			/*var ctrs = ['CM_TBUSINSF_3N8', 'CM_TBUSINSF_SSU'] -- Se habilita por bug B139427 Spring20*/
		    var ctrs = ['CM_TBUSINSF_3N8']
			BUSIN.API.disable(viewState, ctrs);
			entities.Context.enable = 'N' // Al dar clic debe bloquerse todo el cuestionario
			//angular.element('#VC_DATAVERION_567496').scope().vc.model.QuestionsPartThree.enableView=12;
		}      
    };