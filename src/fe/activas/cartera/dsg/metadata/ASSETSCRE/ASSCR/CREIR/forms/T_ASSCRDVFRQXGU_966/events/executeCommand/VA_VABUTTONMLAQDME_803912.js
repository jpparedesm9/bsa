//Entity: LoginCallCenter
//LoginCallCenter. (Button) View: CallCenterPopupQuestions
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONMLAQDME_803912 = function (entities, executeCommandEventArgs) {

    if (entities.LoginCallCenter.idCliente == null || entities.LoginCallCenter.idCliente === '' || entities.LoginCallCenter.idCliente == undefined) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELCDIGOOO_78756', true)
        executeCommandEventArgs.commons.execServer = false;

    } else {
        executeCommandEventArgs.commons.execServer = true;
    }

    //executeCommandEventArgs.commons.serverParameters.LoginCallCenter = true;
};