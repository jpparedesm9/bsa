//Entity: DataCreditLine
    //DataCreditLine. (Button) View: DataCreditLineForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONBRDWHKX_111425 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.DataCreditLine = true;
    };