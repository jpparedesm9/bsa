//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestions
    task.initDataCallback.VC_DATAVERION_567496 = function (entities, initDataEventArgs){
		var viewState = initDataEventArgs.commons.api.viewState;
		var grid = initDataEventArgs.commons.api.grid;
		if(entities.Context.enable === 'N'){
			grid.disabledColumn('QV_5932_10558','answer');
			grid.disabledColumn('QV_7780_54457','answer');
			var ctrs = ['VC_DATAVERION_567496']
			BUSIN.API.disable(viewState, ctrs);
		}	        
    };