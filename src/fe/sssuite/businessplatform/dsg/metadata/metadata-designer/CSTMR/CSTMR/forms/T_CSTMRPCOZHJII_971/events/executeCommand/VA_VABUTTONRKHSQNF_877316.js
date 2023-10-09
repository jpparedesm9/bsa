//Entity: Entity2
    //Entity2. (Button) View: AuthorizationTransferCommentary
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRKHSQNF_877316 = function(  entities, executeCommandEventArgs ) {
        
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal({
        resultArgs: {
            rejectionReason: entities.Entity2.attribute1
        }});
    };