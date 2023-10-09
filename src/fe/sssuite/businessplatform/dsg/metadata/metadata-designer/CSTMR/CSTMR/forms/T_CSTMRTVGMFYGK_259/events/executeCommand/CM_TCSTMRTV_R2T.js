// (Button) 
task.executeCommand.CM_TCSTMRTV_R2T = function (entities, executeCommandEventArgs) {
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
    var reject = false;
    if (entities.AuthorizationTransferRequest.data() != null) {
        var autorizationrequests = entities.AuthorizationTransferRequest.data();
        for (var i = 0; i < autorizationrequests.length; i++) {
            if (autorizationrequests[i].isChecked) {
                reject = true;
                break;
            }
        }
    }
    if (reject) {
        return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("Seguro desea rechazar la solicitud").then(function (resp) {
            switch (resp.buttonIndex) {
            case 0: //cancel
                executeCommandEventArgs.commons.execServer = false;
                return false;
                break;
            case 1: //accept
                executeCommandEventArgs.commons.execServer = false;

                //Open Modal
                var nav = executeCommandEventArgs.commons.api.navigation;

                nav.label = 'Raz\u00f3n de Rechazo';
                nav.address = {
                    moduleId: 'CSTMR',
                    subModuleId: 'CSTMR',
                    taskId: 'T_CSTMRPCOZHJII_971',
                    taskVersion: '1.0.0',
                    viewContainerId: 'VC_AUTHORIZER_104971'
                };
                nav.queryParameters = {
                    mode: 2
                };
                nav.modalProperties = {
                    size: 'sm',
                    callFromGrid: false
                };

                //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
                nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
                //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
                //nav.openModalWindow(id, args.modelRow);

                return true;
                break;
            }
        });
    } else {
    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEESCDR_77549');
        executeCommandEventArgs.commons.execServer = false;
    }

};