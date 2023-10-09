//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONDGDOXOG_649263 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        if (entities.MassivePaymentFile.fileName == undefined || entities.MassivePaymentFile.fileName == null || entities.MassivePaymentFile.fileName == ""){
            executeCommandEventArgs.commons.messageHandler.showMessagesError("Debe elegir un archivo");
        }
        
    };