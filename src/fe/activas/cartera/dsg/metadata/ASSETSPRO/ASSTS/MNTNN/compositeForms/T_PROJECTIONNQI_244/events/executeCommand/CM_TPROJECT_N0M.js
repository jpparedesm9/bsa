// (Button) 
    task.executeCommand.CM_TPROJECT_N0M = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        if (entities.Loan.status == 'NO VIGENTE' || entities.Loan.status == 'CANCELADO' || entities.Loan.status == 'CREDITO' || entities.Loan.status == 'COMEX') {
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesInformation('ASSTS.MSG_ASSTS_ESTADONPO_17159', true);
        }
    };