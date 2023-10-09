//Entity: Loan
//Loan. (Button) View: PreCancellationLoanReference
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONTGCIJOQ_898796 = function (entities, executeCommandEventArgs) {
    if (entities.Loan.clientID != null) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.api.viewState.enable("CM_TASSTSCX__8X");
        executeCommandEventArgs.commons.api.viewState.enable("CM_TASSTSCX_S1_");
    }
    else{
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_ESNECESNI_47620", true);
    }
};