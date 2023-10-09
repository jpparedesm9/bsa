//Entity: EconomicInformation
    //EconomicInformation.operatingCost (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OPERATINGCOSTTT_884168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableBalance(entities.EconomicInformation, changedEventArgs);
        task.calculateAvailableTotal(entities.EconomicInformation);
        
    };