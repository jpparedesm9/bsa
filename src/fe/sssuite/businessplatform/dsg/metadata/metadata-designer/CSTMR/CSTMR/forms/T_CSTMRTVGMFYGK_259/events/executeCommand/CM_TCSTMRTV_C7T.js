// (Button) 
task.executeCommand.CM_TCSTMRTV_C7T = function (entities, executeCommandEventArgs) {
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
    var authorize = false;
    if (entities.AuthorizationTransferRequest.data() != null) {
        var autorizationrequests = entities.AuthorizationTransferRequest.data();
        for (var i = 0; i < autorizationrequests.length; i++) {
            if (autorizationrequests[i].isChecked) {
                authorize = true;
                break;
            }
        }
    }
    if (authorize) {
        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("Seguro desea autorizar la solicitud").then(function (resp) {
            switch (resp.buttonIndex) {
            case 0: //cancel
                executeCommandEventArgs.commons.execServer = false;
                return false;
                break;
            case 1: //accept
                executeCommandEventArgs.commons.execServer = true;
                return true;
                break;
            }
        });
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEESCAU_39994');
        executeCommandEventArgs.commons.execServer = false;
    }
};