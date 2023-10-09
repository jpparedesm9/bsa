//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: DataVerificationQuestionsCompound
    task.render = function (entities, renderEventArgs){
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = renderEventArgs.commons.api.viewState;
        var api = renderEventArgs.commons.api;
        var customDialogParameters = renderEventArgs.commons.api.vc.parentVc.customDialogParameters;
        typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
        
        renderEventArgs.commons.execServer = false;
        
        // Modo Consulta
		task.showButtons(renderEventArgs);
		// Se comenta todo porque siempre debe que estar oculto		
		var ctrs = ['CM_TBUSINSF_3N8']
		BUSIN.API.hide(viewState, ctrs);
		
		var ctrsEna = ['CM_TBUSINSF_SSU'] /*-- Se habilita por bug B139427 Spring20*/
		BUSIN.API.enable(viewState, ctrsEna);
		/*	
		var grid = renderEventArgs.commons.api.grid;
		if (entities.Context.enable === 'N') {
		    var ctrs = ['CM_TBUSINSF_3N8', 'CM_TBUSINSF_SSU']
		    BUSIN.API.disable(viewState, ctrs);
		} else if (entities.Context.enable === 'S' && entities.Context.synchronize === 'N') {
		    var ctrs = ['CM_TBUSINSF_SSU']
		    BUSIN.API.disable(viewState, ctrs);
		} else if (entities.Context.enable === 'S' && entities.Context.synchronize === 'S') {
		    var ctrs = ['CM_TBUSINSF_SSU']
		    BUSIN.API.enable(viewState, ctrs);
		}*/
    };