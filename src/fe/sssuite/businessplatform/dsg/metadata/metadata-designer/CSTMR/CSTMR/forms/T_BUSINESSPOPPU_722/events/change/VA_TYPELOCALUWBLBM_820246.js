//Entity: Business
    //Business.typeLocal (ComboBox) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TYPELOCALUWBLBM_820246 = function(  entities, changedEventArgs ) {
    changedEventArgs.commons.execServer = false;
    /*if(entities.Business.typeLocal == '3'){ //Mismo que Domicilio (Opción del combo para ejecución)
        
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
        if(entities.Business.economicActivity == null){
            entities.Business.economicActivity = '';
        }
        if(entities.Business.turnaround == null){
            entities.Business.turnaround = '';
        }
        if(entities.Business.resources == null){
            entities.Business.resources = '';
        }
        
        changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.serverParameters.Business = true;
        changedEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    } else {
        changedEventArgs.commons.execServer = false;
        
        if(entities.Business.timeActivity == 0){
            entities.Business.timeActivity = null;
        }
        if(entities.Business.timeBusinessAddress == 0){
            entities.Business.timeBusinessAddress = null;
        }
        if(entities.Business.mountlyIncomes == 0){
            entities.Business.mountlyIncomes = null;
        }
        if(entities.Business.economicActivity == ''){
            entities.Business.economicActivity = null;
        }
        if(entities.Business.turnaround == ''){
            entities.Business.turnaround = null;
        }
        if(entities.Business.resources == ''){
            entities.Business.resources = null;
        }
        
        entities.Business.street = null;
        entities.Business.numberOfBusiness = null;
        entities.Business.postalCode = null;
        
    }*/
    
    
    //changedEventArgs.commons.serverParameters.Business = true;
};