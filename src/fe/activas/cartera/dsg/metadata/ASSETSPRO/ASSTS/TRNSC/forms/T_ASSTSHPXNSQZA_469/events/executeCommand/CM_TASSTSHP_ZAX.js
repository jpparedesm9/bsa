// (Button) 
    task.executeCommand.CM_TASSTSHP_ZAX = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;      
        if (entities.ProcessInstance.transactionNumber != null){
            executeCommandEventArgs.commons.execServer = true;
        }else {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_GRUPONOAO_46111", true);   
        }
        
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };