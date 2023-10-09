//Entity: NaturalPerson
    //NaturalPerson. (Button) View: CustomerGeneralInfForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRNZGSZY_345213 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;
        entities.Context.accountIndividual = entities.NaturalPerson.accountIndividual;
    };