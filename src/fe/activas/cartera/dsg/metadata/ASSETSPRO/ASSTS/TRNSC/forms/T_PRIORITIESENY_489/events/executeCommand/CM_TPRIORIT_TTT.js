// (Button) 
    task.executeCommand.CM_TPRIORIT_TTT = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var dataGrid = {
            data: entities.Priorities
            }
        executeCommandEventArgs.commons.api.navigation.closeModal(dataGrid);
    };