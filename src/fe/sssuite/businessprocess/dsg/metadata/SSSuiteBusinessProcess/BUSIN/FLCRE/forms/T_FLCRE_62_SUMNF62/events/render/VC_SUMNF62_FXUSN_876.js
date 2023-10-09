//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: [object Object]
    task.render = function(entities, renderEventArgs) {
         renderEventArgs.commons.execServer = false;		 
		 //renderEventArgs.commons.api.vc.viewState.QV_TSRSE1342_26.toolbar.CEQV_201_QV_TSRSE1342_26_253.visible = false;

    };