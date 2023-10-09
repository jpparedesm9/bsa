//Entity: CustomerTmp
    //CustomerTmp. (Button) View: ReferencesForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONOKQWNLY_810576 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    if (entities.CustomerTmpReferences.code==null){
    entities.CustomerTmpReferences.code = entities.NaturalPerson.personSecuential;
        ban = false;
    }
    executeCommandEventArgs.commons.serverParameters.CustomerTmpReferences = true;
    executeCommandEventArgs.commons.serverParameters.References= true;
    
};