//Entity: Category
    //Category.Concept (ComboBox) View: Category
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.changeCallback.VA_ATACATEGRY1902_COEP019 = function(entities, changedCallbackEventArgs) {
		var viewState = changedCallbackEventArgs.commons.api.viewState;
		task.formatFields(entities, changedCallbackEventArgs);
		if(entities.Category.Sign != null && entities.Category.Sign.trim()!=""){
			viewState.enable('VA_ATACATEGRY1902_SIGN784');
		}else{
			viewState.disable('VA_ATACATEGRY1902_SIGN784');
		}
		task.enableReadjustmentSection(entities, changedCallbackEventArgs, generalParameterLoan.exchangeRate);
		viewState.disable('VA_ATACATEGRY1902_ECRI253'); 
	};