//Entity: EconomicInformation
    //EconomicInformation.sales (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SALESPRFYEHZSYT_162168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        task.calculateAvailableIncome(entities.EconomicInformation);
        task.calculateAvailableBalance(entities.EconomicInformation,changedEventArgs);
   
    };