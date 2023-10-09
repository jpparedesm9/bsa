//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONVBEQBSD_442263 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
      
            var viewState = executeCommandEventArgs.commons.api.viewState;
         viewState.disable('VA_VABUTTONMYCSNRW_701263');
        entities.MassivePaymentFile.fileObservations = 0;
        entities.MassivePaymentFile.processedRecords = 0;
        entities.MassivePaymentFile.processedAmount = 0;

    };