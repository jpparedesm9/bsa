//Entity: Business
    //Business. (Button) View: BusinessPopupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONYULNPZK_374246 = function(  entities, executeCommandEventArgs ) {
    
    executeCommandEventArgs.commons.execServer = true;
    
    executeCommandEventArgs.commons.serverParameters.Business = true;
    executeCommandEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    
    if(entities.Business.numberOfBusiness == null){
        entities.Business.numberOfBusiness = 0;
    }
    if(entities.Business.timeActivity == null){
        entities.Business.timeActivity = 0;
    }
    if(entities.Business.timeBusinessAddress == null){
        entities.Business.timeBusinessAddress = 0;
    }
    if(entities.Business.mountlyIncomes == null){
        entities.Business.mountlyIncomes = 0;
    }
    
    
};