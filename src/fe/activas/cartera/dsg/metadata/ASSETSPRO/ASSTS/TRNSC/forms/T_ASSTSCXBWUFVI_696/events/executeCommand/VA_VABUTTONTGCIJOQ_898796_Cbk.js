//Entity: Loan
//Loan. (Button) View: PreCancellationLoanReference
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommandCallback.VA_VABUTTONTGCIJOQ_898796 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    if (entities.PreCancellation.amountPRE == null || entities.PreCancellation.amountOP == null || entities.PreCancellation.amountPRE == '' || entities.PreCancellation.amountOP == '') {
        executeCommandEventArgs.commons.api.viewState.disable("CM_TASSTSCX__8X");
        executeCommandEventArgs.commons.api.viewState.disable("CM_TASSTSCX_S1_");
        executeCommandEventArgs.commons.messageHandler.showMessagesError("No existe registro para el Cliente ingresado", true);
    }
};