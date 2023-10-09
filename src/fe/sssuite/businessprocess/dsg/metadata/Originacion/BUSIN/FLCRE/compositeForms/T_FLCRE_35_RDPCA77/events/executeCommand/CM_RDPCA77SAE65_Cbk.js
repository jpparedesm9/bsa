//Start signature to callBack event to CM_RDPCA77SAE65
    task.executeCommandCallback.CM_RDPCA77SAE65 = function(entities, executeCommandEventArgs) {
        BUSIN.INBOX.STATUS.nextStep(executeCommandEventArgs.success,executeCommandEventArgs.commons.api);
    };