//Entity: Mobile
//Mobile. (Button) View: MobilePopUpForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONODIGQRB_255864 = function (entities, executeCommandEventArgs) {

    if ((entities.Mobile.imei == null || entities.Mobile.imei == "") || (entities.Mobile.imei != null && entities.Mobile.imei.length >= LONG_IMEI)) {
        executeCommandEventArgs.commons.execServer = true;
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('MBILE.MSG_MBILE_ELIMEIINO_31530');
        executeCommandEventArgs.commons.serverParameters.Mobile = false;
    }

};