// (Button) Cancelar
    task.executeCommand.CM_TAONE32CAR77 = function(entities, executeCommandEventArgs) {
       executeCommandEventArgs.commons.execServer = false;
		
		executeCommandEventArgs.commons.api.vc.closeModal("");
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };