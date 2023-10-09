//Entity: SpousePerson
    //SpousePerson. (Button) View: CustomerSpouseForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONOARJENM_541425 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
        
        if(entities.SpousePerson.personSecuential === null){
            entities.SpousePerson.personSecuential = 0;
        }
    
        
       
        //executeCommandEventArgs.commons.serverParameters.SpousePerson = true;
    };