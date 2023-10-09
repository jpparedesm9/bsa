// (Button) Aceptar
    task.executeCommand.CM_TAONE32TAR13 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		
		var rowHeaderPunishment = entities.HeaderPunishment;
   		executeCommandEventArgs.commons.api.vc.closeModal(rowHeaderPunishment);
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };