//Start signature to callBack event to CM_TLEGALPE_CLM
task.executeCommandCallback.CM_TLEGALPE_CLM = function (entities, executeCommandEventArgs) {
    if (executeCommandEventArgs.success) {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_LOSDATOEC_59556', '', 2000, false);
        if (executeCommandEventArgs.commons.api.parentVc.model != null && executeCommandEventArgs.commons.api.parentVc.model != undefined && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage != null && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage == undefined) {
            executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
        if (section != null) {
            var response = {
                operation: "U",
                section: section,
                clientId: entities.LegalPerson.personSecuential
            };
            executeCommandEventArgs.commons.api.vc.parentVc.responseEvent(response);
        }
    } else {
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_ERRORALLI_56664');
    }
};