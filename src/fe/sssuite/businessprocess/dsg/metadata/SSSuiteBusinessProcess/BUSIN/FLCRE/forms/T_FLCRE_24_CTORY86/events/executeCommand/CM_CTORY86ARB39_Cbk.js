// (Button) 
	task.executeCommandCallback.CM_CTORY86ARB39 = function(entities, executeCommandCallbackEventArgs) {
		var api = executeCommandCallbackEventArgs.commons.api;
		var data =api.vc.model.Category;
		var parentGrid = api.parentApi().grid;
		var	entity = 'Category';
		
		if(executeCommandCallbackEventArgs.success){				
			data.Concept = entities.Category.Concept;
			data.ConceptDescription = task.getConceptDescription(executeCommandCallbackEventArgs, data.Concept);
			data.Sign= entities.Category.Sign;
			data.Reference=entities.Category.Reference;
			data.ConceptType=entities.Category.ConceptType;
			parentGrid.collapseRow("QV_QERYI6962_42", data);
			if(entities.Category.MethodOfPayment!=null && entities.Category.MethodOfPayment.trim() == 'P'){
				executeCommandCallbackEventArgs.commons.api.parentVc.executeCommand('CM_TPYEP21MTE89',
				'Compute', '', true, false, 'VC_TPYEP21_FAETL_814', false);
			}
			executeCommandCallbackEventArgs.commons.api.parentVc.model.Category.sync();//sincronizo los datos de la grilla
			executeCommandCallbackEventArgs.commons.api.vc.closeModal(data);			
		}
	};