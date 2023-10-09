//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: Category
	task.initDataCallback.VC_CTORY86_CTEGO_587 = function(entities, initDataEventArgsCallback) {
		var viewState = initDataEventArgsCallback.commons.api.viewState;
		task.formatFields(entities, initDataEventArgsCallback);
		task.disableEnableFields(viewState, entities, entities.Category.isNew);
		task.enableReadjustmentSection(entities, initDataEventArgsCallback, generalParameterLoan.exchangeRate);
	};