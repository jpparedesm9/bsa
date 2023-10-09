//Entity: UnusualOperations
    //UnusualOperations. (Button) View: AddAlertsForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONOGPGXMU_783527 = function(  entities, executeCommandCallbackEventArgs ) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        if(executeCommandCallbackEventArgs.success){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576','', 2000,false);
            entities.UnusualOperations.typeOperation = null;
            entities.UnusualOperations.highDate = null;
            entities.UnusualOperations.reportDate = null;
            entities.UnusualOperations.customerName = null;
            entities.UnusualOperations.commentary = null;
            entities.UnusualOperations.customerSecondName = null;
            entities.UnusualOperations.customerSurname = null;
            entities.UnusualOperations.customerSecondSurname = null;
            var grid = executeCommandCallbackEventArgs.commons.api.grid;
            grid.refresh('QV_1129_31576');
        }
    };