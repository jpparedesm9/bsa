//Entity: EconomicInformation
    //EconomicInformation.availableBalance (TextInputBox) View: EconomicInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AVAILABLEBALCNN_776168 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        //task.calculateAvailableBalance(entities.EconomicInformation,changedEventArgs);
        task.ableSaveButton(entities.EconomicInformation,changedEventArgs);
    };