//Entity: CustomerTmp
//CustomerTmp. (Button) View: AddressForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONYDIJDRL_132566 = function (entities, executeCommandEventArgs) {

    executeCommandEventArgs.commons.execServer = true;
    if (entities.CustomerTmp.code == null) {
        entities.CustomerTmp.code = entities.NaturalPerson.personSecuential;
        ban = false;
    }
    executeCommandEventArgs.commons.serverParameters.CustomerTmp = true;
    executeCommandEventArgs.commons.serverParameters.VirtualAddress = true;
    executeCommandEventArgs.commons.serverParameters.PhysicalAddress = true;
    executeCommandEventArgs.commons.serverParameters.Context = true;

};