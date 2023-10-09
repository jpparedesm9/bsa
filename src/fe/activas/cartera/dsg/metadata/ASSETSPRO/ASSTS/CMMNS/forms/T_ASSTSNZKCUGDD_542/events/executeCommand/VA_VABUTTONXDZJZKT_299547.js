//Entity: ConciliationManualSearchFilter
    //ConciliationManualSearchFilter. (Button) View: ConciliationManualSearchForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONXDZJZKT_299547 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.api.grid.removeAllRows('ConciliationManualSearch');
    executeCommandEventArgs.commons.api.grid.refresh('QV_9498_38003');
        //executeCommandEventArgs.commons.serverParameters.ConciliationManualSearchFilter = true;
    };