//Entity: LegalPerson
    //LegalPerson. (Button) View: GeneralLegalPerson
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    //Busca la persona en función del código
    task.executeCommand.VA_VABUTTONECKBAAP_763218 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.serverParameters.LegalPerson = true;
        executeCommandEventArgs.commons.serverParameters.LegalRepresentative = true;
        executeCommandEventArgs.commons.serverParameters.EconomicInformationLegalPerson = true;
       
    };