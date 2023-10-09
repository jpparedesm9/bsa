//Start signature to Callback event to CM_TASSTSOD_AT8
task.executeCommandCallback.CM_TASSTSOD_AT8 = function (entities, executeCommandCallbackEventArgs) {

    if (executeCommandCallbackEventArgs.success) {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("ASSTS.MSG_ASSTS_SEDEBERZE_11976", '', 2000, false);
        entities.ConciliationSearch.conciliate = true;
        var result = {conciliationSearch: entities.ConciliationSearch };
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);

    }
};