//Entity: Credit
//Credit. (Button) View: AmountForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONGPPUIHN_830190 = function (entities, executeCommandEventArgs) {
    if ((executeCommandEventArgs.commons.api.parentVc.model.Task.taskSubject == 'INGRESAR SOLICITUD') && (entities.Credit.creditCode > 0 )) {
        entities.Credit.nameActivity = nameActivity;
        executeCommandEventArgs.commons.serverParameters.Credit = true;
        executeCommandEventArgs.commons.execServer = true;
    }
    else {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError("LOANS.LBL_LOANS_NOSEPUEUN_82756")
    }    
};