//Entity: Entity2
    //Entity2. (Button) View: RelationForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONAPPHYWK_615954 = function(  entities, executeCommandEventArgs ) {
    
        //Mensaje en caso de que el cliente tenga estado civil casado pero no tenga creada la relación
	var result = null;
	if(entities.NaturalPerson.maritalStatusCode == casado){
		if(entities.SpousePerson.personSecuential == null){
            result = 1;
			
		}
	}
	if(result == 1){ //ERROR: CREAR RELACION CON CONYUGE
		executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo('Crear relaci\u00f3n con Conyuge',true);
	}
	
    executeCommandEventArgs.commons.execServer = false;
    if(numsecuential!=0){
        task.hideButtonGridMember(executeCommandEventArgs, 'RelationPerson', 'QV_6114_93961');
    } 
    
        
    };