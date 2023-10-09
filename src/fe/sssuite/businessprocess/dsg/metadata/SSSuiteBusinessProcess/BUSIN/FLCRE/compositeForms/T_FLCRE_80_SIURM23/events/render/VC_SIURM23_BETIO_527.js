//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: TaskDisbursementFormExecution
    task.render = function(entities, renderEventArgs) {
		var viewState = renderEventArgs.commons.api.viewState;
		var ctrs = ['GR_DISURMETFR51_06'];
		BUSIN.API.hide(viewState,ctrs);
		//$("#VC_SIURM23_BETIO_527").attr("style","padding-top:0px")//ajuste en el estilo, pasarse a estilos de base
	};