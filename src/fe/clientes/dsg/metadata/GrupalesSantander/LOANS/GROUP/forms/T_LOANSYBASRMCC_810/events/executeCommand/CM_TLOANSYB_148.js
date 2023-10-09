// (Button) 
    task.executeCommand.CM_TLOANSYB_148 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;

        entities.FilterSimulation = null;
        executeCommandEventArgs.commons.api.grid.removeAllRows("InformationSimulation")
        
    };