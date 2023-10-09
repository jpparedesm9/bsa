//Entity: CustomerExclusionList
    //CustomerExclusionList. (Button) View: ExclusionList
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONARFKGXV_821111 = function(  entities, executeCommandEventArgs ) {

    if (entities.CustomerExclusionList.customerId == '' && entities.CustomerExclusionList.score == '' ) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.viewState.refreshData('VA_SCORENCQIGXRWIM_712111')
    }else{
        executeCommandEventArgs.commons.execServer = true; 
    }
        
    
   // executeCommandEventArgs.commons.api.grid.refresh("QV_9905_87019",{customerId:entities.CustomerExclusionList.customerId});
        //executeCommandEventArgs.commons.serverParameters.CustomerExclusionList = true;
    };