//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments.FlowType (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SHCTRATNIW7705_LTYE544 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
		var ctrs=['VA_SHCTRATNIW7705_AMTI124'], viewState = changeEventArgs.commons.api.viewState, nemonicReclamos = entities.Context.Type ;
		if(entities.SearchCriteriaPrintingDocuments.FlowType === nemonicReclamos){
			BUSIN.API.show(viewState,ctrs);
		}else {
			BUSIN.API.hide(viewState,ctrs);
		}
        
    };