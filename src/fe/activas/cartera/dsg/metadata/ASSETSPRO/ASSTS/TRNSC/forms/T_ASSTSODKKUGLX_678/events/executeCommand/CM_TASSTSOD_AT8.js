// (Button) 
    task.executeCommand.CM_TASSTSOD_AT8 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.serverParameters.ConciliationSearch = true;
    };