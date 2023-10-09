//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: AuthorizationTransferForm
    task.onCloseModalEventCallback = function (entities, onCloseModalCallbackEventArgs){
        onCloseModalCallbackEventArgs.commons.execServer = false;
        if (onCloseModalCallbackEventArgs.success) {
            onCloseModalCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
            onCloseModalCallbackEventArgs.commons.api.grid.refresh('QV_8174_44016');
        } else {
            onCloseModalCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
        }
    };