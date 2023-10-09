// (Button) 
    task.executeCommand.CM_TFLCRE_9_98R = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.serverParameters.Operations = true;
		executeCommandEventArgs.commons.serverParameters.generalData = true;
		executeCommandEventArgs.commons.serverParameters.Punishment = true;
		
    };