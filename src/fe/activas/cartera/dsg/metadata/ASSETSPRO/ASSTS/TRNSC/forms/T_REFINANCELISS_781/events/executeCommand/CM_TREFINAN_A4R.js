// (Button) 
    task.executeCommand.CM_TREFINAN_A4R = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        var hasError = false;
        var msgResourceID = "";
        
        if (entities.RefinanceLoanFilter.clientID == null || entities.RefinanceLoanFilter.clientID == 0)  {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_DEDESELCA_14854"
        }
        if (!hasError && (entities.RefinanceLoanFilter.currencyType == null || entities.RefinanceLoanFilter.currencyType == '')) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_DEDESELNC_61580"
        }
        
        if (hasError) {
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
        }        
    };