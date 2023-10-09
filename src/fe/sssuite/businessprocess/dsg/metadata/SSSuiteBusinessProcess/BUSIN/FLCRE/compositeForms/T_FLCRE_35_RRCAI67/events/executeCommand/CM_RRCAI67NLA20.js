// (Button) Cancelar
    task.executeCommand.CM_RRCAI67NLA20 = function(entities, executeCommandEventArgs) {
       executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal("");
        
    };