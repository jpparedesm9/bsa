// (Button) 
task.executeCommand.CM_TCSTMRKO_C00 = function(entities, executeCommandEventArgs) {
	var valueCurp = entities.NaturalPerson.documentNumber;
	var valueRFC = entities.NaturalPerson.identificationRFC;
	var valueCodSantander = entities.NaturalPerson.santanderCode;
	var valueCuentaIndiv = entities.NaturalPerson.accountIndividual;
	var updateCuentaCodIndiv = 'S'
	
	if (entities.NaturalPerson.santanderCode == null)
	    entities.NaturalPerson.santanderCode = ''
		
	if (entities.NaturalPerson.accountIndividual  == null)
	    entities.NaturalPerson.accountIndividual = ''
		
	if (entities.NaturalPerson.santanderCode == '' && entities.NaturalPerson.accountIndividual == '')
		updateCuentaCodIndiv = 'N'
	
	if ((entities.NaturalPerson.santanderCode == '' && entities.NaturalPerson.accountIndividual != '') ||
	    (entities.NaturalPerson.santanderCode != '' && entities.NaturalPerson.accountIndividual == '' ))
        updateCuentaCodIndiv = 'S'
	
	if (updateCuentaCodIndiv == 'N') {
	    if(valueCurp.length == 18){
	    	if(valueRFC.length == 13){
	    		    executeCommandEventArgs.commons.execServer = true;
	    	}else{
	    		executeCommandEventArgs.commons.execServer = false;
	    		executeCommandEventArgs.commons.messageHandler.showMessagesError('El RFC debe tener 13 car\u00E1cteres');
	    	}
	    }else{
	    	executeCommandEventArgs.commons.execServer = false;
	    	executeCommandEventArgs.commons.messageHandler.showMessagesError('El N\u00FAmero de Documento debe tener 18 car\u00E1cteres');
	    }
	} else {
	    if(valueCurp.length == 18){
	    	if(valueRFC.length == 13){
	    		if(valueCodSantander.length == 8){
	    			if(valueCuentaIndiv.length == 12){
	    				executeCommandEventArgs.commons.execServer = true;
	    			}else{
	    				executeCommandEventArgs.commons.execServer = false;
	    				executeCommandEventArgs.commons.messageHandler.showMessagesError('La Cuenta Individual debe tener 12 car\u00E1cteres');
	    			}
	    		}else{
	    		    executeCommandEventArgs.commons.execServer = false;
	    			executeCommandEventArgs.commons.messageHandler.showMessagesError('El C\u00F3digo Santander debe tener 8 car\u00E1cteres');			
	    		}
	    	}else{
	    		executeCommandEventArgs.commons.execServer = false;
	    		executeCommandEventArgs.commons.messageHandler.showMessagesError('El RFC debe tener 13 car\u00E1cteres');
	    	}
	    }else{
	    	executeCommandEventArgs.commons.execServer = false;
	    	executeCommandEventArgs.commons.messageHandler.showMessagesError('El N\u00FAmero de Documento debe tener 18 car\u00E1cteres');
	    }
	}
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
};