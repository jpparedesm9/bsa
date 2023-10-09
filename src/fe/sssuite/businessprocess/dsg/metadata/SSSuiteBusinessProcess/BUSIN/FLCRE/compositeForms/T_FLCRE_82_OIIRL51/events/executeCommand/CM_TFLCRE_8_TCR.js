// (Button) 
task.executeCommand.CM_TFLCRE_8_TCR = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.serverParameters.Context = true;
    executeCommandEventArgs.commons.serverParameters.OriginalHeader = true;
    if (entities.OriginalHeader.IDRequested > 0) { //si existe tramite envia a Sincronizar con el movil
        executeCommandEventArgs.commons.execServer = true;
    }
    else {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError("BUSIN.LBL_BUSIN_NOSEPUEDEEI_81326")
    }
};