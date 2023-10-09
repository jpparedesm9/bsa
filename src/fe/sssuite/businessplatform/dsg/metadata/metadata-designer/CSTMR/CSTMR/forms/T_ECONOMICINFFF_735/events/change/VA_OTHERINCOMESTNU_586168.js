//Entity: EconomicInformation
    //EconomicInformation.otherIncomes (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_OTHERINCOMESTNU_586168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableIncome(entities.EconomicInformation);
        task.calculateAvailableBalance(entities.EconomicInformation,changedEventArgs);
        
    };