//Entity: CustomerTmp
    //CustomerTmp. (Button) View: BusinessForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONJPSJYQV_906304 = function(  entities, executeCommandEventArgs ) {
    
    executeCommandEventArgs.commons.execServer = true;
    if (entities.CustomerTmpBusiness.code == null){
    entities.CustomerTmpBusiness.code = entities.NaturalPerson.personSecuential;
        ban = false;
    }
    executeCommandEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    executeCommandEventArgs.commons.serverParameters.Business= true;
};