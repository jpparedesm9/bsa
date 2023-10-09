//Entity: Entity2
    //Entity2. (Button) View: RelationForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONAPPHYWK_615954 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;        
         if (entities.RelationContext.secuential==null){         
        entities.RelationContext.secuential = entities.NaturalPerson.personSecuential;        
       }
        //alert ("uno");
        //executeCommandEventArgs.commons.serverParameters.Entity2 = true;
        
        
    };