//Entity: ReferenceReq
//ReferenceReq. (Button) View: ValidateReferenceForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONTLJBFIX_730945 = function(  entities, executeCommandEventArgs ) {
    executeCommandEventArgs.commons.execServer = false;
    task.cleanFields(entities,executeCommandEventArgs);
};