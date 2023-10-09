// (Button) Cancelar
    task.executeCommand.CM_CRNTO32CAL78 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal("");
    };