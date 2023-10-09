// (Button) 
task.executeCommand.CM_OIIRL51SVE80 = function (entities, executeCommandEventArgs) {
    if (task.validateRenderSection(entities, executeCommandEventArgs)) {
        if (task.validateEntities(entities)) {
            if (entities.Alicuota.Alicuota === "N" && entities.Alicuota.CtaAhorros !== undefined && entities.Alicuota.CtaCertificada !== undefined) {
                executeCommandEventArgs.commons.execServer = true;
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_AUOBLNOON_98811', '', 3000, true);
            } else {
                executeCommandEventArgs.commons.execServer = true;
            }
        } else {
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSNCAYDTA_60795', '', 3000, true);
        }
    } else {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('FINPM.DLB_FINPM_AILALIDIM_74169');
    }
};