// (Button) 
    //Guardar Rubros (Button) 
    task.executeCommand.CM_CTORY86ARB39 = function(entities, executeCommandEventArgs) {
		executeCommandEventArgs.commons.execServer = false;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
		
		//permite validar que los rubros ya existan en la tabla de Category
		var ds1 = executeCommandEventArgs.commons.api.parentVc.model.Category;
		//var ds2 = executeCommandEventArgs.commons.api.parentVc.model.CategoryNew;
		var dsData1 = ds1.data();
		//var dsData2 = ds2.data();
		var flag=false;
		var validateItem = true;
		var validateItemReadjustment = true; 
		
		executeCommandEventArgs.commons.serverParameters.PaymentPlanHeader = true;
		executeCommandEventArgs.commons.serverParameters.Category = true; 
		executeCommandEventArgs.commons.serverParameters.CategoryReadjustment = true; 
		validateItem = task.validateItem(entities, executeCommandEventArgs);
		if(generalParameterLoan.exchangeRate == 'S' && ((entities.Category.itemType == 'I' || entities.Category.itemType == 'M') || 
			( entities.Category.ConceptType == 'I' || entities.Category.ConceptType == 'M'))){			
			validateItemReadjustment = task.validateItemReadjustment(entities, executeCommandEventArgs);			
		}
		
		if(validateItem && validateItemReadjustment){
			for (var i = 0; i < dsData1.length; i ++) {
				var dsRow1 = dsData1[i];
				if (entities.Category.isNew && dsRow1.Concept.trim()==entities.Category.Concept){
					executeCommandEventArgs.commons.execServer = false;
					executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_EXSTERUBR_34155');
					flag=true;
					break;
				}
			}
			executeCommandEventArgs.commons.execServer = true;
		}else{
			executeCommandEventArgs.commons.execServer = false;
		}
        
    };