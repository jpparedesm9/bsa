//Entity: CustomerTmp
//CustomerTmp. (Button) View: AddressForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONWVQOBVO_763566 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    //executeCommandEventArgs.commons.serverParameters.CustomerTmp = true;
    entities.Context.addressState = 'S';
    entities.Context.mailState = 'S';
};