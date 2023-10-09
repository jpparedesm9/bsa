// (Button) 
    task.executeCommandCallback.CM_TCSTMRTC_CTS = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        if (executeCommandCallbackEventArgs.success) {
            //Set del campo HiddenInCompleted para poder continuar la tarea
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9850_34524');
        } else {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORENRR_59536');
        }
    };