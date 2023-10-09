// (Button) 
task.executeCommand.CM_TPROSPEC_MR6 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.serverParameters.NaturalPerson = true;

    if (entities.NaturalPerson.documentNumber == null) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_DEBECOMSL_54956', true);
        executeCommandEventArgs.commons.execServer = false;
    }
};