//Entity: Entity1
    //Entity1. (Button) View: ExclusionList
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONCMTSGNP_601111 = function(  entities, executeCommandEventArgs ) {

        executeCommandEventArgs.commons.execServer = false; 
        
        executeCommandEventArgs.commons.api.grid.refresh('QV_9905_87019', {customerId:entities.CustomerExclusionList.customerId});
    
    };