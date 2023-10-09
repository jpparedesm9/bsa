//ResultQueryByFilterQuery Entity: 
task.executeQuery.Q_RESULTYR_9784 = function (executeQueryEventArgs) {

    if ((executeQueryEventArgs.parameters.clientId == null || executeQueryEventArgs.parameters.clientId == "") && (executeQueryEventArgs.parameters.codDocumentType == null || executeQueryEventArgs.parameters.codDocumentType == "") && (executeQueryEventArgs.parameters.loanNumber == null || executeQueryEventArgs.parameters.loanNumber == "") && (executeQueryEventArgs.parameters.procedureNumber == null || executeQueryEventArgs.parameters.procedureNumber == "")) {        
        executeQueryEventArgs.commons.messageHandler.showTranslateMessagesError('ASSTS.MSG_ASSTS_NOSEHALLA_81795');	
        executeQueryEventArgs.commons.execServer = false;
    } else {
        if (executeQueryEventArgs.parameters.clientId != null && executeQueryEventArgs.parameters.clientType == null) {
            executeQueryEventArgs.parameters.clientType = 'P';
        }
        if (executeQueryEventArgs.parameters.clientId == null && executeQueryEventArgs.parameters.clientType != null) {
            executeQueryEventArgs.parameters.clientType = null;
        }
        executeQueryEventArgs.commons.execServer = true;
    }

};