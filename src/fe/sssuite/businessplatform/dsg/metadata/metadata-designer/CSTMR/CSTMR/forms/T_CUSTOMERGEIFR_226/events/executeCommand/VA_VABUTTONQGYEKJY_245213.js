//Entity: NaturalPerson
//NaturalPerson. (Button) View: CustomerGeneralInfForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONQGYEKJY_245213 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    //executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;
    entitiesTmp = entities;
    if(gnralInfoSelected>0){
        executeCommandEventArgs.commons.execServer = false;
    }
    if (entities.CustomerTmp.code == null) {
        entities.CustomerTmp.code = entities.NaturalPerson.personSecuential;

    }
};