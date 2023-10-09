//Entity: ResetImageMessage
//ResetImageMessage. (Button) View: ResetMessageImage
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONKOXRDID_200225 = function (entities, executeCommandEventArgs) {

    executeCommandEventArgs.commons.execServer = true;

    entities.ResetImageMessage.codResetClient = codClienteReset;


};