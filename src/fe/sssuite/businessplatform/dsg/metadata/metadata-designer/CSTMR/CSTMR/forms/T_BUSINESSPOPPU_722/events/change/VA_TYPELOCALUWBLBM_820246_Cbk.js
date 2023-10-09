//Entity: Business
    //Business.typeLocal (ComboBox) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.changeCallback.VA_TYPELOCALUWBLBM_820246 = function(  entities, changedCallbackEventArgs ) {
    /*
    if(entities.Business.numberOfBusiness == 0){
        entities.Business.numberOfBusiness = null;
    }
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
    */
    changedCallbackEventArgs.commons.execServer = false;
    
};