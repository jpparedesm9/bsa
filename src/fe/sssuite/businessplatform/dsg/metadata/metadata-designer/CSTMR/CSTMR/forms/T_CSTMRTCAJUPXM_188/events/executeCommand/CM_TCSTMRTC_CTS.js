// (Button) 
task.executeCommand.CM_TCSTMRTC_CTS = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.serverParameters.TransferRequest = true;
    var createRequest = false;
    if (entities.CustomerTransferRequest.data() != null) {
        var requests = entities.CustomerTransferRequest.data();
        for (var i = 0; i < requests.length; i++) {
            if (requests[i].isChecked) {
                createRequest = true;
                break;
            }
        }
    }

    if (createRequest) {
        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("Seguro desea crear la solicitud").then(function (resp) {
            switch (resp.buttonIndex) {
            case 0: //cancel
                executeCommandEventArgs.commons.execServer = false;
                return false;
                break;
            case 1: //accept
                executeCommandEventArgs.commons.execServer = true;
                executeCommandEventArgs.commons.serverParameters.TransferRequest = true;
                executeCommandEventArgs.commons.serverParameters.CustomerTransferRequest = true;
                return true;
                break;
            }
        });
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEESCRU_94493');
        executeCommandEventArgs.commons.execServer = false;
    }


};