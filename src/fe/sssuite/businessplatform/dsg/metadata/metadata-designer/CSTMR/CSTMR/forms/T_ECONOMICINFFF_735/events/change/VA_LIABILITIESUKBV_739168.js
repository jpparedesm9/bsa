//Entity: EconomicInformation
    //EconomicInformation.liabilities (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_LIABILITIESUKBV_739168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableResults(entities.EconomicInformation);
   
        
    };