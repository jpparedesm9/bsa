//Entity: Credit
    //Credit. (Button) View: AmountForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONAICSAKZ_975190 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Group = true;
        executeCommandEventArgs.commons.serverParameters.Amount = true;
        executeCommandEventArgs.commons.execServer = true;    
    };