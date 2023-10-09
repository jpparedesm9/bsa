//Entity: EconomicInformation
    //EconomicInformation.assets (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ASSETSGNFTVVLMX_315168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        task.calculateAvailableResults(entities.EconomicInformation);
        
    };