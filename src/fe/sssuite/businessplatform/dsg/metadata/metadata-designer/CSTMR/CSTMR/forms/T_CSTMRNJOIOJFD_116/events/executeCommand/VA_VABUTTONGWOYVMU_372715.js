//Entity: AltairAccount
    //AltairAccount. (Button) View: ReplaceAltairAccount
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONGWOYVMU_372715 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                mode: executeCommandEventArgs.commons.api.vc.mode,
                accountIndividual: entities.AltairAccount.oldAccountIndividual
            }});
    };