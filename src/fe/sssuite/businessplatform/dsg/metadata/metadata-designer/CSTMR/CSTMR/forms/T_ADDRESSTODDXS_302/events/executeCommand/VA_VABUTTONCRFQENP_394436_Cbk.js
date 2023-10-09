//Start signature to callBack event to VA_VABUTTONCRFQENP_394436
task.executeCommandCallback.VA_VABUTTONCRFQENP_394436 = function (entities, executeCommandCallbackEventArgs) {
    //here your code
    if (executeCommandCallbackEventArgs.success) {
        if (executeCommandCallbackEventArgs.commons.api.vc.mode === executeCommandCallbackEventArgs.commons.constants.mode.Insert) {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_ADDRESSJWN_806436');
        } else if (executeCommandCallbackEventArgs.commons.api.vc.mode === executeCommandCallbackEventArgs.commons.constants.mode.Update) {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818', '', 2000, false);
        }

        if (entities.PhysicalAddress.directionNumberInternal === -1) {
            entities.PhysicalAddress.directionNumberInternal = null;
        }

    } else {
        entities.PhysicalAddress.isMainAddress = false;
    }
};