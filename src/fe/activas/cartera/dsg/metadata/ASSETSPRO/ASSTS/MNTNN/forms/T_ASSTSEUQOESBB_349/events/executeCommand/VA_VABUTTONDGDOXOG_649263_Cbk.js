//Start signature to Callback event to VA_VABUTTONDGDOXOG_649263
task.executeCommandCallback.VA_VABUTTONDGDOXOG_649263 = function(entities, executeCommandCallbackEventArgs) {
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
      if (entities.MassivePaymentFile.fileName == undefined || entities.MassivePaymentFile.fileName == null || entities.MassivePaymentFile.fileName == ""){
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("Debe elegir un archivo");
            viewState.disable('VA_VABUTTONMYCSNRW_701263');
        }
    else{

        if(executeCommandCallbackEventArgs.success){
            if(entities.MassivePaymentFile.fileObservations == 0){
                viewState.enable('VA_VABUTTONMYCSNRW_701263');
            }
        }else{
            viewState.disable('VA_VABUTTONMYCSNRW_701263');
            entities.MassivePaymentFile.fileObservations=0
            entities.MassivePaymentFile.processedRecords = 0
            entities.MassivePaymentFile.processedAmount = 0
        }
    }
};